---
title: "Day 6: 妞嬬偟澧癘S Docker閸忋儵妫� 閳ユ柡鈧拷 閹垫捇鈧姳绔鹃懗绲匒S"
date: 2026-03-12
summary: "鐎涳缚绡凞ocker閸╄櫣顢呴敍灞芥躬妞嬬偟澧癘S娑撳﹪鍎寸純鎻掓倗缁夊秴绨查悽銊ｂ偓锟�"
categories: ["nas"]
slug: "fnos-day6-docker"
tags: ["妞嬬偟澧癘S", "Docker", "鐎圭懓娅�", "鎼存梻鏁�"]
---

# Day 6: 妞嬬偟澧癘S Docker閸忋儵妫�


## 娴犫偓娑斿牊妲�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閿涳拷

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閺勵垯绔存稉顏勵啇閸ｃ劌閽╅崣甯礉鐠佲晛绨查悽銊ユ躬娴犺缍嶉悳顖氼暔闁€熷厴鏉╂劘顢戦妴锟�

## 娑撹桨绮堟稊鍫㈡暏<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閿涳拷

- ?? 娑撯偓濞嗭繝鍘ょ純顕嗙礉閸掓澘顦╂潻鎰攽
- ?? 鏉炵粯婢楅弴瀛樻煀
- ?? 楠炴彃鍣ｉ崡姝屾祰
- ?? 閻㈢喐鈧椒璧寸€碉拷

## 鐎瑰顥�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>

妞嬬偟澧癘S Web閻ｅ矂娼伴惄瀛樺复閺€顖涘瘮閿涳拷
```
鎼存梻鏁ゆ稉顓炵妇 閳拷 Docker 閳拷 鐎瑰顥�
```

## 鐢摜鏁�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鎼存梻鏁�

### 1. 闁劎璁睶Bittorrent

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

### 2. 闁劎璁� <a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> 婵帊缍嬮張宥呭閸ｏ拷

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
```

---

<div class="page-nav">
  <a href="/guide/fnos-day5-remote/" rel="prev">娑撳﹣绔存い纰夌窗Day 5閿涙岸顥ｉ悧姹稴鏉╂粎鈻肩拋鍧楁６</a>
  <a href="/guide/fnos-day7-backup/" rel="next">娑撳绔存い纰夌窗Day 7閿涙岸顥ｉ悧姹稴閺佺増宓佹径鍥﹀敜</a>
</div>

*閺堫剚鏋冮悽锟� NUC NAS Hub 閼奉亜濮╅悽鐔稿灇*
