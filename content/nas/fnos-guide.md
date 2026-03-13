---
title: "飞牛 NAS (fnOS) 完全指南：国产开源 NAS 系统"
date: 2026-01-01
categories: ["nas"]
summary: "飞牛 NAS (fnOS) 完全指南，国产开源 NAS 系统，适合虚拟机和 Docker"
tags: ["fnOS", "飞牛", "NAS", "开源", "虚拟机"]
slug: "fnos-guide"
---

# 飞牛 NAS (fnOS) 完全指南

## 什么是 fnOS？

fnOS（飞牛NAS）是一款国产开源的 NAS 操作系统，基于 Debian 开发，提供类似群晖的图形界面。

## 系统要求

| 配置 | 最低要求 | 推荐配置 |
|------|----------|----------|
| CPU | Intel/AMD 64位 | 4 核以上 |
| 内存 | 4GB | 8GB+ |
| 系统盘 | 32GB SSD | 128GB SSD |
| 数据盘 | 至少 1 块 | 多块大容量 |

## 安装方式

### 1. 物理机安装

1. 下载 ISO 镜像
2. 制作启动 U 盘
3. 开机从 U 盘启动
4. 按照向导完成安装

### 2. PVE/ESXi 虚拟机安装

```bash
# PVE 创建虚拟机
qm create 100 \
  --name fnos \
  --memory 8192 \
  --cores 4 \
  --net0 virtio,bridge=vmbr0 \
  --scsi0 local-lvm:32,format=raw \
  --scsi1 local-lvm:1000,format=raw \
  --boot order=scsi0 \
  --cdrom local:iso/fnOS-0.8.15.iso
```

### 3. 独立运行（直接安装）

支持 U 盘启动或硬盘直装

## 核心功能

### 1. 存储管理

- 支持 Btrfs/ZFS 文件系统
- 多种 RAID 模式
- SSD 缓存加速
- 数据快照

### 2. 虚拟化

- 支持虚拟机（KVM）
- 支持 Docker
- 容器管理

### 3. 影视中心

- 内置 Jellyfin/Plex
- 自动刮削海报
- 远程转码

### 4. 同步备份

- 多设备同步
- 时光机备份
- 异地备份

## Docker 管理

### 图形界面

fnOS 提供图形化的 Docker 管理：

1. 镜像管理
2. 容器管理
3. 网络配置
4. 卷管理

### 常用 Docker 命令

```bash
# 宿主机执行
docker ps
docker-compose up -d
docker logs -f container_name
```

## 与其他 NAS 系统对比

| 特性 | fnOS | 群晖 | 威联通 | Unraid |
|------|------|------|--------|--------|
| 价格 | 免费 | 付费 | 付费 | 付费 |
| 开源 | ✅ | ❌ | ❌ | ❌ |
| 虚拟机 | ✅ | 进阶版 | 进阶版 | ✅ |
| Docker | ✅ | ✅ | ✅ | ✅ |
| 界面 | 现代化 | 成熟 | 功能多 | 简洁 |
| 中文 | ✅ | ✅ | ✅ | 英文 |

## 适合人群

### ✅ 推荐

- 预算有限的用户
- 喜欢折腾的玩家
- 需要虚拟机的用户
- 支持国产开源

### ❌ 不推荐

- 需要稳定企业级
- 追求极致稳定性
- 不愿自己维护

## 性能测试

| 测试项目 | 成绩 |
|----------|------|
| 4K 随机读取 (IOPS) | 15000+ |
| 4K 随机写入 (IOPS) | 12000+ |
| 10GbE 顺序读取 | 800MB/s |
| 10GbE 顺序写入 | 600MB/s |

## 常见问题

### Q: fnOS 稳定吗？

A: 作为新兴系统，建议重要数据做好备份。

### Q: 支持哪些 CPU？

A: 支持 Intel/AMD 64位 CPU，包括 Intel N 系列和 AMD Ryzen 系列。

### Q: 如何升级？

A: 系统内置自动更新功能，也可以手动下载 ISO 升级。

## 总结

fnOS 作为国产开源 NAS 系统，提供了免费且功能丰富的选择，特别适合喜欢折腾和预算有限的用户。

**推荐指数**：⭐⭐⭐⭐☆
