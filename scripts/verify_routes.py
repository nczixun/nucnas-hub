"""Reject duplicate published content destinations before Hugo can overwrite output.

Usage: python scripts/verify_routes.py [hugo_binary]
"""
import csv
import io
import subprocess
import sys
from collections import defaultdict
from urllib.parse import unquote, urlsplit

binary = sys.argv[1] if len(sys.argv) > 1 else 'hugo'
rows = csv.DictReader(io.StringIO(subprocess.check_output([binary, 'list', 'all']).decode('utf-8-sig')))
routes = defaultdict(list)
for row in rows:
    if row['draft'].lower() == 'true' or row['kind'] != 'page':
        continue
    routes[unquote(urlsplit(row['permalink']).path)].append(row['path'])
duplicates = {url: paths for url, paths in routes.items() if len(paths) > 1}
if not routes or duplicates:
    for url, paths in duplicates.items():
        print(f'Duplicate published URL: {url}: {paths}')
    sys.exit(1)
print(f'PASS: {len(routes)} unique published content routes')
