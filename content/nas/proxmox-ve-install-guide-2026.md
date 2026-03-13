---
title: "Proxmox VE 8 安装教程：手把手教你用 NUC 搭建虚拟化平台"
date: 2026-03-08
categories: ["nas"]
brand: "PVE"
model: "PVE 8"
platform: "virtualization"
slug: "proxmox-ve-install-guide"
tags: ["PVE", "虚拟机", "虚拟化", "NUC", "教程"]
---

# Proxmox VE 8 安装教程：手把手教你用 NUC 搭建虚拟化平台

Proxmox VE（以下简称 PVE）是一款开源的企业级虚拟化平台，基于 Debian 开发，支持 KVM 虚拟机和 LXC 容器。今天手把手教你用迷你主机安装 PVE。

## 环境准备

**硬件要求：**
- 迷你主机（NUC 或等价设备）
- 8GB+ RAM（建议 16GB）
- 256GB+ SSD（系统盘）
- U 盘一个（≥ 8GB）

**软件准备：**
- PVE 8.1 镜像（官网下载）
- Rufus 启动盘制作工具

## 安装步骤

### 1. 制作启动盘

1. 下载 PVE ISO 镜像（约 1.2GB）
2. 用 Rufus 写入 U 盘，选择 "DD 模式"
3. 启动盘制作完成

### 2. BIOS 设置

1. 开机按 F2 进入 BIOS
2. 关闭 Secure Boot
3. 开启 VT-x / VT-d（Intel 虚拟化技术）
4. 设置 U 盘启动优先

### 3. PVE 安装

1. 从 U 盘启动，进入 PVE 安装界面
2. 选择 "Install Proxmox VE"
3. 同意许可协议
4. 选择目标磁盘（建议用独立 SSD）
5. 设置国家、时区、键盘布局
6. 设置管理口 IP（自动获取或手动指定）
7. 设置管理员密码和邮箱
8. 点击安装，等待 10-15 分钟

### 4. 初始化配置

1. 安装完成后重启
2. 浏览器访问 `https://你的IP:8006`
3. 使用用户名 `root` + 密码登录
4. 首次进入会提示订阅（可以忽略）

## 进阶配置

### 创建虚拟机

1. 点击 "创建 VM"
2. 填写 VM 名称
3. 选择 ISO 镜像
4. 设置 CPU 核心数、内存大小
5. 选择磁盘大小
6. 选择网络模型（VirtIO 性能最好）
7. 点击完成

### 配置显卡直通（可选）

如果要用 NUC 玩游戏，可以尝试显卡直通：
```bash
# 编辑 GRUB
nano /etc/default/grub
# 添加：intel_iommu=on
update-grub
```

## 常见问题

**Q：PVE 和 ESXi 有什么区别？**
A：PVE 完全免费，开源；ESXi 免费版功能受限。PVE 对硬件兼容性更好。

**Q：NUC 装 PVE 散热够吗？**
A：迷你主机建议不要超过 8 虚拟机同时运行，注意散热即可。

**Q：如何备份虚拟机？**
A：PVE 支持快照和备份功能，建议定期备份重要数据。

## 总结

PVE 是搭建 All in One 的最佳选择，一台 NUC 即可同时运行软路由、NAS、Docker、虚拟机。下一期讲如何用 PVE 跑 Home Assistant。