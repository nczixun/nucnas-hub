---
title: "NAS Docker Compose最佳实践：生产环境配置详解"
date: 2026-03-20
categories:
  - NAS
tags:
  - Docker
  - Docker Compose
  - 容器化
  - 运维
description: "详解NAS上Docker Compose配置最佳实践，包含健康检查、日志管理、数据持久化等生产环境级配置。"
---

# NAS Docker Compose最佳实践：生产环境配置详解

在NAS上运行Docker已成为主流，但大多数用户只停留在基础配置层面。本文将分享生产环境级别的Docker Compose配置，让你的NAS服务更稳定、更易维护。

## 为什么需要最佳实践？

随手写的docker-compose.yml可能存在以下问题：

- 服务挂掉后无法自动重启
- 日志占用大量磁盘空间
- 没有健康检查机制
- 数据卷映射混乱，难以迁移
- 没有资源限制，导致NAS变卡

## 基础架构：目录组织

```bash
~/docker/
├── compose/           # docker-compose.yml文件
│   ├── plex/
│   ├── jellyfin/
│   └── homeassistant/
├── config/           # 配置文件持久化
├── data/             # 数据卷持久化
└── .env              # 环境变量
```

## 最佳实践一：健康检查配置

每个容器都应该配置健康检查：

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    environment:
      - TZ=Asia/Shanghai
      - JELLYFIN_PublishedServerUrl=http://your-nas-ip:8096
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/storage/media:/media:ro
    ports:
      - "8096:8096"
      - "8920:8920"
```

关键配置说明：

- `restart: unless-stopped`：系统重启后自动启动，除非手动停止
- `healthcheck`：监控容器健康状态
- `start_period`：给予服务足够启动时间

## 最佳实践二：日志管理

无限增长的日志会撑爆你的硬盘。以下是日志限制配置：

```yaml
services:
  nginx-proxy:
    image: nginxproxy/nginx-proxy:latest
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    # 全局可在 docker-compose.yml 中设置
    # logging:
    #   driver: "json-file"
    #   options:
    #     max-size: "10m"
    #     max-file: "3"
```

对于更高级的日志管理，可以使用Logstash或Graylog：

```yaml
services:
  grafana:
    image: grafana/grafana:latest
    logging:
      driver: "syslog"
      options:
        syslog-address: "tcp://your-log-server:514"
        tag: "grafana"
```

## 最佳实践三：网络隔离

不同服务应该使用不同网络，避免相互影响：

```yaml
version: '3.8'

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
  monitoring:
    driver: bridge

services:
  # 需要外网访问的服务放frontend
  nginx-proxy:
    networks:
      - frontend
    ports:
      - "80:80"
      - "443:443"

  # 内部服务放backend
  jellyfin:
    networks:
      - frontend
      - backend
    depends_on:
      - nginx-proxy

  # 监控服务放monitoring
  prometheus:
    networks:
      - monitoring
```

## 最佳实践四：资源限制

防止单一容器占满NAS资源：

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant:stable
    container_name: homeassistant
    restart: unless-stopped
    mem_limit: 1g          # 内存限制
    mem_reservation: 256m  # 内存预留
    cpus: 0.5              # CPU限制（0.5核）
    volumes:
      - ./config:/config
      - /etc/localtime:/etc/localtime:ro
    network_mode: host
```

推荐资源限制：

| 服务 | 内存 | CPU |
|------|------|-----|
| Home Assistant | 512M-1G | 0.3 |
| Jellyfin | 1-2G | 1.0 |
| Plex | 2-4G | 2.0 |
| AdGuard Home | 256M | 0.25 |

## 最佳实践五：数据卷管理

使用命名卷便于管理和迁移：

```yaml
services:
  postgres:
    image: postgres:16-alpine
    container_name: postgres
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_DB=${DB_NAME}

volumes:
  postgres_data:
    name: nas_postgres_data
```

查看卷使用情况：

```bash
# 查看所有卷
docker volume ls

# 查看具体卷大小
docker system df -v

# 清理未使用的卷
docker volume prune
```

## 完整示例：家庭影院方案

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    environment:
      - TZ=Asia/Shanghai
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    volumes:
      - jellyfin_config:/config
      - jellyfin_cache:/cache
      - /mnt/storage/media:/media:ro
    ports:
      - "8096:8096"
    networks:
      - media_net
    mem_limit: 2g
    cpus: 1.0

  jackett:
    image: linuxserver/jackett:latest
    container_name: jackett
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
      - AUTO_UPDATE=true
    volumes:
      - jackett_config:/config
      - jackett_downloads:/downloads
    ports:
      - "9117:9117"
    networks:
      - media_net
    mem_limit: 512m

  flaresolverr:
    image: ghcr.io/flaresolverr/flaresolverr:latest
    container_name: flaresolverr
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
      - LOG_LEVEL=info
    volumes:
      - flaresolverr_config:/config
    ports:
      - "8191:8191"
    networks:
      - media_net
    mem_limit: 256m

networks:
  media_net:
    driver: bridge

volumes:
  jellyfin_config:
  jellyfin_cache:
  jackett_config:
  jackett_downloads:
  flaresolverr_config:
```

## 维护命令

常用维护脚本：

```bash
#!/bin/bash
# 更新所有服务
docker-compose pull
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f jellyfin

# 清理旧镜像
docker image prune -f

# 完整重启
docker-compose down
docker-compose up -d
```

## 总结

遵循以上最佳实践，你的NAS Docker将：

1. **更稳定**：健康检查+自动重启
2. **更安全**：网络隔离+资源限制
3. **更易维护**：日志管理+命名卷
4. **更省资源**：合理的资源配额

持续关注容器健康状态，定期更新镜像，你的家庭数据中心将始终保持最佳状态。
