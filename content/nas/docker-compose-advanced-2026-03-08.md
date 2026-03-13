---
title: "Docker Compose 高级进阶：多容器编排实战指南"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 进阶教程"]
tags: ["Docker", "Docker Compose", "NAS", "多容器编排", "家庭影院", "Docker 网络"]
draft: false
---

想要充分发挥 NAS 的性能，Docker Compose 是不可或缺的工具。本文将详细介绍如何使用 Docker Compose 管理多容器应用。

## 为什么要用 Docker Compose

相比 `docker run` 命令，Docker Compose 通过 YAML 文件定义多容器服务，一次性启动所有服务，更加方便管理和维护。

## 基础语法

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

## 常用命令

```bash
# 启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 停止所有服务
docker-compose down

# 查看日志
docker-compose logs -f

# 重启指定服务
docker-compose restart web
```

## 多容器示例：家庭影院

```yaml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    ports:
      - "8096:8096"
      - "8920:8920"
    volumes:
      - ./config:/config
      - ./media:/media
    environment:
      - TZ=Asia/Shanghai

  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    ports:
      - "8080:8080"
      - "6881:6881"
    volumes:
      - ./qb:/config
      - ./downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000
```

## 网络配置

```yaml
services:
  app:
    networks:
      - my_network
  db:
    networks:
      - my_network

networks:
  my_network:
    driver: bridge
```

## 数据持久化

```yaml
volumes:
  my_data:
    driver: local
```

---

*更多 NAS 教程请关注 [NAS 频道](/nas/)。*
