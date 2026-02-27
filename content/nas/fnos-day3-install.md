---
title: "Day 3: 飞牛OS安装教程 —— 多种方式任你选"
date: 2026-03-09
summary: "详细介绍飞牛OS的多种安装方式：U盘启动、硬盘挂载、虚拟机。"
categories: ["nas"]
slug: "fnos-day3-install"
tags: ["飞牛OS", "安装", "教程", "U盘启动"]
image: https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg
---

# Day 3: 飞牛OS安装教程

## 安装方式一览

| 方式 | 难度 | 适用场景 |
|------|------|----------|
| U盘启动 | ⭐ | 体验/测试 |
| 硬盘安装 | ⭐⭐ | 主流用户 |
| 虚拟机 | ⭐⭐⭐ | 学习/测试 |

## 方式一：U盘启动安装

### 步骤1：下载镜像

访问飞牛OS官网下载最新镜像（.img.gz格式）

### 步骤2：制作启动盘

```bash
# Windows (使用Rufus)
# 1. 插入U盘
# 2. 打开Rufus，选择镜像
# 3. 点击开始

# Linux
sudo apt install gzip dd
sudo dd if=fnos.img of=/dev/sdX bs=4M status=progress
```

### 步骤3：设置启动

1. 进入BIOS设置U盘启动
2. 保存并重启
3. 按照屏幕提示完成安装

## 方式二：硬盘直装

### 步骤1：准备硬盘

建议使用SSD作为系统盘（至少16GB）

### 步骤2：使用Ventoy

1. 制作Ventoy启动盘
2. 放入飞牛OS镜像
3. 从Ventoy启动选择镜像

### 步骤3：安装到硬盘

```
选择目标磁盘 → 确认安装 → 等待完成
```

## 方式三：虚拟机安装

### 使用Proxmox

```yaml
# 创建虚拟机
qm create 100 \
  --name fnos \
  --cores 4 \
  --memory 8192 \
  --net0 virtio,bridge=vmbr0

# 导入镜像
qm importdisk 100 fnos.qcow2 vmbr0 --format qcow2
```

### 使用ESXi

1. 创建虚拟机（选择Debian 12兼容）
2. 添加硬盘时选择"使用物理磁盘"
3. 挂载ISO镜像启动

## 安装后首次配置

1. 设置管理员密码
2. 配置网络（DHCP/静态IP）
3. 访问Web管理界面

## 常见问题

**Q: 安装后无法启动？**
A: 检查启动顺序，确保从正确设备启动

**Q: 无法识别硬盘？**
A: 检查硬盘模式（AHCI/RAID）

## 明天预告

Day 4我们将介绍飞牛OS的网络配置。

---

*关注我，每天学习飞牛OS！*
