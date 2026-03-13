---
title: "Docker Compose 鏉╂盯妯侀敍姘樋鐎圭懓娅掔紓鏍ㄥ笓鐎圭偞鍨幐鍥у础"
date: 2026-03-08
categories: ["nas"]
brand: "闁氨鏁�"
model: "Docker"
platform: "nas"
slug: "docker-compose-advanced-multi-container-2026"
tags: ["Docker Compose", "NAS", "鐎圭懓娅掔紓鏍ㄥ笓", "Docker 閺佹瑧鈻�", "鐎硅泛娑佃ぐ閬嶆珜"]
---

# Docker Compose 鏉╂盯妯侀敍姘樋鐎圭懓娅掔紓鏍ㄥ笓鐎圭偞鍨幐鍥у础

瀵板牆顦块悳鈺侇啀閸︼拷 NAS 娑撳﹪鍎寸純鎻掑礋娑擃亜顔愰崳銊ョ发缁犫偓閸楁洩绱濇担鍡涙桨鐎电懓顦跨€圭懓娅掗懕鏂垮З鐏忚京濮辨禍鍡涙閵嗗倷绮栨径鈺勵唹鐠侊拷 Docker Compose 鏉╂盯妯侀悳鈺傜《閿涘矁顔€娴ｇ姾浜ら弶鎯х杽閻滄澘顦查弶鍌涙箛閸斺剝鐏﹂弸鍕┾偓锟�

## 娑撹桨绮堟稊鍫ｎ洣閻拷 Docker Compose

閹靛濮╃粻锛勬倞婢舵矮閲滅€圭懓娅掗弮璁圭礉娴ｇ姴褰查懗浠嬩海閸掓媽绻栨禍娑㈡６妫版﹫绱�
- 鐎圭懓娅掗崥顖氬З妞ゅ搫绨ǎ铚傝础閿涘苯顕遍懛瀛樻箛閸斺€茬瑝閸欘垳鏁�
- 閻滎垰顣ㄩ崣姗€鍣虹€硅妲楃拋楣冩晩
- 閺囧瓨鏌婇悧鍫熸拱鐟曚椒绔存稉顏冮嚋閺€锟�
- 缁旑垰褰涢崘鑼崐閹靛彞绗夐崚鏉垮斧閸ワ拷

Docker Compose 闁俺绻� YAML 閺傚洣娆㈢紒鐔剁缁狅紕鎮婇敍灞肩濞嗏€虫儙閸斻劌鍙忛柈銊︽偠鐎规哎鈧拷

## 缂佸繐鍚€閸︾儤娅欓敍姘啀鎼搭厼濂栭梽銏犲弿鐎硅埖銆�

鏉╂瑦妲告稉鈧稉顏勫悁閸ㄥ娈戞径姘啇閸ｃ劍鐏﹂弸鍕剁窗

```yaml
version: '3.8'

services:
  # 鐟欏棝顣剁粻锛勬倞
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

  # 瑜拌京澧栭崚顔煎
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

  # 娑撳娴囧銉ュ徔
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

  # 婵帊缍嬮弫瀵告倞
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

## 閸忔娊鏁柊宥囩枂鐟欙絾鐎�

### depends_on閿涙碍甯堕崚璺烘儙閸斻劑銆庢惔锟�
Jellyseerr 娓氭繆绂� Jellyfin閿涘苯鎮楅懓鍛躬閸撳秹娼伴崗鍫濇儙閸斻劊鈧倷绗夋潻鍥洣濞夈劍鍓伴敍宀冪箹閸欘亝妲�"閸氼垰濮╂い鍝勭碍"閿涘奔绗夐弰锟�"鐏忚京鍗庢い鍝勭碍"閵嗗倻鏁撴禍褏骞嗘晶鍐ㄧ紦鐠侇喚鏁ら崑銉ユ倣濡偓閺屻儯鈧拷

### network_mode: host vs bridge
Jellyfin 閻拷 host 濡€崇础閺勵垯璐熸禍鍡氬箯閸欐牕鍣涵顔炬畱濞撮攱濮ゆ晶娆嶁偓淇糱ittorrent 閸滐拷 radarr 閻拷 bridge 濡€崇础閿涘瞼顏崣锝夋缁傜粯娲跨€瑰鍙忛妴锟�

### PUID/PGID閿涙碍娼堥梽鎰版６妫帮拷
NAS 娑撳﹦娈戠€圭懓娅掔紒蹇撶埗闁洤鍩岄弶鍐闂傤噣顣介妴鍌炩偓姘崇箖 PUID=1000閿涘牅缍橀惃鍕暏閹寸īD閿涘鎷� PGID=1000 绾喕绻氶弬鍥︽鐠囪鍟撳锝呯埗閵嗭拷

## 鏉╂盯妯侀幎鈧锟�

### 1. 娴ｈ法鏁� .env 閺傚洣娆㈢粻锛勬倞閸欐﹢鍣�
閸掓稑缂� .env 閺傚洣娆㈤敍锟�
```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

閻掕泛鎮楅崷锟� compose 娑擃厼绱╅悽顭掔窗`${PUID}`

### 2. 閸嬨儱鎮嶅Λ鈧弻銉╁帳缂冿拷
```yaml
services:
  jellyfin:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8097/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 3. 闁插秴鎯庣粵鏍殣
- `no`閿涙矮绗夐懛顏勫З闁插秴鎯�
- `on-failure`閿涙艾銇戠拹銉︽闁插秴鎯�
- `unless-stopped`閿涙岸娅庨棃鐐村閸斻劌浠犲顫礉閸氾箑鍨稉鈧惄鎾櫢閸氾拷
- `always`閿涙碍鈧粯妲搁柌宥呮儙閿涘牊甯归懡鎰暏娴滐拷 NAS閿涳拷

## 娑撯偓闁款喖鎯庨崝銊ユ嚒娴狅拷

```bash
# 閸氼垰濮╅幍鈧張澶嬫箛閸旓拷
docker compose up -d

# 閺屻儳婀呴弮銉ョ箶
docker compose logs -f jellyfin

# 閺囧瓨鏌婇幍鈧張澶愭殔閸嶏拷
docker compose pull && docker compose up -d

# 閸嬫粍顒涢幍鈧張澶嬫箛閸旓拷
docker compose down
```

閹哄本褰� Docker Compose 閸氬函绱濇担鐘插讲娴犮儴浜ら弶鐐儗瀵わ拷 PLEX + Sonarr + Radarr + QBittorrent 閻ㄥ嫪绗呮潪钘夊焿閸撳﹣绔撮弶锟犵烦閿涘本鍨ㄩ懓锟� Home Assistant + Node-RED + InfluxDB 閻ㄥ嫭娅ら懗钘夘啀鐏炲懎閽╅崣鑸偓鍌氼槻閺夊倹婀囬崝鈽呯礉娑撯偓濞嗭繝鍎寸純璇х礉闂€鎸庢埂閸欐娉妴锟�