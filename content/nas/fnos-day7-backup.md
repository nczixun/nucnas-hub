---
title: "Day 7: 飞牛OS数据备份与同步 —— 守护你的数据安全"
date: 2026-03-13
summary: "学习飞牛OS的数据备份策略，保护重要数据不丢失。"
categories: ["nas"]
slug: "fnos-day7-backup"
tags: ["飞牛OS", "备份", "同步", "数据安全"]
image: https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg
imageCredit: "Pexels"
---

# Day 7: 飞牛OS数据备份与同步

![数据备份](https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg "备份")

## 为什么需要备份？

- 💔 硬盘会坏
- 🐛 系统会崩
- 🙈 误删文件
- 🦠 勒索病毒

## 备份策略

### 3-2-1 原则
- 3份数据副本
- 2种不同存储介质
- 1份异地存储

## 本地备份

### 使用rsync

```bash
# 备份到另一个硬盘
rsync -avz /source /backup

# 增量备份
rsync -avz --delete /source /backup
```

### 使用<a href="/nas/docker-best-practice/" target="_blank">Docker</a>容器

```yaml
version: '3'
services:
  duplicati:
    image: lscr.io/linuxserver/duplicati
    container_name: duplicati
    volumes:
      - ./config:/config
      - ./backups:/backups
      - /data:/source
    ports:
      - "8200:8200"
    restart: unless-stopped
```

## 云端同步

### 1. Rclone配置

```bash
# 安装Rclone
curl https://rclone.org/install.sh | sudo bash

# 配置
rclone config
```

---

<div class="page-nav">
  <a href="/nas/fnos-day6-docker/" rel="prev">上一页：Day 6：飞牛OS Docker应用</a>
</div>

*本文由 NUC NAS Hub 自动生成*
