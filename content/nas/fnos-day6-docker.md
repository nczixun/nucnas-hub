---
title: "Day 6: 飞牛OS Docker入门 —— 打造万能NAS"
date: 2026-03-12
summary: "学习Docker基础，在飞牛OS上部署各种应用。"
categories: ["nas"]
slug: "fnos-day6-docker"
tags: ["飞牛OS", "Docker", "容器", "应用"]
image: https://images.pexels.com/photos/1661005/pexels-photo-1661005.jpeg
---

# Day 6: 飞牛OS Docker入门

## 什么是Docker？

Docker是一个容器平台，让应用在任何环境都能运行。

## 为什么用Docker？

- 📦 一次配置，到处运行
- 🔄 轻松更新
- 🧹 干净卸载
- 💪 生态丰富

## 安装Docker

飞牛OS Web界面直接支持：
```
应用中心 → Docker → 安装
```

## 常用Docker应用

### 1. 部署QBittorrent

```yaml
version: '3'
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
    volumes:
      - ./config:/config
      - ./downloads:/downloads
    ports:
      - "8080:8080"
      - "6881:6881"
    restart: unless-stopped
```

### 2. 部署 Jellyfin 媒体服务器

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    volumes:
      - ./config:/config
      - ./media:/media
    ports:
      - "8096:8096"
    restart: unless-stopped
```

### 3. 部署 HomeAssistant

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    container_name: homeassistant
    volumes:
      - ./config:/config
    network_mode: host
    restart: unless-stopped
```

## 常用命令

```bash
# 拉取镜像
docker pull <image>

# 查看运行中的容器
docker ps

# 查看所有容器
docker ps -a

# 启动/停止容器
docker start <name>
docker stop <name>

# 查看日志
docker logs <name>
```

## 存储路径建议

| 用途 | 路径 |
|------|------|
| 配置 | /docker/config |
| 媒体 | /docker/media |
| 下载 | /docker/downloads |

## 明天预告

Day 7我们将介绍飞牛OS的数据备份与同步。

---

*关注我，每天学习飞牛OS！*
