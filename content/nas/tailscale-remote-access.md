---
title: "Tailscale 内网穿透教程：随时随地访问 NAS"
date: 2026-01-01
categories: ["nas"]
summary: "Tailscale 内网穿透教程，免费稳定"
tags: ["Tailscale", "内网穿透", "远程访问", "NAS"]
slug: "tailscale-remote-access"
---

# Tailscale 内网穿透教程

## 什么是 Tailscale？

Tailscale 是基于 WireGuard 的内网穿透工具，简单易用。

## 为什么选择 Tailscale？

- ✅ 免费个人使用
- ✅ 简单易用
- ✅ 稳定快速
- ✅ 支持所有平台

## 安装步骤

### 1. 注册账号

访问 tailscale.com 注册账号。

### 2. 下载客户端

- Windows：官网下载
- macOS：`brew install tailscale`
- Linux：`curl -fsSL https://tailscale.com/install.sh | sh`

### 3. 登录

```bash
tailscale up
```

会自动打开浏览器登录。

## 使用方法

### 访问 NAS

```bash
# 查看设备列表
tailscale status

# 通过设备名访问
ssh user@nas100.tail-scale.ts.net
```

### 端口转发

```bash
# 转发 NAS 的 8080 端口到本地
tailscale funnel 8080
```

### 开启节点

```bash
# 将 NAS 作为出口节点
tailscale up --advertise-exit-node
```

## 应用场景

### 1. 访问 NAS 文件

```
\\nas100.tail-scale.ts.net
```

### 2. 远程桌面

```
mstsc /v:nas100.tail-scale.ts.net
```

### 3. SSH 登录

```
ssh user@nas100.tail-scale.ts.net
```

## 常见问题

### Q: 连接慢？

A: 尝试使用 DERP 中继服务器

### Q: 流量限制？

A: 免费版每月 100GB，足够使用

## 总结

Tailscale 是访问 NAS 的最佳方案，简单稳定。

**推荐指数**：⭐⭐⭐⭐⭐
