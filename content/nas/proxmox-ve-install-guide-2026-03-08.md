---
title: "PVE 虚拟机安装教程：NAS 新手从入门到精通，一步到位"
date: 2026-03-08
categories: ["nas"]
brand: "Proxmox"
model: "PVE 8.2"
platform: "virtualization"
slug: "proxmox-ve-install-guide-2026"
tags: ["PVE", "虚拟机", "NAS", "Proxmox VE", "安装教程"]
---

# PVE 虚拟机安装教程：NAS 新手从入门到精通，一步到位

Proxmox VE（简称 PVE）是开源虚拟化平台，比 ESXi 免费、比 Unraid 功能强。今天手把手教你在 NUC/迷你主机上安装 PVE，打造 All-in-One 家庭服务器。

## 硬件要求

| 配置 | 最低要求 | 推荐配置 |
|------|----------|----------|
| CPU | 4 核（支持 VT-x/AMD-V） | 8 核以上 |
| 内存 | 8GB | 32GB+ |
| 存储 | 64GB SSD | 500GB NVMe + HDD |
| 网口 | 1G | 2.5G×2 或 10G |

**实测平台：** 零刻 SER8（AMD 7840HS，32GB，1TB NVMe）

## 安装步骤

### 1. 下载 PVE 镜像

访问官网下载最新 ISO：
```
https://www.proxmox.com/en/downloads
```
推荐版本：Proxmox VE 8.2（基于 Debian 12）

### 2. 制作启动 U 盘

```bash
# Windows 使用 Rufus
# macOS 使用 BalenaEtcher
# 写入模式选择 DD，不要选 ISO
```

### 3. BIOS 设置

开机按 Del/F2 进入 BIOS：
- 启用 VT-x/AMD-V（虚拟化）
- 启用 VT-d（直通支持）
- 关闭 Secure Boot
- 启动顺序设为 U 盘优先

### 4. 安装 PVE

```
1. 选择 Install Proxmox VE
2. 同意协议 → Next
3. 选择目标硬盘 → Next
4. 设置国家/时区（China/Asia/Shanghai）
5. 设置管理员密码
6. 配置网络：
   - IP：192.168.1.100（静态）
   - 网关：192.168.1.1
   - DNS：223.5.5.5
7. 确认配置 → Install
```

安装完成后重启，移除 U 盘。

### 5. 首次登录

浏览器访问：`https://192.168.1.100:8006`
- 用户名：root
- 密码：安装时设置

**注意：** 首次登录会提示证书警告，点击"高级→继续"即可。

## 创建虚拟机（以 OpenWrt 为例）

### 1. 上传 ISO

```
数据中心 → 本地 → ISO 镜像 → 上传
```

### 2. 创建 VM

```
创建虚拟机 → 基础：
- 名称：OpenWrt
- 系统：默认

CPU：
- 核心：2
- 类型：host（性能最佳）

内存：
- 512MB（OpenWrt 够用）

硬盘：
- 8GB，SSD 勾选

网络：
- 桥接 vmbr0

CD/DVD：
- 选择 OpenWrt ISO
```

### 3. 安装系统

```
1. 启动虚拟机
2. 按默认选项安装
3. 设置 root 密码
4. 配置网络（DHCP 或静态）
5. 安装完成，重启
```

## 常见问题排查

**问题 1：无法启动虚拟机**
- 检查 BIOS 虚拟化是否开启
- 确认 ISO 镜像完整

**问题 2：网络不通**
- 检查网桥配置（数据中心 → 系统 → 网络）
- 确认防火墙规则

**问题 3：直通失败**
- BIOS 启用 VT-d/IOMMU
- 内核参数添加：`intel_iommu=on` 或 `amd_iommu=on`

## 进阶配置

### 开启嵌套虚拟化（在 PVE 里装 PVE）

```bash
# 编辑配置文件
nano /etc/modprobe.d/kvm.conf

# 添加
options kvm_intel nested=1
# 或
options kvm_amd nested=1

# 重启
reboot
```

### 配置备份

```
数据中心 → 备份 → 添加存储
- 类型：PBS（Proxmox Backup Server）
- 或：NFS/SMB 网络存储
```

PVE 适合有一定 Linux 基础的用户，功能强大但学习曲线陡峭。新手建议先用虚拟机练手，熟悉后再部署到主力 NAS。
