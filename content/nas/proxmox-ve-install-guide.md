---
title: "Proxmox VE 安装指南：虚拟机管理平台搭建教程"
date: 2026-03-08
categories: ["NAS 进阶教程"]
tags: ["PVE", "虚拟机安装教程", "Proxmox 安装", "NAS"]
description: "Proxmox VE 安装教程：从 U 盘启动到虚拟机配置，手把手教你搭建家庭虚拟化环境"
draft: true
---

# Proxmox VE 安装指南：虚拟机管理平台搭建教程

## 什么是 Proxmox VE

Proxmox VE 是一个开源的虚拟化平台，基于 Debian 构建，支持 KVM 虚拟机和 LXC 容器，是家庭实验室的首选。

## 硬件要求

- **基础配置**：CPU 4核+ / 内存 4GB+ / 32GB+ SSD
- **推荐配置**：8GB+ 内存 / 16GB+ SSD
- **启动介质**：8GB+ U 盘
- **安装镜像**：从 [proxmox.com](https://www.proxmox.com) 下载 ISO

## 安装步骤

### 1. 制作启动 U 盘

使用 Ventoy 或 Rufus 将 PVE ISO 写入 U 盘。

### 2. 设置 BIOS

进入 BIOS（通常按 Del/F2），设置：
- 启用 **Intel VT-x** 或 **AMD-V** 虚拟化技术
- 设置 U 盘启动优先

### 3. 开始安装

1. 选择 "Install Proxmox VE"
2. 选择目标硬盘
3. 设置国家、时区、键盘布局
4. 配置网络（建议使用静态 IP）
5. 设置管理员密码和邮箱

### 4. 首次登录

安装完成后，通过浏览器访问：
```
https://你的IP:8006
```

## 创建虚拟机

### 创建 LXC 容器

```bash
# 通过 Web UI
# 创建容器 → 选择模板 → 配置资源 → 完成
```

### 创建 KVM 虚拟机

1. 点击 "创建 VM"
2. 填写 VM ID 和名称
3. 选择 ISO 镜像
4. 配置 CPU、内存、磁盘
5. 选择网络类型
6. 完成

## 常用配置

### 存储配置

- 添加本地存储
- 配置 NFS/CIFS 远程存储
- 设置磁盘类型（VirtIO 或 SATA）

### 网络配置

- 创建网桥（Bridge）
- 配置 VLAN
- 设置防火墙规则

## 进阶功能

### 集群配置

```bash
# 添加节点
pvecm add your-node-ip

# 查看集群状态
pvecm status
```

### 备份与恢复

```bash
# 创建备份
vzdump --storage local --compress zstd --mode snapshot 100

# 恢复虚拟机
qmrestore vzdump-qemu-100.tar.gz 100
```

---

*更多 NAS 教程请关注 [NAS 频道](/nas/)。*
