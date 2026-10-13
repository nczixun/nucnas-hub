"""Check the recorded editorial evidence against current articles and Hugo routes.

This verifies consistency, not the truth of an external source. New factual edits
to these articles need an updated evidence record and a human source review.
"""
import csv,hashlib,io,json,re,subprocess,sys
from pathlib import Path
from urllib.parse import unquote,urlsplit

root=Path(__file__).resolve().parents[1]
records=json.loads((root/'docs/source-evidence-2026-10-13.json').read_text(encoding='utf-8'))
binary=sys.argv[1] if len(sys.argv)>1 else 'hugo'
routes={r['path'].replace('\\','/'):unquote(urlsplit(r['permalink']).path) for r in csv.DictReader(io.StringIO(subprocess.check_output([binary,'list','all'],cwd=root).decode('utf-8-sig')))}
errors=[]
seen=set()
for r in records:
    p=r['path']
    if p in seen: errors.append(f'{p}: duplicate evidence record')
    seen.add(p)
    text=(root/p).read_text(encoding='utf-8-sig')
    front=text.split('---',2)[1]
    if hashlib.sha256(text.encode()).hexdigest()!=r['newSha256']:
        errors.append(f'{p}: article changed since recorded evidence review')
    if routes.get(p)!=unquote(urlsplit(r['url']).path):
        errors.append(f'{p}: published route changed')
    if f'contentStatus: "{r["status"]}"' not in front:
        errors.append(f'{p}: article status disagrees with evidence record')
    if r['status']=='reviewed':
        if not r['claims'] or not r['sources'] or f'reviewedAt: "{r["auditedAt"]}"' not in front:
            errors.append(f'{p}: reviewed article lacks claims/sources/review date')
        for c in r['claims']:
            if c['claim'] not in text or c['source'] not in r['sources'] or c['source'] not in text:
                errors.append(f'{p}: claim or supporting source missing from article')
    elif not r['unresolved'] or 'reviewedAt:' in front or '来源待核查' not in text:
        errors.append(f'{p}: unresolved article must keep a visible pending status')
    for forbidden in ['score:','price:','radar:','pros:','cons:','bilibili_url:','youtube_url:']:
        if re.search(r'^'+re.escape(forbidden),front,re.M):
            errors.append(f'{p}: unsupported historical measurement metadata restored')
if not records or errors:
    print('\n'.join(errors) or 'No evidence records')
    sys.exit(1)
print(f'PASS: {len(records)} evidence records; {sum(r["status"]=="reviewed" for r in records)} reviewed, {sum(r["status"]=="pending" for r in records)} pending; routes preserved')
