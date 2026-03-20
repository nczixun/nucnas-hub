---
title: "2026年NAS搭建完全指南：从零开始手把手教你"
description: "NAS怎么搭建？手把手教你从选购到部署，群晖/威联通/绿联/极空间全对比。"
date: 2026-03-20
draft: false
tags: ["NAS", "搭建", "教程", "群晖", "威联通"]
categories: ["NAS学院"]
---

# 2026年NAS搭建完全指南：从零开始

## 前言

NAS（网络附加存储）已经成为现代家庭的必备设备。本文将手把手教你如何从零开始搭建自己的私有云。

## 一、NAS选购指南

### 1.1 入门级方案（500-1000元）

| 型号 | 盘位 | 处理器 | 价格 |
|------|------|--------|------|
| 绿联DH2100 | 2盘 | Realtek RTD1619B | ¥599 |
| 极空间Q2C | 2盘 | Realtek RTD1619B | ¥899 |

### 1.2 中端方案（1500-3000元）

| 型号 | 盘位 | 处理器 | 价格 |
|------|------|--------|------|
| 绿联DXP4800 | 4盘 | Intel N100 | ¥1999 |
| 极空间Z4Pro | 4盘 | Intel N97 | ¥2299 |
| 群晖DS224+ | 2盘 | Intel Celeron J4125 | ¥2800 |

### 1.3 高端方案（3000元以上）

| 型号 | 盘位 | 处理器 | 价格 |
|------|------|--------|------|
| 群晖DS920+ | 4盘 | Intel Celeron J4125 | ¥3800 |
| 威联通TS-464C | 4盘 | Intel N5095 | ¥3200 |

## 二、硬盘选购

### 推荐型号

- **入门**：东芝N300 4TB（约¥550）
- **主流**：希捷酷狼4TB（约¥900）
- **高端**：WD Red Pro 8TB（约¥1800）

## 三、系统初始化

### 步骤1：硬件连接
1. 硬盘装入NAS
2. 连接网线
3. 连接电源

### 步骤2：系统安装
以绿联为例：
1. 下载"绿联云"App
2. 扫描NAS机身二维码
3. 初始化系统
4. 创建存储空间

### 步骤3：基础设置
- 设置RAID模式（推荐RAID5）
- 开启SAMBA/AFP服务
- 配置DDNS（可选）

## 四、常用功能搭建

### 4.1 影音中心（Jellyfin/Plex）
```bash
# Docker Compose
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    volumes:
      - ./config:/config
      - /storage/media:/media
    ports:
      - "8096:8096"
```

### 4.2 下载机（QBittorrent/Transmission）
```bash
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    volumes:
      - ./downloads:/downloads
    ports:
      - "8080:8080"
```

### 4.3 照片备份（Photoprism）
```bash
services:
  photoprism:
    image: photoprism/photoprism
    container_name: photoprism
    volumes:
      - ./storage:/storage
    ports:
      "2342:2342"
```

## 五、远程访问

### 5.1 内网穿透方案
- 方案1：ZeroTier（免费）
- 方案2：Tailscale（免费）
- 方案3：花生壳（付费）

### 5.2 公网访问
如宽带有公网IP，可配置：
1. 路由器端口映射
2. 配置DDNS
3. 开启HTTPS

## 六、常见问题

### Q1：NAS一定要RAID吗？
A：建议使用RAID1（2盘）或RAID5（4盘以上），确保数据安全。

### Q2：NAS耗电吗？
A：入门级NAS待机功耗约5-10W，非常省电。

### Q3：可以用二手硬盘吗？
A：不建议，NAS需要7×24小时运行，二手硬盘故障率高。

## 七、总结

搭建NAS只需四步：
1. 选购设备
2. 安装硬盘
3. 初始化系统
4. 部署服务

有任何问题欢迎评论区交流！

---

*本文更新于2026年3月*
