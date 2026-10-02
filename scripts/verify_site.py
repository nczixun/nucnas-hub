"""Verify generated search, metadata and critical navigation using only Python stdlib."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit, unquote
from datetime import datetime
import json
import sys
import xml.etree.ElementTree as ET

root = Path(sys.argv[1] if len(sys.argv)>1 else "public")
class Page(HTMLParser):
    def __init__(self, text):
        super().__init__(convert_charrefs=True)
        self.canonicals=[]; self.descriptions=[]; self.robots=[]
        self.jsonld=[]; self.capture=False; self.buffer=""
        self.links=[]; self.assets=[]; self.h1=0
        self.feed(text)
    def handle_starttag(self, tag, attributes):
        a=dict(attributes)
        if tag=="h1": self.h1+=1
        if tag=="link" and a.get("rel")=="canonical": self.canonicals.append(a.get("href"))
        if tag=="meta" and a.get("name")=="description": self.descriptions.append(a.get("content"))
        if tag=="meta" and a.get("name")=="robots": self.robots.append(a.get("content",""))
        if tag=="a" and a.get("href"): self.links.append(a["href"])
        if tag=="script" and a.get("type")=="application/ld+json": self.capture=True; self.buffer=""
        if tag in ("img","script") and a.get("src"): self.assets.append(a["src"])
        if tag=="link" and a.get("rel")=="stylesheet": self.assets.append(a.get("href",""))
    def handle_data(self, text):
        if self.capture: self.buffer+=text
    def handle_endtag(self, tag):
        if tag=="script" and self.capture:
            self.jsonld.append(json.loads(self.buffer)); self.capture=False

def exists(url):
    path=unquote(urlsplit(url).path).lstrip("/")
    file=root/path
    return file.is_file() or (file/"index.html").is_file()

required=["index.html","search/index.html","posts/index.html","hardware/index.html","nas/index.html","ai/index.html","calculator/index.html","404.html"]
for path in required:
    text=(root/path).read_text(encoding="utf-8")
    page=Page(text)
    assert len(page.canonicals)==1, (path,"canonical count",page.canonicals)
    assert len(page.descriptions)==1, (path,"description count")
    assert page.h1==1, (path,"main heading count",page.h1)
    assert "\ufffd" not in text, (path,"replacement character")
    for url in page.links+page.assets:
        parts=urlsplit(url)
        if not parts.scheme and not parts.netloc and parts.path.startswith("/"):
            assert exists(url), (path,"broken navigation/asset",url)
    if path in ("search/index.html","404.html"):
        assert any("noindex" in r for r in page.robots), (path,"must not be indexed")

pages=json.loads((root/"index.json").read_text(encoding="utf-8"))
assert len(pages)>100, ("search index unexpectedly small",len(pages))
assert all(exists(page["url"]) for page in pages), "search result points to a missing page"
assert any("ollama" in page["title"].lower() for page in pages)
assert any("NAS" in page["title"] for page in pages)
for file in root.rglob("*.html"):
    Page(file.read_text(encoding="utf-8")) # JSON-LD must be valid on every page.
sitemap=ET.parse(root/"sitemap.xml")
ns={"s":"http://www.sitemaps.org/schemas/sitemap/0.9"}
for url in sitemap.findall("s:url",ns):
    location=url.findtext("s:loc",namespaces=ns)
    assert "/search/" not in location, "search page included in sitemap"
    assert "/tags/" not in location and "/categories/" not in location
    modified=url.findtext("s:lastmod",namespaces=ns)
    if modified: datetime.fromisoformat(modified.replace("Z","+00:00"))
print(f"PASS: {len(required)} critical routes, {len(pages)} search records, all JSON-LD and sitemap dates")
