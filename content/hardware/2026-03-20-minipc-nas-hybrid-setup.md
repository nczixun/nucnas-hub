---
title: "迷你主机秒变NAS：Minisforum UM790 ProAllinOne方案实战"
date: 2026-03-20
categories:
  - 硬件
  - Mini PC
tags:
  - Mini PC
  - NAS
  - All in One
  - Minisforum
  - 软路由
description: "手把手教你用Minisforum UM790 Pro搭建AllinOne主机，实现NAS+软路由+HTPC一体化。"
---

# 迷你主机秒变NAS：Minisforum UM790 Pro All in One方案实战

对于追求效率的技术爱好者，"一台设备搞定一切"是终极目标。本文将详解如何用Minisforum UM790 Pro打造高性能All in One主机。

## 硬件基础：为什么选择UM790 Pro？

### 核心配置

| 参数 | 规格 |
|------|------|
| CPU | AMD Ryzen 9 7940HS (8核16线程) |
| 核显 | Radeon 780M (RDNA3, 12CU) |
| 内存 | DDR5 5600MHz, 双通道 |
| 存储 | PCIe 4.0 x4 + 2×SATA |
| 网口 | 2×2.5GbE |

### 适合AIO的优势

1. **8核16线程**：同时运行NAS+路由+虚拟机
2. **Radeon 780M**：硬件解码强于Intel核显
3. **双2.5G网口**：软路由理想选择
4. **PCIe 4.0**：高速存储不在话下
5. **65W TDP**：性能释放充分

## 系统方案选择

### 推荐：Proxmox VE + 容器 + LXC

```bash
# PVE安装后配置国内源
sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/pve-install-repo.list
apt update && apt dist-upgrade -y

# 安装常用工具
apt install -y curl wget git vim htop net-tools
```

### 虚拟机规划

| 虚拟机 | 类型 | CPU | 内存 | 用途 |
|--------|------|-----|------|------|
| TrueNAS Scale | VM | 4核 | 16GB | 存储核心 |
| OpenWrt | VM | 2核 | 2GB | 软路由 |
| Home Assistant | LXC | 2核 | 2GB | 智能家居 |
| Jellyfin | LXC | 2核 | 4GB | 媒体服务 |

## TrueNAS Scale配置

### 安装配置

```bash
# 启动后通过Web界面配置
# 存储池配置建议：
# - SSD 500GB: ZFS 镜像 (OS + Docker)
# - HDD 4TB×2: ZFS 镜像 (重要数据)
# - HDD 8TB×2: ZFS raidz2 (影音存储)

# 开启SMB共享
# Web界面: Sharing > SMB > Add
# 路径: /mnt/pool/media
# 允许: 用户名/password

# 开启NFS（可选）
# Web界面: Sharing > NFS > Add
# 路径: /mnt/pool/backup
```

### Docker管理

```bash
# 通过TrueNAS Web界面或CLI安装Portainer
# 推荐的Docker Compose配置：

version: '3.8'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    ports:
      - "9443:9443"
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    restart: unless-stopped
    ports:
      - "8080:80"
    volumes:
      - /mnt/pool/media:/srv
      - ./config:/config
    environment:
      - PUID=1000
      - PGID=1000

volumes:
  portainer_data:
```

## OpenWrt软路由配置

### 网络拓扑

```
光猫 (桥接) → OpenWrt (VM) → 交换机 → 各设备
                  ↓
            UM790 Pro (宿主机)
            ├── TrueNAS (VM)
            ├── Home Assistant (LXC)
            └── Jellyfin (LXC)
```

### OpenWrt配置

```bash
# 网络配置示例 (/etc/config/network)
config interface 'loopback'
    option device 'lo'
    option proto 'static'
    option ipaddr '127.0.0.1'
    option netmask '255.0.0.0'

config interface 'wan'
    option device 'eth0'
    option proto 'pppoe'
    option username 'YOUR_USERNAME'
    option password 'YOUR_PASSWORD'
    option ipv6 'auto'

config interface 'lan'
    option device 'br-lan'
    option proto 'static'
    option ipaddr '192.168.1.1'
    option netmask '255.255.255.0'
    option ip6assign '60'

# 开启UPnP
config upnpd
    option enabled '1'
    option internal_iface 'lan'
    option external_iface 'wan'
```

### 常用插件安装

```bash
# 通过OpenWrt Web界面安装
# System > Software > Update

# 推荐插件
- luci-app-sqm        # 智能QoS
- luci-app-adguardhome  # 广告拦截
- luci-app-wol        # 网络唤醒
- luci-app-mwan3      # 多线负载
- luci-app-zerotier   # 异地组网
```

## Home Assistant集成

### LXC容器配置

```bash
# 创建LXC容器
pct create 100 local:vzdump/backup.tar.zst \
  -arch amd64 \
  -cores 2 \
  -memory 2048 \
  -rootfs local-lvm:8 \
  -net0 name=eth0,bridge=vmbr1,firewall=1,hwaddr=XX:XX:XX:XX:XX:XX,ip=dhcp \
  -unprivileged 1 \
  -features keyctl=1,nesting=1

# LXC内安装Docker
apt update && apt install -y docker.io
systemctl enable docker

# 运行Home Assistant
docker run -d \
  --name homeassistant \
  --privileged \
  --network host \
  -v /homeassistant/config:/config \
  -v /run/dbus:/run/dbus:ro \
  --restart unless-stopped \
  homeassistant/home-assistant:stable
```

### 配置示例

```yaml
# /homeassistant/config/configuration.yaml

homeassistant:
  name: Home
  latitude: 32.0603
  longitude: 118.7969
  elevation: 0
  unit_system: metric
  time_zone: Asia/Shanghai
  currency: CNY
  country: CN

# 集成组件
assistant:
  mqtt:
    broker: 192.168.1.100
    port: 1883
    
# UI配置
frontend:
  themes: !include_dir_merge_named themes

# 自动化
automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
```

## Jellyfin媒体服务

### 硬件加速配置

```bash
# 容器配置
docker create \
  --name jellyfin \
  --gpus all \
  --device /dev/dri:/dev/dri \
  -e TZ=Asia/Shanghai \
  -e JELLYFIN_PublishedServerUrl=http://192.168.1.100:8096 \
  -p 8096:8096 \
  -p 8920:8920 \
  -v /mnt/storage/jellyfin/config:/config \
  -v /mnt/storage/jellyfin/cache:/cache \
  -v /mnt/storage/media:/media:ro \
  --restart unless-stopped \
  jellyfin/jellyfin:latest

# AMD核显参数
# - DOCKER_HOST:radeonsi
# 或使用 docker-compose:
```

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    environment:
      - TZ=Asia/Shanghai
      - JELLYFIN_PublishedServerUrl=http://192.168.1.100:8096
      - JELLYFIN__HttpServer__NumberOfEndPoints=2
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/storage/media:/media:ro
    ports:
      - "8096:8096"
      - "8920:8920"
    deploy:
      resources:
        reservations:
          devices:
            - driver: amd.com
              count: 1
              capabilities: [gpu]
```

### 性能对比

| 解码方式 | CPU占用 | 4K播放 |
|---------|---------|-------|
| 软件解码 | 60-80% | 吃力 |
| QuickSync (Intel) | 10-20% | 流畅 |
| VAAPI (AMD) | 5-15% | 流畅 |

## 性能调优

### PVE显卡直通

```bash
# 编辑 /etc/modprobe.d/vfio.conf
options vfio-pci ids=1002:15bf,1002:15c8

# 编辑 /etc/pve/qemu-server/VMID.conf
# 添加:
hostpci0: 0000:03:00,pcie=1,x-vga=1
```

### 存储性能优化

```bash
# SSD存储池启用压缩
zfs set compression=lz4 pool/docker

# HDD存储池禁用压缩（节省CPU）
zfs set compression=off pool/media

# 开启ARC缓存
echo 1 > /sys/module/zfs/parameters/zfs_arc_max
# 建议设置为内存的1/4
```

## 总结

UM790 Pro作为AIO主机的优势：

1. **性能强劲**：8核16线程+780M核显
2. **功耗适中**：65W TDP，满载约100W
3. **扩展丰富**：双2.5G网口+PCIe+SATA
4. **体积小巧**：比传统塔式服务器省空间

这样一套All in One方案，基本满足普通家庭的全部需求：存储、备份、路由、媒体、智能家居，一台机器全部搞定！
