---
title: "Day 5: 飞牛OS远程访问 —— Tailscale/FRP完美方案"
date: 2026-03-11
summary: "通过Tailscale或FRP实现外网安全访问飞牛OS。"
categories: ["nas"]
slug: "fnos-day5-remote"
tags: ["飞牛OS", "远程访问", "Tailscale", "FRP"]
image: https://images.pexels.com/photos/373543/pexels-photo-373543.jpeg
---

# Day 5: 飞牛OS远程访问

## 为什么需要远程访问？

不在家时也能：
- 📁 访问文件
- 🎬 观看影片
- ⚙️ 管理设置

## 方案一：Tailscale（推荐）

### 什么是Tailscale？

基于WireGuard的异地组网工具，简单安全。

### 安装步骤

1. 在飞牛OS中安装Tailscale
2. 登录账号获取设备密钥
3. 记录设备节点

### 配置

```bash
# 启动Tailscale
tailscale up --accept-routes

# 查看状态
tailscale status
```

### 优点
- ✅ 免费
- ✅ 加密安全
- ✅ 简单易用
- ✅ 支持所有设备

## 方案二：FRP内网穿透

### 什么是FRP？

通过中转服务器实现内网穿透。

### 服务端配置

```yaml
# frps.ini
[common]
bind_port = 7000
token = your_token
```

### 客户端配置

```yaml
# frpc.ini
[common]
server_addr = your_server
server_port = 7000
token = your_token

[ssh]
type = tcp
local_ip = 192.168.1.100
local_port = 22
remote_port = 6000
```

### Docker部署FRP

```yaml
version: '3'
services:
  frpc:
    image: snowdreamtech/frpc
    volumes:
      - ./frpc.ini:/etc/frp/frpc.ini
    restart: unless-stopped
```

## 方案三：DDNS动态域名

适用于有公网IP的用户：

1. 注册DDNS服务（如花生壳）
2. 在路由器设置DDNS更新
3. 使用域名访问

## 安全建议

- ⚠️ 使用强密码
- ⚠️ 启用防火墙
- ⚠️ 优先使用Tailscale

## 明天预告

Day 6我们将介绍Docker应用部署，让飞牛OS更强大。

---

*关注我，每天学习飞牛OS！*
