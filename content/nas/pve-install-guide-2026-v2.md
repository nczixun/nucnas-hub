---
title: "Proxmox VE 安装教程：零基础在 NUC 上搭建虚拟化平台"
date: 2026-03-08T09:03:00+08:00
categories: ["nas"]
platform: "pve"
slug: "proxmox-ve-install-guide-2026-v2"
tags: ["Proxmox VE", "PVE", "虚拟机", "NUC", "虚拟化", "教程"]
---

# Proxmox VE 安装教程：零基础在 NUC 上搭建虚拟化平台

Proxmox VE（以下简称 PVE）是开源的虚拟化平台，支持 KVM 虚拟机和 LXC 容器，功能强大且免费。这篇教程教你如何在 Intel NUC 上安装 PVE。

## 环境准备

**硬件要求：**
- Intel NUC 9/10/11/12/13/14 代（或其他 x86_64 主机）
- 至少 16GB SSD（推荐 128GB+）
- 至少 8GB RAM（推荐 16GB+）
- U 盘一个（≥ 8GB）

**软件准备：**
- PVE 镜像：https://www.proxmox.com/en/downloads
- Rufus 或 Ventoy（制作启动盘工具）

## 安装步骤

### 第一步：制作启动盘

1. 下载 PVE ISO 镜像（约 1.2GB）
2. 用 Rufus 写入 U 盘，选择「镜像模式」
3. 启动盘搞定

### 第二步：设置 BIOS

1. 开机按 F2 进入 BIOS
2. 关闭 Secure Boot
3. 开启 VT-x / VT-d（硬件虚拟化）
4. 设置 U 盘启动优先

### 第三步：安装 PVE

1. 选择「Install Proxmox VE」
2. 同意许可协议
3. 选择目标硬盘（建议用独立 SSD）
4. 设置国家、时区、键盘布局
5. 设置管理 IP：建议静态 IP（如 192.168.1.100）
6. 设置邮箱和管理员密码
7. 等待安装完成，约 10-15 分钟

### 第四步：初始化配置

1. 浏览器访问 https://192.168.1.100:8006
2. 用 admin / 你设置的密码 登录
3. 首次进入会提示订阅，选择「测试仓库」即可

## 初始化设置建议

### 1. 更新软件源
```bash
apt update && apt upgrade -y
```

### 2. 配置网络
PVE 默认用桥接模式，虚拟机共享宿主机网络。建议单独规划网段，避免 IP 冲突。

### 3. 存储配置
- 本地 LVM：系统盘，建议 128GB
- 本地 LVM-thin：虚拟机盘，可用机械硬盘
- 网络存储：可后期挂载 NAS

## 常见问题

**Q：安装后无法登录？**
A：检查浏览器证书警告，点「高级」→「继续访问」。如果 IP 不对，进 BIOS 确认网络设置。

**Q：虚拟机无法启动？**
A：确认 BIOS 中 VT-x / VT-d 已开启。部分 NUC 需要更新 BIOS 才能支持。

**Q：如何备份虚拟机？**
A：PVE 支持快照和备份功能，建议定期备份重要虚拟机。

## 下一步

安装完成后，你可以：
- 创建 LXC 容器：运行 OpenWrt、Alpine 等轻量系统
- 创建 KVM 虚拟机：安装 Windows、Linux 桌面系统
- 搭建 All in One：PVE + Docker + OpenWrt 同时运行

Proxmox VE 界面友好，功能完整，配合 NUC 搭建家庭实验室是绝佳选择。后续会出进阶教程，包括显卡直通、硬盘直通等高级操作。
