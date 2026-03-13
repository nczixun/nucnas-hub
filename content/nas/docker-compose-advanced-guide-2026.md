---
title: "Docker 杩涢樁锛氫娇鐢� Docker Compose 缂栨帓澶氫釜瀹瑰櫒"
date: 2026-03-07
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
slug: "docker-compose-advanced-guide-2026"
---

# Docker 杩涢樁锛氫娇鐢� Docker Compose 缂栨帓澶氫釜瀹瑰櫒

鍗曠嫭杩愯瀹瑰櫒楹荤儲锛熺敤 **Docker Compose** 涓€娆＄鐞嗘墍鏈夋湇鍔°€�

**瀹夎 Docker Compose锛�**

```bash
# 缇ゆ櫀/椋炵墰OS
sudo apt update
sudo apt install docker-compose
```

**缂栧啓 docker-compose.yml锛�**

```yaml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    ports:
      - "8096:8096"
    volumes:
      - /mnt/storage/jellyfin:/config
    environment:
      - TZ=Asia/Shanghai
```

**甯哥敤鍛戒护锛�**

- `docker-compose up -d`锛氬惎鍔ㄦ墍鏈夋湇鍔�
- `docker-compose down`锛氬仠姝㈡墍鏈夋湇鍔�
- `docker-compose restart`锛氶噸鍚墍鏈夋湇鍔�
- `docker-compose logs -f`锛氭煡鐪嬫棩蹇�

杩欑鏂瑰紡閮ㄧ讲 **Jellyfin銆丵Bittorrent銆丯extcloud** 缁勫悎鐗瑰埆鏂逛究锛屼竴涓懡浠ゅ叏鎼炲畾銆�
