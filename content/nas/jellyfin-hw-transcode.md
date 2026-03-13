---
title: "Jellyfin 硬件转码设置指南：4K 畅享"
date: 2026-01-01
categories: ["nas"]
summary: "Jellyfin 硬件转码设置指南，Intel QSV/NVIDIA NVENC"
tags: ["Jellyfin", "转码", "4K", "NAS"]
slug: "jellyfin-hw-transcode"
---

# Jellyfin 硬件转码设置指南

## 为什么需要硬件转码？

硬件转码可以大幅降低 CPU 占用，流畅播放 4K 视频。

## Intel 核显设置（推荐）

### 1. 安装 Intel 显卡驱动

确保系统已安装 Intel 显卡驱动。

### 2. 配置 Docker

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    environment:
      - TZ=Asia/Shanghai
      - LIBVA_DRIVER_NAME=iHD
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/media:/media:ro
    devices:
      - /dev/dri:/dev/dri
    restart: unless-stopped
```

### 3. Jellyfin 后台配置

1. 控制面板 → 播放 → 转码
2. 硬件加速：Intel QuickSync (QSV)
3. 启用硬件解码

## NVIDIA 显卡设置

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## 支持的格式

### Intel QSV

| 格式 | 支持 |
|------|------|
| H.264 | ✅ |
| HEVC (H.265) | ✅ |
| VP9 | ✅ |
| AV1 | ✅ |

### NVIDIA NVENC

| 格式 | 支持 |
|------|------|
| H.264 | ✅ |
| HEVC (H.265) | ✅ |
| VP9 | ❌ |
| AV1 | ✅ |

## 性能对比

| 方案 | 4K 转码 CPU | 功耗 |
|------|-------------|------|
| 软件转码 | 80% | 高 |
| Intel QSV | 10% | 低 |
| NVIDIA | 5% | 中 |

## 常见问题

### Q: 找不到硬件加速？

A: 检查 Docker 设备映射

### Q: 转码失败？

A: 检查驱动是否正确安装

## 总结

Intel QSV 是 NAS 最佳选择，功耗低效果好。

**推荐指数**：⭐⭐⭐⭐⭐
