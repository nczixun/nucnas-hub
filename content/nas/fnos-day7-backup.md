---
title: "Day 7: 椋炵墰OS鏁版嵁澶囦唤涓庡悓姝� 鈥斺€� 瀹堟姢浣犵殑鏁版嵁瀹夊叏"
date: 2026-03-13
summary: "瀛︿範椋炵墰OS鐨勬暟鎹浠界瓥鐣ワ紝淇濇姢閲嶈鏁版嵁涓嶄涪澶便€�"
categories: ["nas"]
slug: "fnos-day7-backup"
tags: ["椋炵墰OS", "澶囦唤", "鍚屾", "鏁版嵁瀹夊叏"]
---

# Day 7: 椋炵墰OS鏁版嵁澶囦唤涓庡悓姝�


## 涓轰粈涔堥渶瑕佸浠斤紵

- ?? 纭洏浼氬潖
- ?? 绯荤粺浼氬穿
- ?? 璇垹鏂囦欢
- ?? 鍕掔储鐥呮瘨

## 澶囦唤绛栫暐

### 3-2-1 鍘熷垯
- 3浠芥暟鎹壇鏈�
- 2绉嶄笉鍚屽瓨鍌ㄤ粙璐�
- 1浠藉紓鍦板瓨鍌�

## 鏈湴澶囦唤

### 浣跨敤rsync

```bash
# 澶囦唤鍒板彟涓€涓‖鐩�
rsync -avz /source /backup

# 澧為噺澶囦唤
rsync -avz --delete /source /backup
```

### 浣跨敤<a href="/guide/docker-best-practice/" target="_blank">Docker</a>瀹瑰櫒

```yaml
version: '3'
services:
  duplicati:
    image: lscr.io/linuxserver/duplicati
    container_name: duplicati
    volumes:
      - ./config:/config
      - ./backups:/backups
      - /data:/source
    ports:
      - "8200:8200"
    restart: unless-stopped
```

## 浜戠鍚屾

### 1. Rclone閰嶇疆

```bash
# 瀹夎Rclone
curl https://rclone.org/install.sh | sudo bash

# 閰嶇疆
rclone config
```

---

<div class="page-nav">
  <a href="/guide/fnos-day6-docker/" rel="prev">涓婁竴椤碉細Day 6锛氶鐗汷S Docker搴旂敤</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
