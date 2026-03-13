---
title: "Docker Compose 杩涢樁鏁欑▼锛�2026骞村瀹瑰櫒缂栨帓"
date: 2026-01-01
categories: ["nas"]
summary: "Docker Compose 杩涢樁鏁欑▼锛屾暀浣犲浣曠紪鎺掑涓鍣�"
tags: ["Docker", "Docker Compose", "NAS", "瀹瑰櫒", "鏁欑▼"]
slug: "docker-compose-advanced-2026"
---

# Docker Compose 杩涢樁鏁欑▼锛�2026骞村瀹瑰櫒缂栨帓

## 浠€涔堟槸 Docker Compose锛�

Docker Compose 鏄竴涓敤浜庡畾涔夊拰杩愯澶氬鍣� Docker 搴旂敤鐨勫伐鍏枫€�

## 鍩虹璇硶

```yaml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
```

## 杩涢樁鎶€宸�

### 1. 鐜鍙橀噺

```yaml
services:
  database:
    image: postgres:15
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_DB=app
    env_file:
      - .env
```

### 2. 缃戠粶閰嶇疆

```yaml
services:
  web:
    build: .
    networks:
      - frontend
      - backend
  
  db:
    image: postgres:15
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # 闅旂缃戠粶
```

### 3. 鏁版嵁鎸佷箙鍖�

```yaml
services:
  mysql:
    image: mysql:8
    volumes:
      - mysql_data:/var/lib/mysql
      - ./conf:/etc/mysql/conf.d
      - ./logs:/var/log/mysql

volumes:
  mysql_data:
```

### 4. 渚濊禆鍏崇郴

```yaml
services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
  
  db:
    image: postgres:15
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U admin -d app"]
      interval: 10s
      timeout: 5s
      retries: 5
```

### 5. 閲嶅惎绛栫暐

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    restart: unless-stopped  # 濮嬬粓閲嶅惎锛岄櫎闈炴墜鍔ㄥ仠姝�
```

## 瀹屾暣绀轰緥锛氬搴奖闄�

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - jellyfin_config:/config
      - jellyfin_cache:/cache
      - /mnt/media:/media:ro
    ports:
      - "8096:8096"
      - "8920:8920"
    restart: unless-stopped
    networks:
      - home_lab

  adguard:
    image: adguard/adguardhome
    container_name: adguard
    volumes:
      - adguard_work:/opt/adguardhome/work
      - adguard_conf:/opt/adguardhome/conf
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000/tcp"
    restart: unless-stopped
    networks:
      - home_lab

  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    ports:
      - "9443:9443"
      - "9000:9000"
    restart: unless-stopped
    networks:
      - home_lab

networks:
  home_lab:
    driver: bridge

volumes:
  jellyfin_config:
  jellyfin_cache:
  adguard_work:
  adguard_conf:
  portainer_data:
```

## 甯哥敤鍛戒护

```bash
# 鍚姩鎵€鏈夋湇鍔�
docker compose up -d

# 鏌ョ湅鏃ュ織
docker compose logs -f

# 鍋滄鎵€鏈夋湇鍔�
docker compose down

# 閲嶅惎鎸囧畾鏈嶅姟
docker compose restart web

# 杩涘叆瀹瑰櫒
docker compose exec web sh

# 鏌ョ湅鐘舵€�
docker compose ps
```

## 鏈€浣冲疄璺�

1. **浣跨敤鐗堟湰鎺у埗**锛氬皢 docker-compose.yml 绾冲叆 Git 绠＄悊
2. **鐜鍙橀噺鍒嗙**锛氫娇鐢� .env 鏂囦欢绠＄悊鏁忔劅淇℃伅
3. **鍋ュ悍妫€鏌�**锛氫负鍏抽敭鏈嶅姟閰嶇疆 healthcheck
4. **鏃ュ織绠＄悊**锛氶厤缃棩蹇楄疆杞�
5. **璧勬簮闄愬埗**锛氫负瀹瑰櫒璁剧疆鍐呭瓨鍜� CPU 闄愬埗

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    deploy:
      resources:
        limits:
          memory: 4G
          cpus: '2.0'
        reservations:
          memory: 1G
          cpus: '0.5'
```

## 鎬荤粨

Docker Compose 鏄鐞嗗搴疄楠屽鏈嶅姟鐨勫埄鍣紝鐔熺粌鎺屾彙鍙互澶уぇ鎻愰珮杩愮淮鏁堢巼銆�

**涓嬩竴姝�**锛氬皾璇曢儴缃蹭竴濂楀睘浜庝綘鐨勫搴奖闄㈢郴缁熷惂锛�
