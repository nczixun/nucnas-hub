---
title: "Day 6: 椋炵墰OS Docker鍏ラ棬 鈥斺€� 鎵撻€犱竾鑳絅AS"
date: 2026-03-12
summary: "瀛︿範Docker鍩虹锛屽湪椋炵墰OS涓婇儴缃插悇绉嶅簲鐢ㄣ€�"
categories: ["nas"]
slug: "fnos-day6-docker"
tags: ["椋炵墰OS", "Docker", "瀹瑰櫒", "搴旂敤"]
---

# Day 6: 椋炵墰OS Docker鍏ラ棬


## 浠€涔堟槸<a href="/guide/docker-best-practice/" target="_blank">Docker</a>锛�

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏄竴涓鍣ㄥ钩鍙帮紝璁╁簲鐢ㄥ湪浠讳綍鐜閮借兘杩愯銆�

## 涓轰粈涔堢敤<a href="/guide/docker-best-practice/" target="_blank">Docker</a>锛�

- ?? 涓€娆￠厤缃紝鍒板杩愯
- ?? 杞绘澗鏇存柊
- ?? 骞插噣鍗歌浇
- ?? 鐢熸€佷赴瀵�

## 瀹夎<a href="/guide/docker-best-practice/" target="_blank">Docker</a>

椋炵墰OS Web鐣岄潰鐩存帴鏀寔锛�
```
搴旂敤涓績 鈫� Docker 鈫� 瀹夎
```

## 甯哥敤<a href="/guide/docker-best-practice/" target="_blank">Docker</a>搴旂敤

### 1. 閮ㄧ讲QBittorrent

```yaml
version: '3'
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
    volumes:
      - ./config:/config
      - ./downloads:/downloads
    ports:
      - "8080:8080"
      - "6881:6881"
    restart: unless-stopped
```

### 2. 閮ㄧ讲 <a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> 濯掍綋鏈嶅姟鍣�

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
```

---

<div class="page-nav">
  <a href="/guide/fnos-day5-remote/" rel="prev">涓婁竴椤碉細Day 5锛氶鐗汷S杩滅▼璁块棶</a>
  <a href="/guide/fnos-day7-backup/" rel="next">涓嬩竴椤碉細Day 7锛氶鐗汷S鏁版嵁澶囦唤</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
