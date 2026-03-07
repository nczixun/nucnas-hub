---
title: "Docker Compose 进阶教程：NAS 上手 docker-compose.yml 写法"
date: 2026-03-08
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
platform: "docker"
slug: "docker-compose-advanced-guide-2026"
tags: ["Docker Compose", "NAS", "Docker", "容器", "进阶教程"]
---

# Docker Compose 进阶教程：NAS 上手 docker-compose.yml 写法

会用 Docker 但不了解 Docker Compose？这篇文章手把手教你用 docker-compose 管理 NAS 上的服务。

## 什么是 Docker Compose？

Docker Compose 是 Docker 官方提供的容器编排工具，通过一个 `docker-compose.yml` 文件定义多个容器，一键启动、停止、备份。

**对比传统 Docker 命令：**
- 传统：一个容器一条命令，复杂
- Compose：一个文件管所有，简单

## 快速开始

### 1. 安装 Docker Compose

```bash
# Docker Desktop 自带
# 群晖：套件中心安装 Docker
# 绿联/极空间：应用中心一键安装
# 验证安装
docker compose version
```

### 2. 创建 docker-compose.yml

在 NAS 上新建文件夹，例如 `/docker/jellyfin`，新建 `docker-compose.yml`：

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

### 3. 启动服务

```bash
# 进入目录
cd /docker/jellyfin

# 启动所有服务
docker compose up -d

# 查看状态
docker compose ps

# 查看日志
docker compose logs -f
```

## 进阶配置

### 多容器编排

一个文件管理多个服务：

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

### 环境变量文件

新建 `.env` 文件：

```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

在 compose 中引用：

```yaml
environment:
  - TZ=${TZ}
  - PUID=${PUID}
```

### 网络配置

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

### 健康检查

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

### 资源限制

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

## 常用命令

| 命令 | 说明 |
| :--- | :--- |
| `docker compose up -d` | 后台启动 |
| `docker compose down` | 停止并删除 |
| `docker compose restart` | 重启 |
| `docker compose logs -f` | 查看日志 |
| `docker compose pull` | 更新镜像 |
| `docker compose up -d --force-recreate` | 强制重建 |
| `docker compose config` | 验证配置 |

## 备份与迁移

### 备份

```bash
# 备份配置文件
tar -czvf backup.tar.gz ./config .env docker-compose.yml
```

### 迁移

```bash
# 复制整个文件夹到新设备
# 重新启动
docker compose up -d
```

## 常见问题

**Q：端口冲突怎么办？**
A：修改 ports 部分的不同端口映射。

**Q：如何更新容器？**
A：`docker compose pull` 然后 `docker compose up -d`。

**Q：数据如何持久化？**
A：使用 volumes 挂载宿主机目录。

**Q：容器启动失败？**
A：`docker compose logs` 查看错误信息。

## 推荐组合

- **影音中心**：Jellyfin + QBittorrent + Alist
- **下载机**：QBittorrent + Transmission + Alist
- **HomeLab**：AdGuard + Nginx Proxy Manager + Portainer

## 总结

Docker Compose 是管理 NAS 容器的神器。一个文件管所有，再也不怕容器乱跑。掌握这些技巧，你的 NAS 运维能力会提升一个档次。