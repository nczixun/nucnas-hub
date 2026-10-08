"""Audit local HTML links without network requests; print unresolved destinations.

Usage: python scripts/audit_links.py public [report.json]
External HTTP availability is deliberately not inferred from this build check.
"""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urljoin, urlsplit, unquote
import json
import sys

root = Path(sys.argv[1] if len(sys.argv) > 1 else "public")

class Links(HTMLParser):
    def __init__(self, text):
        super().__init__()
        self.links = []
        self.ids = set()
        self.feed(text)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if attrs.get("id"):
            self.ids.add(attrs["id"])
        if tag == "a" and attrs.get("href"):
            self.links.append(attrs["href"])

files = {p.relative_to(root).as_posix() for p in root.rglob("*") if p.is_file()}
pages = {p: Links((root / p).read_text(encoding="utf-8")) for p in files if p.endswith(".html")}
missing, fragments = {}, {}
for path, page in pages.items():
    base = "https://www.nucnas.top/" + path.removesuffix("index.html")
    for href in page.links:
        url = urlsplit(urljoin(base, href))
        if url.scheme not in ("http", "https") or url.netloc not in ("www.nucnas.top", "nucnas.top"):
            continue
        dest = unquote(url.path).lstrip("/")
        if dest not in files:
            dest = dest.rstrip("/") + "/index.html" if dest else "index.html"
        if dest not in files:
            missing.setdefault(url.path, set()).add(path)
        elif url.fragment and dest in pages and unquote(url.fragment) not in pages[dest].ids:
            fragments.setdefault(url.path + "#" + url.fragment, set()).add(path)
report = {"pages": len(pages), "missing": {k: sorted(v) for k, v in sorted(missing.items())},
          "fragments": {k: sorted(v) for k, v in sorted(fragments.items())}}
if len(sys.argv) > 2:
    Path(sys.argv[2]).write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
print(f"Audited {len(pages)} HTML pages: {len(missing)} missing destinations, {len(fragments)} missing fragments")
