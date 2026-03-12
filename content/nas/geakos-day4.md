---
title: "GEAKOS 7 天入门教程：第 4 天 - 客户端安装与远程访问"
date: 2026-03-12
categories: ["NAS"]
summary: "GEAKOS 7天教程第4天：客户端下载安装、GEAK Link远程访问、局域网访问，避坑必看！"
image: "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800"
tags: ["NAS", "GEAKOS", "私有云", "教程", "7天入门"]
series: ["GEAKOS 7天教程"]
---

# GEAKOS 7 天入门教程：第 4 天 - 客户端安装与远程访问

![远程访问](https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800)

## 回顾

第 3 天我们完成了系统安装和初始化。今天将学习**客户端安装**和**远程访问配置**。

---

## 第 4 天：客户端下载

### 支持的平台

| 平台 | 下载方式 |
|------|----------|
| iOS | App Store |
| Android | 应用商店/APK |
| Windows | 官网下载 |
| macOS | 官网下载 |
| Linux | 官网下载 |

### 客户端功能

- 文件管理
- 相册备份
- 影视播放
- 系统设置

---

## 第 4 天：远程访问

### 方案 1：GEAK Link（推荐）

**步骤：**

1. 打开 GEAKOS 客户端
2. 点击「注册账号」
3. 输入手机号获取验证码
4. 设置 GEAK LINK ID（如：my-nas）
5. 即可通过 ID 远程访问

> **优点**：无需配置，随时可用
> **缺点**：依赖官方服务器

### 方案 2：局域网访问

直接通过 IP 访问：

```
http://192.168.x.x:9080
```

### 方案 3：内网穿透（进阶）

如需外网访问，可使用：

| 方案 | 优点 | 缺点 |
|------|------|------|
| cpolar | 免费额度够用 | 需配置 |
| frp | 稳定 | 需服务器 |
| Cloudflare Tunnel | 免费稳定 | 需域名 |

---

## ⚠️ 避坑指南

> **坑 1**：手机端局域网扫描可能失败，用 IP 或 GEAK ID 连接
> 
> **坑 2**：GEAK Link 需要手机号注册
> 
> **坑 3**：外网访问建议开启 HTTPS
> 
> **坑 4**：公网访问务必设置强密码

---

## 第 4 天任务清单

- [ ] 下载并安装客户端
- [ ] 注册 GEAK 账号
- [ ] 设置 GEAK LINK ID
- [ ] 测试局域网访问
- [ ] 测试远程访问（可选）

---

## 明天预告

第 5 天我们将学习**文件管理**和**SMB 共享**，让 NAS 真正用起来！

---

*本文是 GEAKOS 7 天教程系列第 4 篇*
*作者：NUC NAS Hub*
