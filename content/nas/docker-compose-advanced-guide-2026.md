---
title: "Docker 进阶：使用 Docker Compose 编排多个容器"
date: 2026-03-07
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
slug: "docker-compose-advanced-guide-2026"
---

# Docker 进阶：使用 Docker Compose 编排多个容器

单独运行容器麻烦？用 **Docker Compose** 一次管理所有服务。

**安装 Docker Compose：**

```bash
# 群晖/飞牛OS
sudo apt update
sudo apt install docker-compose
```

**编写 docker-compose.yml：**

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

**常用命令：**

- `docker-compose up -d`：启动所有服务
- `docker-compose down`：停止所有服务
- `docker-compose restart`：重启所有服务
- `docker-compose logs -f`：查看日志

这种方式部署 **Jellyfin、QBittorrent、Nextcloud** 组合特别方便，一个命令全搞定。
