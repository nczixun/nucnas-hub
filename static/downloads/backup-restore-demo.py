#!/usr/bin/env python3
"""Run a small, synthetic file-copy and restore consistency demonstration.

Python 3.9+; standard library only; no network or administrator rights needed.
Run without arguments to allocate a new temporary directory, or use:
    python backup-restore-demo.py --output-dir ./new-restore-demo

The chosen directory must not already exist. All source files are synthetic.
The program retains the intentionally damaged restore and creates another new
restore from the backup. It never deletes or overwrites an existing demo root.
Results are written to result.json inside that new directory.

This checks file paths, bytes and SHA-256 consistency only. Sibling directories
on one machine are NOT independent failure domains. This does not test a NAS,
backup software, historical versions, permissions, application consistency,
encryption keys, or disaster recovery. Keep a real, independent backup and test
its own documented restore procedure separately.
"""

import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import platform
import shutil
import stat
import sys
import tempfile
import time


DEMO_VERSION = "1.0.1"
SYNTHETIC_FILES = {
    "README.txt": b"Synthetic restore demo. No personal or production data.\n",
    "notes/setup.txt": b"A backup is useful only if its restore can be checked.\n",
    "config/example.json": b'{"demo": true, "purpose": "synthetic data", "contains_secrets": false}\n',
    "data/sample.bin": bytes(range(256)) * 4,
    "data/empty.bin": b"",
    "docs/恢复检查.txt": "这是合成演示文件，不含个人资料。\n".encode("utf-8"),
}


def utc_now():
    return datetime.now(timezone.utc).isoformat(timespec="milliseconds")


def is_redirect(path):
    """Reject links and Windows reparse points, including junctions, on 3.9+."""
    if path.is_symlink():
        return True
    try:
        attributes = path.lstat()
    except FileNotFoundError:
        return False
    reparse_flag = getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0x400)
    return bool(getattr(attributes, "st_file_attributes", 0) & reparse_flag)


def validate_root_path(root):
    for part in [root, *root.parents]:
        if is_redirect(part):
            raise ValueError("The output path must not contain a symbolic link or Windows reparse point.")


def new_root(requested):
    if requested is None:
        root = Path(tempfile.mkdtemp(prefix="synthetic-restore-demo-"))
        # Validate default temporary paths too, before any synthetic data is written.
        # If refused, retain our new empty directory; never remove other content.
        validate_root_path(root)
        return root
    candidate = Path(requested).expanduser().absolute()
    validate_root_path(candidate)
    if candidate.exists():
        raise ValueError("Output directory already exists. Choose a NEW directory; nothing was overwritten.")
    if not candidate.parent.is_dir():
        raise ValueError("The parent directory must already exist; choose a new directory directly inside it.")
    # mkdir is atomic and rejects a directory created between the checks above.
    candidate.mkdir(exist_ok=False)
    validate_root_path(candidate)
    return candidate


def create_synthetic_source(root):
    root.mkdir(exist_ok=False)
    for relative, contents in SYNTHETIC_FILES.items():
        target = root / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        with target.open("xb") as handle:
            handle.write(contents)


def file_record(path, root):
    digest = hashlib.sha256()
    size = 0
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(65536), b""):
            size += len(chunk)
            digest.update(chunk)
    return {"path": path.relative_to(root).as_posix(), "bytes": size, "sha256": digest.hexdigest()}


def manifest(root):
    files = []
    for entry in sorted(root.rglob("*")):
        if is_redirect(entry):
            raise ValueError("Unexpected redirect inside synthetic demo data; verification stopped.")
        if entry.is_file():
            files.append(file_record(entry, root))
    return {"file_count": len(files), "total_bytes": sum(row["bytes"] for row in files), "files": files}


def compare(expected, observed):
    expected_files = {row["path"]: row for row in expected["files"]}
    observed_files = {row["path"]: row for row in observed["files"]}
    missing = sorted(expected_files.keys() - observed_files.keys())
    unexpected = sorted(observed_files.keys() - expected_files.keys())
    changed = []
    for name in sorted(expected_files.keys() & observed_files.keys()):
        before, after = expected_files[name], observed_files[name]
        if before["bytes"] != after["bytes"] or before["sha256"] != after["sha256"]:
            changed.append({"path": name, "expected_bytes": before["bytes"], "observed_bytes": after["bytes"],
                            "expected_sha256": before["sha256"], "observed_sha256": after["sha256"]})
    return {"passed": not (missing or unexpected or changed), "missing": missing,
            "unexpected": unexpected, "changed": changed}


def run_demo(root):
    started = utc_now()
    clock_start = time.perf_counter()
    steps = []
    source = root / "source"
    backup = root / "backup"
    restored = root / "restored"
    recovered = root / "restored-again"

    step_started = utc_now()
    create_synthetic_source(source)
    reference = manifest(source)
    steps.append({"step": "create_synthetic_source", "started_at_utc": step_started,
                  "finished_at_utc": utc_now(), "directory": "source", "manifest": reference})

    for name, original, destination in [
        ("copy_to_backup", source, backup),
        ("restore_from_backup", backup, restored),
    ]:
        step_started = utc_now()
        shutil.copytree(original, destination, copy_function=shutil.copyfile)
        observed = manifest(destination)
        verification = compare(reference, observed)
        steps.append({"step": name, "started_at_utc": step_started, "finished_at_utc": utc_now(),
                      "directory": destination.name, "manifest": observed, "verification": verification})
        if not verification["passed"]:
            raise RuntimeError("Unexpected mismatch during synthetic backup or initial restore.")

    step_started = utc_now()
    # This file was created by this run. Preserve its damaged copy for inspection.
    modified_path = "data/sample.bin"
    with (restored / modified_path).open("ab") as handle:
        handle.write(b"\nINTENTIONAL_SYNTHETIC_TAMPER\n")
    damaged = manifest(restored)
    detected = compare(reference, damaged)
    steps.append({"step": "detect_intentional_tamper", "started_at_utc": step_started,
                  "finished_at_utc": utc_now(), "directory": "restored", "manifest": damaged,
                  "intentionally_modified_file": modified_path, "expected_passed": False,
                  "verification": detected})
    if (detected["passed"] or detected["missing"] or detected["unexpected"]
            or [row["path"] for row in detected["changed"]] != [modified_path]):
        raise RuntimeError("The intentional single-file modification was not detected as expected.")

    step_started = utc_now()
    # The new destination avoids deleting or overwriting the failed restore.
    shutil.copytree(backup, recovered, copy_function=shutil.copyfile)
    final_manifest = manifest(recovered)
    final_check = compare(reference, final_manifest)
    backup_check = compare(reference, manifest(backup))
    source_check = compare(reference, manifest(source))
    steps.append({"step": "restore_again_from_unchanged_backup", "started_at_utc": step_started,
                  "finished_at_utc": utc_now(), "directory": "restored-again", "manifest": final_manifest,
                  "verification": final_check, "backup_unchanged": backup_check["passed"],
                  "source_unchanged": source_check["passed"]})
    if not (final_check["passed"] and backup_check["passed"] and source_check["passed"]):
        raise RuntimeError("Final restore or unchanged-source checks failed.")

    return {
        "demo_version": DEMO_VERSION,
        "python_version": platform.python_version(),
        "python_implementation": platform.python_implementation(),
        "started_at_utc": started,
        "finished_at_utc": utc_now(),
        "elapsed_seconds": round(time.perf_counter() - clock_start, 6),
        "synthetic_data_only": True,
        "overall_passed": True,
        "expected_failure_detected": True,
        "independent_failure_domain_verified": False,
        "steps": steps,
        "scope": {
            "verified": ["relative file paths", "file count", "byte counts", "SHA-256", "intentional change detection", "second restore from unchanged backup"],
            "not_verified": ["independent devices or failure domains", "NAS backup software", "historical versions", "permissions or ownership", "application consistency", "encryption key recovery", "real disaster recovery"],
        },
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--output-dir", help="A new directory whose parent already exists. Existing directories are refused.")
    args = parser.parse_args()
    try:
        root = new_root(args.output_dir)
        result = run_demo(root)
        with (root / "result.json").open("x", encoding="utf-8") as handle:
            json.dump(result, handle, ensure_ascii=False, indent=2)
            handle.write("\n")
    except (OSError, ValueError, RuntimeError) as problem:
        print("Demo stopped: " + str(problem), file=sys.stderr)
        print("No existing demo root was overwritten or deleted. Any new partial demo is retained.", file=sys.stderr)
        return 1
    print("PASS: initial restore, expected tamper detection, and second restore.")
    print("Result: " + str(root / "result.json"))
    print("Scope: local synthetic file consistency only; no independent failure domain or NAS tested.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
