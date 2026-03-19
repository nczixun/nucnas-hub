---
title: "迷你主机软路由All in One指南：零刻EQ12+安装OpenWrt实战"
date: 2026-03-20
categories:
  - Hardware
tags:
  - 软路由
  - OpenWrt
  - All in One
  - 零刻EQ12
  - 迷你主机
description: "手把手教你用迷你主机搭建软路由，实现All in One功能，打造全能家庭网关。"
---

# 迷你主机软路由All in One指南：零刻EQ12+安装OpenWrt实战

## 为什么选择迷你主机做软路由？

相比传统路由器，迷你主机软路由优势明显：

- **性能强**：x86架构，NAT转发性能轻松破千兆
- **功能多**：广告屏蔽、流量监控、魔法上网
- **可扩展**：支持Docker，可运行各种服务
- **稳定**：7×24小时运行不发热
- **性价比**：千元级别实现高端路由器功能

## 硬件选择

### 推荐配置：零刻EQ12 N150

| 配置 | 参数 |
|-----|------|
| CPU | Intel N150 (4核) |
| 网卡 | RTL8125BG (2.5G×2) |
| 内存 | 16GB DDR4 |
| 存储 | 256GB NVMe SSD |
| 功耗 | 6-15W |

**为什么选N150**：
- 双2.5G网口（做软路由必须）
- 性能足够处理千兆带宽
- 功耗极低，可做All in One

### 网卡方案

| 网口需求 | 方案 |
|---------|------|
| 单WAN | 主板自带千兆 |
| 双WAN | 主板双2.5G |
| 多WAN | USB 2.5G网卡 |

## 系统选择

### 主流软路由系统

| 系统 | 特点 | 适合人群 |
|-----|------|---------|
| OpenWrt | 功能最全、插件丰富 | 进阶用户 |
| iStoreOS | 中文界面、易上手 | 新手 |
| pfSense | 企业级、安全稳定 | 专业用户 |
| 爱快 | 行为管理、流控强 | 网吧/企业 |

## 安装步骤

### 方案一：PVE虚拟机安装（推荐）

#### 1. 安装Proxmox VE

```bash
# 制作启动U盘
# 下载PVE ISO并制作启动盘

# 安装PVE
# 按照提示完成安装

# 更新源
apt update && apt upgrade -y
```

#### 2. 创建OpenWrt虚拟机

```bash
# 下载OpenWrt镜像
wget https://downloads.openwrt.org/releases/23.05.5/x86_64/openwrt-23.05.5-x86_64-generic-ext4-combined.img.gz
gunzip openwrt-23.05.5-x86_64-generic-ext4-combined.img.gz

# 转换为QCOW2格式
qemu-img convert -f raw -O qcow2 openwrt-23.05.5-x86_64-generic-ext4-combined.img openwrt.qcow2

# 上传镜像到PVE
qm importdisk 100 openwrt.qcow2 local-lvm
```

#### 3. 配置虚拟机

```
# 网络配置
# VM ID: 100
# CPU: 2核
# 内存: 2GB
# 网络: 桥接模式 (vmbr0 WAN, vmbr1 LAN)
```

### 方案二：直通网卡

```bash
# 查找网卡PCI地址
lspci | grep -i ethernet

# 直通网卡给虚拟机
qm set 100 -hostpci0 01:00,pcie=1
```

## All in One配置

### 推荐服务组合

| 服务 | 容器/Docker | 资源需求 |
|-----|------------|---------|
| OpenWrt | 虚拟机 | 2核/2GB |
| AdGuard Home | Docker | 1GB |
| Jellyfin | Docker | 2核/2GB |
| Home Assistant | Docker | 1GB |
| 双播助手 | Docker | 512MB |

### PVE网络拓扑

```
internet → 光猫(桥接) → 软路由(OpenWrt) → PVE虚拟交换机 → 各服务/设备
                                    ↓
                            All in One服务群
```

### Docker Compose配置

```yaml
version: '3.8'
services:
  adguard:
    image: adguard/adguardhome
    container_name: adguard
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000/tcp"
    volumes:
      - ./adguard/work:/opt/adguardhome/work
      - ./adguard/conf:/opt/adguardhome/conf
    restart: unless-stopped

  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - ./jellyfin/config:/config
      - ./jellyfin/cache:/cache
      - /mnt/media:/media
    devices:
      - /dev/dri:/dev/dri
    restart: unless-stopped

  homeassistant:
    image: homeassistant/home-assistant
    container_name: homeassistant
    ports:
      - "8123:8123"
    volumes:
      - ./homeassistant/config:/config
    network_mode: host
    restart: unless-stopped
```

## 性能优化

### CPU优化

```bash
# 开启CPU性能模式
echo 'performance' | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### 网络优化

```bash
# 开启BBR加速
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
```

### 节能优化

```bash
# 关闭不必要的虚拟化特性
qm set 100 -cpu host
qm set 100 -numa 1
```

## 常见问题

### Q1: 网卡无法直通？
- 确认BIOS中已开启VT-d
- 检查驱动是否加载

### Q2: 速度跑不满？
- 检查网线是否为六类
- 确认光猫是否为桥接模式
- 检查软路由负载

### Q3: All in One不稳定？
- 确认内存是否足够（建议16GB+）
- 检查散热条件
- 分开关键服务到独立虚拟机

## 总结

迷你主机软路由是性价比最高的选择：

- **硬件**：零刻EQ12 N150，约900元
- **系统**：OpenWrt免费
- **功能**：路由器+广告屏蔽+NAS+HTPC

一篇教程搞定全家网络升级，值得折腾！
