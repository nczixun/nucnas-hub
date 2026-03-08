---
title: "Docker Compose 进阶：多容器编排实战指南"
date: 2026-03-08
categories: ["nas"]
brand: "通用"
model: "Docker"
platform: "nas"
slug: "docker-compose-advanced-multi-container-2026"
tags: ["Docker Compose", "NAS", "容器编排", "Docker 教程", "家庭影院"]
---

# Docker Compose 进阶：多容器编排实战指南

很多玩家在 NAS 上部署单个容器很简单，但面对多容器联动就犯了难。今天讲讲 Docker Compose 进阶玩法，让你轻松实现复杂服务架构。

## 为什么要用 Docker Compose

手动管理多个容器时，你可能遇到这些问题：
- 容器启动顺序混乱，导致服务不可用
- 环境变量容易设错
- 更新版本要一个个改
- 端口冲突找不到原因

Docker Compose 通过 YAML 文件统一管理，一次启动全部搞定。

## 经典场景：家庭影院全家桶

这是一个典型的多容器架构：

```yaml
version: '3.8'

services:
  # 视频管理
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

  # 影片刮削
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

  # 下载工具
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

  # 媒体整理
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

## 关键配置解析

### depends_on：控制启动顺序
Jellyseerr 依赖 Jellyfin，后者在前面先启动。不过要注意，这只是"启动顺序"，不是"就绪顺序"。生产环境建议用健康检查。

### network_mode: host vs bridge
Jellyfin 用 host 模式是为了获取准确的海报墙。qbittorrent 和 radarr 用 bridge 模式，端口隔离更安全。

### PUID/PGID：权限问题
NAS 上的容器经常遇到权限问题。通过 PUID=1000（你的用户ID）和 PGID=1000 确保文件读写正常。

## 进阶技巧

### 1. 使用 .env 文件管理变量
创建 .env 文件：
```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

然后在 compose 中引用：`${PUID}`

### 2. 健康检查配置
```yaml
services:
  jellyfin:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8097/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 3. 重启策略
- `no`：不自动重启
- `on-failure`：失败时重启
- `unless-stopped`：除非手动停止，否则一直重启
- `always`：总是重启（推荐用于 NAS）

## 一键启动命令

```bash
# 启动所有服务
docker compose up -d

# 查看日志
docker compose logs -f jellyfin

# 更新所有镜像
docker compose pull && docker compose up -d

# 停止所有服务
docker compose down
```

掌握 Docker Compose 后，你可以轻松搭建 PLEX + Sonarr + Radarr + QBittorrent 的下载刮削一条龙，或者 Home Assistant + Node-RED + InfluxDB 的智能家居平台。复杂服务，一次部署，长期受益。