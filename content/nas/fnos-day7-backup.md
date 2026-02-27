---
title: "Day 7: 飞牛OS数据备份与同步 —— 守护你的数据安全"
date: 2026-03-13
summary: "学习飞牛OS的数据备份策略，保护重要数据不丢失。"
categories: ["nas"]
slug: "fnos-day7-backup"
tags: ["飞牛OS", "备份", "同步", "数据安全"]
image: https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg
---

# Day 7: 飞牛OS数据备份与同步

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

### 使用Docker容器

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
# 安装rclone
curl https://rclone.org/install.sh | sudo bash

# 配置
rclone config

# 同步
rclone sync /local/path remote:bucket -v
```

### 2. 阿里云盘

```yaml
services:
  aliyundrive-webdav:
    image: messense/aliyundrive-webdav
    container_name: aliyundrive
    environment:
      - REFRESH_TOKEN=your_token
    volumes:
      - ./data:/mnt
    ports:
      "8088:8088"
```

## 版本控制

建议保留多个历史版本：

```bash
# 使用borg备份
borg create /backup::archive /data
borg list /backup
```

## 重要数据清单

建议备份的内容：
- 📁 照片/视频
- 📁 文档资料
- ⚙️ 配置文件
- 🐳 Docker配置

## 7天学习总结

🎉 恭喜完成飞牛OS入门！

### 你学到了什么

| 天数 | 内容 |
|------|------|
| Day 1 | 飞牛OS简介 |
| Day 2 | 硬件选购 |
| Day 3 | 安装教程 |
| Day 4 | 网络配置 |
| Day 5 | 远程访问 |
| Day 6 | Docker应用 |
| Day 7 | 数据备份 |

### 下一步

- 深入学习Docker
- 搭建自己的服务
- 参与社区交流

---

*感谢关注！持续学习飞牛OS！*
