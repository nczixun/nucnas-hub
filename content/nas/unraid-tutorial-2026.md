---
title: "Unraid 入门教程：虚拟机 + Docker + 阵列，全能 NAS 系统安装配置"
date: 2026-03-08
categories: ["nas"]
brand: "Lime Technology"
model: "Unraid"
slug: "unraid-nas-tutorial"
tags: ["Unraid", "NAS", "虚拟机", "Docker", "阵列"]
---

# Unraid 入门教程：虚拟机 + Docker + 阵列，全能 NAS 系统安装配置

如果你想要一台**既能当 NAS，又能跑虚拟机**的 All-in-One 服务器，Unraid 是个不错的选择。相比群晖和 TrueNAS，Unraid 的优势在于**灵活的配置**和**近乎无感的阵列扩展**。

## 为什么选择 Unraid？

1. **不用一次性买齐硬盘**——可以逐块添加，最高支持 30 块
2. **阵列安全性高**——支持单盘、双盘容错
3. **虚拟机 + Docker 双支持**——一台机器搞定所有需求
4. **功耗低**——只有存取数据时才唤醒硬盘

## 硬件推荐

| 用途 | 最低配置 | 推荐配置 |
|------|----------|----------|
| 家用 | N100 + 8GB | i3-12100 + 32GB |
| 进阶 | i5-1240P + 32GB | i7-12700 + 64GB |

## 安装步骤

### 1. 制作启动 U 盘

下载 [Unraid OS](https://unraid.net/)，使用 Rufus 写入 U 盘。

### 2. 设置 BIOS

开机进 BIOS，开启 **VT-d** 和 **Intel VT-x**，设置 U 盘启动。

### 3. 初始化配置

1. 浏览器访问 `http://unraid.local`
2. 设置管理员密码
3. 添加硬盘（注意：系统盘会占用一个 U 盘位）

### 4. 基础设置

- **阵列模式**：选择 "Cache Pool" 加速读写
- **共享设置**：开启 SMB/NFS 用于局域网访问
- **Docker**：在 "Docker" 页面下载镜像

## 常用 Docker 推荐

| 容器 | 用途 |
|------|------|
| Jellyfin | 影视服务器 |
| Home Assistant | 智能家居 |
| AdGuard | 广告过滤 |
| Bitwarden | 密码管理 |

## 常见问题

**Q：数据安全吗？**
A：Unraid 支持双盘容错，坏一块盘不丢数据。建议搭配 UPS 防止意外断电。

**Q：速度怎么样？**
A：万兆网络下，读取可达 500MB/s+，千兆也能跑满。

总的来说，Unraid 适合**动手能力强、想要高度定制化**的用户。如果只想省心存储，还是群晖更合适。
