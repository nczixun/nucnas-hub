"""Verify generated search, metadata and critical navigation using only Python stdlib."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit, unquote, parse_qs
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

required=["index.html","search/index.html","posts/index.html","hardware/index.html","nas/index.html","ai/index.html","calculator/index.html","404.html","start/index.html","openclaw/index.html","nas-roadmap/index.html","local-ai-roadmap/index.html","corrections/index.html"]
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
for route in ("/start/", "/nas-roadmap/", "/local-ai-roadmap/"):
    assert sum(p["url"] == route for p in pages) == 1, (route, "missing/duplicate search route")
for section in ("posts", "nas", "ai", "hardware"):
    path=f"{section}/page/2/index.html"
    page=Page((root/path).read_text(encoding="utf-8"))
    expected=f"https://www.nucnas.top/{section}/page/2/"
    assert page.canonicals == [expected], (path, "pagination canonical", page.canonicals)
    assert any(s.get("url")==expected for s in page.jsonld), (path, "schema URL mismatch")
    assert len(page.links)>10, (path, "pagination lost its articles")
assert "Sitemap: https://www.nucnas.top/sitemap.xml" in (root/"robots.txt").read_text(encoding="utf-8")
redirects=(root/"_redirects").read_text(encoding="utf-8")
for slug in ("openclaw-day2-platform-integration", "openclaw-day3-core-concepts", "openclaw-day5-automation-heartbeat", "openclaw-day7-deployment-security"):
    old=f"/openclaw/{slug}/"; target=f"/ai/{slug}/"
    assert f"{old} {target} 301" in redirects
    assert not any(p["url"]==old for p in pages), (old,"duplicate search result")
    assert sum(p["url"]==target for p in pages)==1, (target,"missing canonical search result")
    alias=(root/old.strip("/")/"index.html").read_text(encoding="utf-8")
    assert "https://www.nucnas.top"+target in alias, (old,"missing alias fallback")
for file in root.rglob("*.html"):
    page=Page(file.read_text(encoding="utf-8")) # JSON-LD must be valid on every page.
    if any(s.get("@type")=="Article" for s in page.jsonld):
        feedback=[u for u in page.links if u.startswith("https://github.com/nczixun/nucnas-hub/issues/new?")]
        assert len(feedback)==1, (file, "missing/duplicate feedback link")
        query=parse_qs(urlsplit(feedback[0]).query)
        assert page.canonicals[0] in query.get("body", [""])[0], (file, "incorrect feedback article URL")
        assert query.get("title", [""])[0].startswith("文章纠错："), (file, "feedback title")
        assert "/corrections/" in page.links, (file, "missing correction instructions")
sitemap=ET.parse(root/"sitemap.xml")
ns={"s":"http://www.sitemaps.org/schemas/sitemap/0.9"}
for url in sitemap.findall("s:url",ns):
    location=url.findtext("s:loc",namespaces=ns)
    assert location.startswith("https://www.nucnas.top/"), (location, "noncanonical host")
    assert exists(location), (location, "missing sitemap destination")
    path=unquote(urlsplit(location).path).lstrip("/")
    page=Page((root/path/"index.html").read_text(encoding="utf-8"))
    assert page.canonicals == [location], (location, "sitemap/canonical mismatch")
    assert not any("noindex" in r for r in page.robots), (location, "noindex in sitemap")
    assert all(s.get("url", location)==location for s in page.jsonld), (location, "schema URL mismatch")
    assert "/search/" not in location, "search page included in sitemap"
    assert "/tags/" not in location and "/categories/" not in location
    assert not any(location.endswith(f"/openclaw/{s}/") for s in ("openclaw-day2-platform-integration", "openclaw-day3-core-concepts", "openclaw-day5-automation-heartbeat", "openclaw-day7-deployment-security")), "duplicate sitemap entry"
    modified=url.findtext("s:lastmod",namespaces=ns)
    if modified:
        assert datetime.fromisoformat(modified.replace("Z","+00:00")).year > 1, (location, "zero lastmod")
print(f"PASS: {len(required)} critical routes, {len(pages)} search records, all JSON-LD and sitemap dates")
