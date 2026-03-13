---
title: "Immich 自建照片云：NAS 搭建指南"
date: 2026-01-01
categories: ["nas"]
summary: "Immich 自建照片云教程，Google Photos 替代品"
tags: ["Immich", "照片", "云相册", "NAS"]
slug: "immich-photo-cloud"
---

# Immich 自建照片云

## 什么是 Immich？

Immich 是开源的自托管照片备份解决方案，界面类似 Google Photos。

## 安装方式

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

## 功能特点

- ✅ 自动备份手机照片
- ✅ AI 人脸识别
- ✅ 地图视图
- ✅ 相册管理
- ✅ 共享相册

## 移动端

- iOS：App Store
- Android：Google Play

## 总结

Immich 是自建照片云的最佳选择。

**推荐指数**：⭐⭐⭐⭐⭐
