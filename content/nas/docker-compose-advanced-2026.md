---
title: "Docker Compose 杩涢樁鏁欑▼锛歂AS 涓婃墜 docker-compose.yml 鍐欐硶"
date: 2026-03-08
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
platform: "docker"
slug: "docker-compose-advanced-guide-2026"
tags: ["Docker Compose", "NAS", "Docker", "瀹瑰櫒", "杩涢樁鏁欑▼"]
---

# Docker Compose 杩涢樁鏁欑▼锛歂AS 涓婃墜 docker-compose.yml 鍐欐硶

浼氱敤 Docker 浣嗕笉浜嗚В Docker Compose锛熻繖绡囨枃绔犳墜鎶婃墜鏁欎綘鐢� docker-compose 绠＄悊 NAS 涓婄殑鏈嶅姟銆�

## 浠€涔堟槸 Docker Compose锛�

Docker Compose 鏄� Docker 瀹樻柟鎻愪緵鐨勫鍣ㄧ紪鎺掑伐鍏凤紝閫氳繃涓€涓� `docker-compose.yml` 鏂囦欢瀹氫箟澶氫釜瀹瑰櫒锛屼竴閿惎鍔ㄣ€佸仠姝€€佸浠姐€�

**瀵规瘮浼犵粺 Docker 鍛戒护锛�**
- 浼犵粺锛氫竴涓鍣ㄤ竴鏉″懡浠わ紝澶嶆潅
- Compose锛氫竴涓枃浠剁鎵€鏈夛紝绠€鍗�

## 蹇€熷紑濮�

### 1. 瀹夎 Docker Compose

```bash
# Docker Desktop 鑷甫
# 缇ゆ櫀锛氬浠朵腑蹇冨畨瑁� Docker
# 缁胯仈/鏋佺┖闂达細搴旂敤涓績涓€閿畨瑁�
# 楠岃瘉瀹夎
docker compose version
```

### 2. 鍒涘缓 docker-compose.yml

鍦� NAS 涓婃柊寤烘枃浠跺す锛屼緥濡� `/docker/jellyfin`锛屾柊寤� `docker-compose.yml`锛�

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    ports:
      - "8096:8096"
      - "8920:8920"
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /volume1/media:/media:ro
    environment:
      - TZ=Asia/Shanghai
      - JELLYFIN_PublishedServerUrl=http://your-nas-ip:8096
```

### 3. 鍚姩鏈嶅姟

```bash
# 杩涘叆鐩綍
cd /docker/jellyfin

# 鍚姩鎵€鏈夋湇鍔�
docker compose up -d

# 鏌ョ湅鐘舵€�
docker compose ps

# 鏌ョ湅鏃ュ織
docker compose logs -f
```

## 杩涢樁閰嶇疆

### 澶氬鍣ㄧ紪鎺�

涓€涓枃浠剁鐞嗗涓湇鍔★細

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    ports:
      - "8096:8096"
    volumes:
      - ./jellyfin/config:/config
      - /volume1/media:/media:ro

  alist:
    image: xhofe/alist:latest
    container_name: alist
    restart: unless-stopped
    ports:
      - "5244:5244"
    volumes:
      - ./alist:/opt/alist/data
    environment:
      - TZ=Asia/Shanghai
```

### 鐜鍙橀噺鏂囦欢

鏂板缓 `.env` 鏂囦欢锛�

```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

鍦� compose 涓紩鐢細

```yaml
environment:
  - TZ=${TZ}
  - PUID=${PUID}
```

### 缃戠粶閰嶇疆

```yaml
networks:
  nas_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24

services:
  app:
    networks:
      - nas_network
```

### 鍋ュ悍妫€鏌�

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
```

### 璧勬簮闄愬埗

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 4G
        reservations:
          cpus: '0.5'
          memory: 512M
```

## 甯哥敤鍛戒护

| 鍛戒护 | 璇存槑 |
| :--- | :--- |
| `docker compose up -d` | 鍚庡彴鍚姩 |
| `docker compose down` | 鍋滄骞跺垹闄� |
| `docker compose restart` | 閲嶅惎 |
| `docker compose logs -f` | 鏌ョ湅鏃ュ織 |
| `docker compose pull` | 鏇存柊闀滃儚 |
| `docker compose up -d --force-recreate` | 寮哄埗閲嶅缓 |
| `docker compose config` | 楠岃瘉閰嶇疆 |

## 澶囦唤涓庤縼绉�

### 澶囦唤

```bash
# 澶囦唤閰嶇疆鏂囦欢
tar -czvf backup.tar.gz ./config .env docker-compose.yml
```

### 杩佺Щ

```bash
# 澶嶅埗鏁翠釜鏂囦欢澶瑰埌鏂拌澶�
# 閲嶆柊鍚姩
docker compose up -d
```

## 甯歌闂

**Q锛氱鍙ｅ啿绐佹€庝箞鍔烇紵**
A锛氫慨鏀� ports 閮ㄥ垎鐨勪笉鍚岀鍙ｆ槧灏勩€�

**Q锛氬浣曟洿鏂板鍣紵**
A锛歚docker compose pull` 鐒跺悗 `docker compose up -d`銆�

**Q锛氭暟鎹浣曟寔涔呭寲锛�**
A锛氫娇鐢� volumes 鎸傝浇瀹夸富鏈虹洰褰曘€�

**Q锛氬鍣ㄥ惎鍔ㄥけ璐ワ紵**
A锛歚docker compose logs` 鏌ョ湅閿欒淇℃伅銆�

## 鎺ㄨ崘缁勫悎

- **褰遍煶涓績**锛欽ellyfin + QBittorrent + Alist
- **涓嬭浇鏈�**锛歈Bittorrent + Transmission + Alist
- **HomeLab**锛欰dGuard + Nginx Proxy Manager + Portainer

## 鎬荤粨

Docker Compose 鏄鐞� NAS 瀹瑰櫒鐨勭鍣ㄣ€備竴涓枃浠剁鎵€鏈夛紝鍐嶄篃涓嶆€曞鍣ㄤ贡璺戙€傛帉鎻¤繖浜涙妧宸э紝浣犵殑 NAS 杩愮淮鑳藉姏浼氭彁鍗囦竴涓。娆°€�