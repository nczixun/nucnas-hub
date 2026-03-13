---
title: "Docker Compose 杩涢樁锛氬瀹瑰櫒缂栨帓瀹炴垬鎸囧崡"
date: 2026-03-08
categories: ["nas"]
brand: "閫氱敤"
model: "Docker"
platform: "nas"
slug: "docker-compose-advanced-multi-container-2026"
tags: ["Docker Compose", "NAS", "瀹瑰櫒缂栨帓", "Docker 鏁欑▼", "瀹跺涵褰遍櫌"]
---

# Docker Compose 杩涢樁锛氬瀹瑰櫒缂栨帓瀹炴垬鎸囧崡

寰堝鐜╁鍦� NAS 涓婇儴缃插崟涓鍣ㄥ緢绠€鍗曪紝浣嗛潰瀵瑰瀹瑰櫒鑱斿姩灏辩姱浜嗛毦銆備粖澶╄璁� Docker Compose 杩涢樁鐜╂硶锛岃浣犺交鏉惧疄鐜板鏉傛湇鍔℃灦鏋勩€�

## 涓轰粈涔堣鐢� Docker Compose

鎵嬪姩绠＄悊澶氫釜瀹瑰櫒鏃讹紝浣犲彲鑳介亣鍒拌繖浜涢棶棰橈細
- 瀹瑰櫒鍚姩椤哄簭娣蜂贡锛屽鑷存湇鍔′笉鍙敤
- 鐜鍙橀噺瀹规槗璁鹃敊
- 鏇存柊鐗堟湰瑕佷竴涓釜鏀�
- 绔彛鍐茬獊鎵句笉鍒板師鍥�

Docker Compose 閫氳繃 YAML 鏂囦欢缁熶竴绠＄悊锛屼竴娆″惎鍔ㄥ叏閮ㄦ悶瀹氥€�

## 缁忓吀鍦烘櫙锛氬搴奖闄㈠叏瀹舵《

杩欐槸涓€涓吀鍨嬬殑澶氬鍣ㄦ灦鏋勶細

```yaml
version: '3.8'

services:
  # 瑙嗛绠＄悊
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    network_mode: host
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/media:/media:ro
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped

  # 褰辩墖鍒墛
  jellyseerr:
    image: fallenbagel/jellyseerr:latest
    container_name: jellyseerr
    ports:
      - "5055:5055"
    environment:
      - LOG_LEVEL=debug
      - TZ=Asia/Shanghai
    volumes:
      - ./jellyseerr:/app
    depends_on:
      - jellyfin
    restart: unless-stopped

  # 涓嬭浇宸ュ叿
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    ports:
      - "6881:6881"
      - "6881:6881/udp"
    volumes:
      - ./qbittorrent:/config
      - /mnt/downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
    restart: unless-stopped

  # 濯掍綋鏁寸悊
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: radarr
    ports:
      - "7878:7878"
    volumes:
      - ./radarr:/config
      - /mnt/media:/media
      - /mnt/downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000
    restart: unless-stopped

networks:
  default:
    name: media_network
```

## 鍏抽敭閰嶇疆瑙ｆ瀽

### depends_on锛氭帶鍒跺惎鍔ㄩ『搴�
Jellyseerr 渚濊禆 Jellyfin锛屽悗鑰呭湪鍓嶉潰鍏堝惎鍔ㄣ€備笉杩囪娉ㄦ剰锛岃繖鍙槸"鍚姩椤哄簭"锛屼笉鏄�"灏辩华椤哄簭"銆傜敓浜х幆澧冨缓璁敤鍋ュ悍妫€鏌ャ€�

### network_mode: host vs bridge
Jellyfin 鐢� host 妯″紡鏄负浜嗚幏鍙栧噯纭殑娴锋姤澧欍€俼bittorrent 鍜� radarr 鐢� bridge 妯″紡锛岀鍙ｉ殧绂绘洿瀹夊叏銆�

### PUID/PGID锛氭潈闄愰棶棰�
NAS 涓婄殑瀹瑰櫒缁忓父閬囧埌鏉冮檺闂銆傞€氳繃 PUID=1000锛堜綘鐨勭敤鎴稩D锛夊拰 PGID=1000 纭繚鏂囦欢璇诲啓姝ｅ父銆�

## 杩涢樁鎶€宸�

### 1. 浣跨敤 .env 鏂囦欢绠＄悊鍙橀噺
鍒涘缓 .env 鏂囦欢锛�
```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

鐒跺悗鍦� compose 涓紩鐢細`${PUID}`

### 2. 鍋ュ悍妫€鏌ラ厤缃�
```yaml
services:
  jellyfin:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8097/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 3. 閲嶅惎绛栫暐
- `no`锛氫笉鑷姩閲嶅惎
- `on-failure`锛氬け璐ユ椂閲嶅惎
- `unless-stopped`锛氶櫎闈炴墜鍔ㄥ仠姝紝鍚﹀垯涓€鐩撮噸鍚�
- `always`锛氭€绘槸閲嶅惎锛堟帹鑽愮敤浜� NAS锛�

## 涓€閿惎鍔ㄥ懡浠�

```bash
# 鍚姩鎵€鏈夋湇鍔�
docker compose up -d

# 鏌ョ湅鏃ュ織
docker compose logs -f jellyfin

# 鏇存柊鎵€鏈夐暅鍍�
docker compose pull && docker compose up -d

# 鍋滄鎵€鏈夋湇鍔�
docker compose down
```

鎺屾彙 Docker Compose 鍚庯紝浣犲彲浠ヨ交鏉炬惌寤� PLEX + Sonarr + Radarr + QBittorrent 鐨勪笅杞藉埉鍓婁竴鏉￠緳锛屾垨鑰� Home Assistant + Node-RED + InfluxDB 鐨勬櫤鑳藉灞呭钩鍙般€傚鏉傛湇鍔★紝涓€娆￠儴缃诧紝闀挎湡鍙楃泭銆�