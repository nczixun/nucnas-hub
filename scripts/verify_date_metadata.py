"""Ensure generated sitemap/Article dates match recorded editorial dates.

Checks the built output against published source files so a shallow hosting
checkout cannot silently refresh all content to its latest deployment commit.
Usage: python scripts/verify_date_metadata.py [build_dir] [hugo_binary]
"""
import csv,html,io,json,re,subprocess,sys
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote,urlsplit
from xml.etree import ElementTree as ET

build=Path(sys.argv[1] if len(sys.argv)>1 else 'public')
binary=sys.argv[2] if len(sys.argv)>2 else 'hugo'
rows=csv.DictReader(io.StringIO(subprocess.check_output([binary,'list','published']).decode('utf-8-sig')))
class Metadata(HTMLParser):
    def __init__(self,text):
        super().__init__()
        self.schemas=[]; self.capture=False; self.buffer=''
        self.feed(text)
    def handle_starttag(self,tag,attrs):
        if tag=='script' and dict(attrs).get('type')=='application/ld+json':
            self.capture=True; self.buffer=''
    def handle_data(self,text):
        if self.capture:self.buffer+=text
    def handle_endtag(self,tag):
        if tag=='script' and self.capture:
            self.schemas.append(json.loads(self.buffer)); self.capture=False
ns={'sm':'http://www.sitemaps.org/schemas/sitemap/0.9'}
sitemap={unquote(urlsplit(e.findtext('sm:loc',namespaces=ns)).path):e.findtext('sm:lastmod',namespaces=ns) for e in ET.parse(build/'sitemap.xml').getroot().findall('sm:url',ns)}
checked=0; article_checked=0
for row in rows:
    if row['draft'].lower()=='true' or row['kind']!='page':continue
    text=Path(row['path']).read_text(encoding='utf-8-sig')
    front=text.split('---',2)[1] if text.startswith('---') else ''
    expected=None
    for key in ['lastmod','modified','date','publishdate','pubdate','published']:
        m=re.search(r'^'+key+r':\s*["\']?(\d{4}-\d{2}-\d{2})',front,re.M|re.I)
        if m:expected=m[1];break
    if not expected:continue
    route=unquote(urlsplit(row['permalink']).path)
    actual=sitemap.get(route)
    if actual:assert actual[:10]==expected,(row['path'],'sitemap lastmod differs from source',expected,actual)
    output=(build/route.lstrip('/')/'index.html').read_text(encoding='utf-8')
    articles=[data for data in Metadata(output).schemas if data.get('@type')=='Article']
    section=row['section']
    if section in ('hardware','nas','ai','openclaw'):
        assert len(articles)==1,(row['path'],'missing/duplicate Article schema',len(articles))
    for data in articles:
        assert data['dateModified'][:10]==expected,(row['path'],'Article dateModified differs from source',expected,data['dateModified'])
        article_checked+=1
    checked+=1
assert checked>100,('too few editorial dates checked',checked)
assert article_checked>100,('too few Article schemas checked',article_checked)
home=(build/'index.html').read_text(encoding='utf-8')
title=html.unescape(re.search(r'<title>(.*?)</title>',home,re.S)[1])
assert title.count('NUC NAS Hub')==1,('home title repeats brand',title)
assert '最详细的硬件评测' not in home,'obsolete homepage measurement claim'
print(f'PASS: {checked} source dates and {article_checked} Article schemas match recorded editorial dates; home metadata accurate')
