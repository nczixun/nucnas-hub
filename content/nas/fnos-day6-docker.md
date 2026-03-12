---
title: "Day 6: 飞牛OS Docker入门 —— 打造万能NAS"
date: 2026-03-12
summary: "学习Docker基础，在飞牛OS上部署各种应用。"
categories: ["nas"]
slug: "fnos-day6-docker"
tags: ["飞牛OS", "Docker", "容器", "应用"]
---

# Day 6: 飞牛OS Docker入门


## 什么是<a href="/nas/docker-best-practice/" target="_blank">Docker</a>？

<a href="/nas/docker-best-practice/" target="_blank">Docker</a>是一个容器平台，让应用在任何环境都能运行。

## 为什么用<a href="/nas/docker-best-practice/" target="_blank">Docker</a>？

- 📦 一次配置，到处运行
- 🔄 轻松更新
- 🧹 干净卸载
- 💪 生态丰富

## 安装<a href="/nas/docker-best-practice/" target="_blank">Docker</a>

飞牛OS Web界面直接支持：
```
应用中心 → Docker → 安装
```

## 常用<a href="/nas/docker-best-practice/" target="_blank">Docker</a>应用

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

### 2. 部署 <a href="/nas/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> 媒体服务器

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
```

---

<div class="page-nav">
  <a href="/nas/fnos-day5-remote/" rel="prev">上一页：Day 5：飞牛OS远程访问</a>
  <a href="/nas/fnos-day7-backup/" rel="next">下一页：Day 7：飞牛OS数据备份</a>
</div>

*本文由 NUC NAS Hub 自动生成*
