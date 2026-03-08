---
title: "Day 4: 飞牛OS网络配置 —— 打造高速私有云"
date: 2026-03-10
summary: "学习飞牛OS的网络配置，实现局域网访问和IP设置。"
categories: ["nas"]
slug: "fnos-day4-network"
tags: ["飞牛OS", "网络", "IP", "局域网"]
---

# Day 4: 飞牛OS网络配置


## 基础网络设置

### 1. 登录管理界面

首次安装后，通过以下地址访问：
```
http://fnos.local
# 或使用IP地址
http://192.168.x.x
```

### 2. 设置静态IP（推荐）

在Web界面：
```
设置 → 网络 → 以太网 → 静态IP
```

建议设置：
- IP地址：192.168.1.100（根据实际网段）
- 子网掩码：255.255.255.0
- 网关：192.168.1.1
- DNS：223.5.5.5（阿里DNS）

## 常用网络方案

### 方案一：旁路由模式

飞牛OS作为辅助路由器：
```
光猫 → 主路由 → 飞牛NAS
```

### 方案二：主路由模式

飞牛OS作为主路由（高级）：
```
光猫 → 飞牛NAS → 下级设备
```

## 端口转发

### 常用端口

| 服务 | 端口 | 用途 |
|------|------|------|
| HTTP | 80 | Web管理 |
| HTTPS | 443 | 安全Web |

---

<div class="page-nav">
  <a href="/guide/fnos-day3-install/" rel="prev">上一页：Day 3：飞牛OS安装教程</a>
  <a href="/guide/fnos-day5-remote/" rel="next">下一页：Day 5：飞牛OS远程访问</a>
</div>

*本文由 NUC NAS Hub 自动生成*
