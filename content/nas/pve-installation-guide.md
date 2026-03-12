---
title: "PVE 虚拟机安装教程：手把手教你搭建 All-in-One 服务器"
date: 2026-03-08
categories: ["nas"]
summary: "Proxmox VE 安装配置完整流程，支持 PVE 安装 Docker 和 OpenWrt"
tags: ["PVE", "虚拟机", "NAS", "Docker", "OpenWrt", "教程"]
slug: "pve-installation-guide"
---

# PVE 虚拟机安装教程：手把手教你搭建 All-in-One 服务器

很多玩家想把 NAS、软路由、Docker 整合到一台机器上，PVE（Proxmox VE）绝对是首选。这篇教程帮你搞定安装。

## 准备工作

1. **U 盘一个**（容量 ≥ 8GB）
2. **一台 x86 电脑**（建议 4 核 8GB 以上）
3. **下载 PVE 镜像**：官网 proxmox.com 下载 ISO

## 安装步骤

### 第一步：制作启动盘

用 **Rufus** 或 **Ventoy** 把 ISO 写入 U 盘，设置 BIOS 从 U 盘启动。

### 第二步：进入安装界面

开机后选择 **Install Proxmox VE**，然后：

1. 同意 License
2. 选择目标硬盘（会格式化！重要数据先备份）
3. 设置地区：**Asia / China**
4. 设置管理员密码和邮箱
5. 配置网络：建议用 **静态 IP**，方便后续访问

### 第三步：初始化配置

安装完成后，重启进入系统。浏览器访问 `https://你的IP:8006`，用用户名 `root` 和设置的密码登录。

### 第四步：创建第一个虚拟机

1. 点击 **"创建 VM"**
2. 名称随意填，比如 "Docker"
3. ISO 镜像选择你上传的系统镜像（Ubuntu、Debian 都可以）
4. 硬盘、CPU、内存按需分配

## 进阶：All-in-One 方案推荐

我现在跑的配置是：
- **PVE 底层**
- **虚拟机1**：OpenWrt（旁路由，2核/2G）
- **虚拟机2**：Debian + Docker（跑服务，2核/4G）
- **LXC 容器**：Alist、Home Assistant 等

## 常见问题

**Q: 安装后打不开 Web 界面？**
A: 检查防火墙是否放行 8006 端口，或者直接关掉防火墙 `systemctl stop pve-firewall`

**Q: 硬盘直通怎么搞？**
A: 在 PVE 界面找到对应硬盘，点击 **"编辑"** → **"取消"** → 确认即可直通给虚拟机

---

*有问题欢迎评论区留言。更多 NAS 教程关注 [NAS 学院](/nas/)。*

*本文由 NUC NAS Hub 自动生成*
