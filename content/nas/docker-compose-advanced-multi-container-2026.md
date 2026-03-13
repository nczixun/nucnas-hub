---
title: "Docker Compose 高级进阶：多容器编排完全指南"
date: 2026-03-08
categories: ["nas"]
brand: "NAS"
model: "Docker"
platform: "nas"
slug: "docker-compose-advanced-multi-container-2026"
tags: ["Docker Compose", "NAS", "多容器编排", "Docker 教程", "家庭影院"]
---

# Docker Compose 高级进阶：多容器编排完全指南

对于追求高效管理 NAS 资源的用户来说，Docker Compose 是实现多容器协同工作的最佳方案。

## 为什么选择 Docker Compose

在 NAS 环境中，我们通常需要同时运行多个服务：媒体服务器、下载工具、文件同步等。Docker Compose 可以：

- **一键启动**：所有服务同时启动
- **版本管理**：通过 YAML 文件版本控制
- **环境隔离**：服务之间相互独立
- **简单维护**：统一管理生命周期

## 常用命令

```bash
# 创建并启动容器
docker-compose up -d

# 停止并删除容器
docker-compose down

# 查看日志
docker-compose logs -f [服务名]

# 构建镜像
docker-compose build

# 重启服务
docker-compose restart
```

## 进阶配置

### 环境变量

```yaml
services:
  app:
    environment:
      - NODE_ENV=production
      - DB_HOST=db
```

### 依赖关系

```yaml
services:
  web:
    depends_on:
      - db
      - redis
```

### 健康检查

```yaml
services:
  db:
    healthcheck:
      test: ["CMD", "mysqladmin", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
```

## 完整示例：家庭影院方案

```yaml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    ports:
      - "8096:8096"
    volumes:
      - ./config:/config
      - ./media:/media
    restart: unless-stopped

  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    ports:
      - "8080:8080"
    volumes:
      - ./qb:/config
      - ./downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000

  jackett:
    image: lscr.io/linuxserver/jackett
    container_name: jackett
    ports:
      - "9117:9117"
    volumes:
      - ./jackett:/config
      - ./downloads:/downloads
```

## 性能优化

1. **资源限制**
```yaml
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
```

2. **日志管理**
```yaml
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

---

*更多 NAS 教程请关注 [NAS 频道](/nas/)。*
