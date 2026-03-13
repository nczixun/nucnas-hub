---
title: "NAS 必装 Docker 应用推荐：2026年"
date: 2026-01-01
categories: ["nas"]
summary: "NAS 必装 Docker 应用推荐，打造家庭数据中心"
tags: ["NAS", "Docker", "应用推荐", "Home Lab"]
slug: "nas-docker-apps-recommend-2026"
---

# NAS 必装 Docker 应用推荐：2026年

## 影音娱乐

### Jellyfin / Plex

| 应用 | 特点 | 推荐度 |
|------|------|--------|
| Jellyfin | 免费开源 | ⭐⭐⭐⭐⭐ |
| Plex | 功能强大 | ⭐⭐⭐⭐ |

### Emby

付费但稳定，适合进阶用户。

## 下载工具

| 应用 | 用途 |
|------|------|
| qBittorrent | BT 下载 |
| Aria2 | 全能下载 |
| Transmission | PT 下载 |

## Home Assistant

智能家居中枢，强烈推荐安装。

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    volumes:
      - ./config:/config
    network_mode: host
    restart: unless-stopped
```

## 广告拦截

### AdGuard Home

```yaml
services:
  adguard:
    image: adguard/adguardhome
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000"
```

## 导航首页

### Homepage

自定义仪表盘，聚合所有服务。

## 容器管理

### Portainer

图形化 Docker 管理工具。

## 内网穿透

| 方案 | 特点 |
|------|------|
| Cloudflare Tunnel | 免费稳定 |
| Tailscale | 简单易用 |
| NPM | 域名反向代理 |

## 监控告警

### Uptime Kuma

自托管监控工具。

## 密码管理

### Vaultwarden

自托管密码管理器。

## 总结

| 优先级 | 应用 |
|--------|------|
| 必备 | Portainer, Jellyfin, AdGuard |
| 推荐 | Home Assistant, qBittorrent |
| 可选 | Vaultwarden, Uptime Kuma |
