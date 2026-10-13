"""Check published source text and review metadata before building."""
from pathlib import Path
import csv, io, re, subprocess, sys
from datetime import date

binary = sys.argv[1] if len(sys.argv) > 1 else 'hugo'
rows = csv.DictReader(io.StringIO(subprocess.check_output([binary, 'list', 'all']).decode('utf-8-sig')))
errors = []
count = 0
pending = 0
for row in rows:
    if row['draft'].lower() == 'true' or row['kind'] != 'page':
        continue
    count += 1
    path = Path(row['path'])
    text = path.read_text(encoding='utf-8-sig')
    front = text.split('---', 2)[1] if text.startswith('---') else ''
    if '\ufffd' in text or '待补充' in text:
        errors.append(f'{path}: broken characters or empty source/measurement placeholders')
    is_pending = bool(re.search(r'^contentStatus:\s*["\']?pending', front, re.M))
    reviewed = re.search(r'^reviewedAt:\s*["\']?(\d{4}-\d{2}-\d{2})', front, re.M)
    if reviewed:
        try:
            if date.fromisoformat(reviewed.group(1)) > date.today():
                errors.append(f'{path}: future review date')
        except ValueError:
            errors.append(f'{path}: invalid review date')
    if is_pending:
        pending += 1
        if reviewed or '来源待核查' not in text and '仍待核查' not in text:
            errors.append(f'{path}: pending sources must have a visible explanation and no review date')
    if re.search(r'^homeFeatured:\s*true', front, re.M) and (not reviewed or is_pending):
        errors.append(f'{path}: home selection requires a completed review')
if not count or errors:
    print('\n'.join(errors) or 'No published pages')
    sys.exit(1)
print(f'PASS: {count} published source pages; {pending} explicitly pending source reviews')
