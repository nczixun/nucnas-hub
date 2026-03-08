---
title: "Day 5: 飞牛OS远程访问 —— Tailscale/FRP完美方案"
date: 2026-03-11
summary: "通过Tailscale或FRP实现外网安全访问飞牛OS。"
categories: ["nas"]
slug: "fnos-day5-remote"
tags: ["飞牛OS", "远程访问", "Tailscale", "FRP"]
---

# Day 5: 飞牛OS远程访问


## 为什么需要远程访问？

不在家时也能：
- ?? 访问文件
- ?? 观看影片
- ?? 管理设置

## 方案一：<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>（推荐）

### 什么是Tailscale？

基于WireGuard的异地组网工具，简单安全。

### 安装步骤

1. 在飞牛OS中安装<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>
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
- ? 免费
- ? 加密安全
- ? 简单易用
- ? 支持所有设备

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

---

<div class="page-nav">
  <a href="/guide/fnos-day4-network/" rel="prev">上一页：Day 4：飞牛OS网络配置</a>
  <a href="/guide/fnos-day6-docker/" rel="next">下一页：Day 6：飞牛OS Docker应用</a>
</div>

*本文由 NUC NAS Hub 自动生成*
