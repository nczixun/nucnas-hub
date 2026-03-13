---
title: "Docker Compose 杩涢樁锛氬瀹瑰櫒缂栨帓瀹炴垬鎸囧崡"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 瀛﹂櫌"]
tags: ["Docker", "Docker Compose", "NAS", "瀹瑰櫒缂栨帓", "鑷姩鍖�", "鏁欑▼"]
draft: false
---

浼氱敤 Docker 浣嗕笉鐔熸倝 Compose锛熻繖绡囧甫浣犺繘闃躲€傚浼� docker-compose锛屼竴閿鐞嗘墍鏈夊鍣ㄣ€�

## 涓轰粈涔堢敤 Docker Compose锛�

鎵嬪姩 docker run 姣忔閮借鏁蹭竴鍫嗗弬鏁帮紝瀹瑰櫒澶氫簡鏍规湰璁颁笉浣忋€侰ompose 鐢� YAML 鏂囦欢瀹氫箟鏈嶅姟锛岀増鏈帶鍒躲€佽縼绉汇€佸浠介兘鏂逛究銆�

## 鍩虹缁撴瀯

```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret
```

## 杩涢樁鎶€宸�

### 1. 鐜鍙橀噺绠＄悊

鍒涘缓 `.env` 鏂囦欢锛�

```bash
# .env
POSTGRES_PASSWORD=your_secure_password
DATA_PATH=/mnt/storage
```

Compose 鑷姩璇诲彇锛�

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ${DATA_PATH}/postgres:/var/lib/postgresql/data
```

### 2. 缃戠粶闅旂

```yaml
services:
  web:
    networks:
      - frontend
  db:
    networks:
      - backend

networks:
  frontend:
  backend:
    internal: true  # 瀹屽叏闅旂
```

### 3. 鍋ュ悍妫€鏌�

```yaml
services:
  redis:
    image: redis
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 4. 渚濊禆鍏崇郴

```yaml
services:
  web:
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

## 甯哥敤鍛戒护

```bash
# 鍚姩鎵€鏈夋湇鍔�
docker-compose up -d

# 鏌ョ湅鏃ュ織
docker-compose logs -f

# 鏇存柊闀滃儚
docker-compose pull
docker-compose up -d

# 鍋滄鎵€鏈夋湇鍔�
docker-compose down
```

## 鎴戠殑 NAS 閰嶇疆鍒嗕韩

杩欐槸鎴戠洰鍓嶅湪鐢ㄧ殑閮ㄥ垎閰嶇疆锛�

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    network_mode: host
    volumes:
      - ./ha:/config
    restart: unless-stopped

  portainer:
    image: portainer/portainer-ce
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./portainer:/data

  nginx:
    image: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/html:/usr/share/nginx/html
      - ./nginx/ssl:/etc/nginx/ssl:ro
```

## 鎬荤粨

Docker Compose 鐪熺殑鏄敤浜嗗氨鍥炰笉鍘汇€傞厤缃竴娆★紝涓嬫寮€鏈轰竴閿惎鍔ㄦ墍鏈夋湇鍔°€傚缓璁ぇ瀹堕兘鑺辨椂闂村涓€涓嬶紝鐪熺殑鑳界渷寰堝鍔熷か銆�

---
*娴嬭瘯鐜锛氱兢鏅� DS920+ Docker 24.0*
