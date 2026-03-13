---
title: "Immich 鑷缓鐓х墖浜戯細NAS 鎼缓鎸囧崡"
date: 2026-01-01
categories: ["nas"]
summary: "Immich 鑷缓鐓х墖浜戞暀绋嬶紝Google Photos 鏇夸唬鍝�"
tags: ["Immich", "鐓х墖", "浜戠浉鍐�", "NAS"]
slug: "immich-photo-cloud"
---

# Immich 鑷缓鐓х墖浜�

## 浠€涔堟槸 Immich锛�

Immich 鏄紑婧愮殑鑷墭绠＄収鐗囧浠借В鍐虫柟妗堬紝鐣岄潰绫讳技 Google Photos銆�

## 瀹夎鏂瑰紡

### Docker Compose

```yaml
version: '3.8'

services:
  immich:
    image: ghcr.io/immich-app/immich-server:release
    command: ['start.sh', 'immich']
    ports:
      - "2283:3001"
    volumes:
      - /mnt/photos:/usr/src/app/upload
      - ./config:/etc/immich
    environment:
      - DB_HOSTNAME=immich_db
      - DB_USERNAME=postgres
      - DB_PASSWORD=postgres
      - DB_DATABASE_NAME=immich
    depends_on:
      - immich_db

  immich_db:
    image: tensorchord/pgvecto-rs:pg14-v0.2.0
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
      - POSTGRESS_DB=immich
    volumes:
      - pgdata:/var/lib/postgresql/data

  immich_microservices:
    image: ghcr.io/immich-app/immich-server:release
    command: ['start.sh', 'microservices']
    volumes:
      - /mnt/photos:/usr/src/app/upload
      - ./config:/etc/immich
    environment:
      - DB_HOSTNAME=immich_db

volumes:
  pgdata:
```

## 鍔熻兘鐗圭偣

- 鉁� 鑷姩澶囦唤鎵嬫満鐓х墖
- 鉁� AI 浜鸿劯璇嗗埆
- 鉁� 鍦板浘瑙嗗浘
- 鉁� 鐩稿唽绠＄悊
- 鉁� 鍏变韩鐩稿唽

## 绉诲姩绔�

- iOS锛欰pp Store
- Android锛欸oogle Play

## 鎬荤粨

Immich 鏄嚜寤虹収鐗囦簯鐨勬渶浣抽€夋嫨銆�

**鎺ㄨ崘鎸囨暟**锛氣瓙猸愨瓙猸愨瓙
