---
title: "GEAKOS 7 天入门教程：第 2 天 - 制作启动盘与 BIOS 设置"
date: 2026-03-12
description: "GEAKOS 7天教程第2天：制作启动盘、BIOS设置、U盘启动，避坑必看！"
keywords: "GEAKOS, 启动盘制作, BIOS设置, Rufus, Ventoy, U盘启动"
categories: ["NAS"]
summary: "GEAKOS 7天教程第2天：制作启动盘、BIOS设置、U盘启动，避坑必看！"
image: "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800"
tags: ["NAS", "GEAKOS", "私有云", "教程", "7天入门", "启动盘", "BIOS"]
series: ["GEAKOS 7天教程"]
---

# GEAKOS 7 天入门教程：第 2 天 - 制作启动盘与 BIOS 设置

![启动盘制作](https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800)

## 回顾

第 1 天我们完成了硬件准备。今天将学习**制作启动盘**和**BIOS 设置**。

---

## 第 2 天：制作启动盘

### 2.1 下载 GEAKOS 镜像

前往 GEAKOS 官网下载最新 ISO 镜像。

> **提示**：建议下载简体中文版，避免语言问题。

### 2.2 准备工具

| 工具 | 用途 | 推荐 |
|------|------|------|
| U 盘 | 制作启动盘 | ≥8GB，品牌 U 盘 |
| 电脑 | 制作启动盘 | Windows/Mac/Linux |
| 写盘工具 | 写入镜像 | Rufus / Ventoy |

### 2.3 使用 Rufus 制作启动盘

**步骤：**

1. 下载并打开 [Rufus](https://rufus.ie/)
2. 插入 U 盘
3. 选择 U 盘设备
4. 点击「选择」按钮，选择 GEAKOS ISO 镜像
5. 分区方案选择 **GPT**
6. 目标系统类型选择 **UEFI**
7. 点击「开始」

![Rufus](https://help.fnnas.com/img_v3_02e1_c9914569-6898-4134-bfa8-21094f7ca10g.jpg)

### 2.4 使用 Ventoy 制作启动盘

**步骤：**

1. 下载 [Ventoy](https://www.ventoy.net/)
2. 安装 Ventoy 到 U 盘
3. 将 GEAKOS ISO 复制到 U 盘
4. 重启电脑从 U 盘启动

> **优点**：Ventoy 支持多系统引导，后续重装更方便

---

## 第 2 天：BIOS 设置

### 3.1 进入 BIOS

开机时按特定按键进入 BIOS：

| 品牌 | 按键 |
|------|------|
| 华硕 | Del / F2 |
| 技嘉 | Del / F2 |
| 微星 | Del |
| 联想 | F2 / Enter |
| 戴尔 | F2 |

> **技巧**：开机时仔细看屏幕提示，通常会显示 "Press XXX to enter setup"

### 3.2 关键 BIOS 设置

#### 1. 启动顺序设置

| 设置项 | 值 | 说明 |
|--------|-----|------|
| Boot Priority | U 盘优先 | 设置从 U 盘启动 |
| Boot Mode | UEFI | 建议使用 UEFI |

#### 2. 关闭安全启动

| 设置项 | 值 | 说明 |
|--------|-----|------|
| Secure Boot | Disabled | 关闭安全启动才能引导 |

#### 3. 开启虚拟化（可选）

| 设置项 | 值 | 说明 |
|--------|-----|------|
| Intel VT-x | Enabled | 虚拟机需要 |
| VT-d | Enabled | 直通需要 |

#### 4. 其他建议设置

| 设置项 | 值 | 说明 |
|--------|-----|------|
| CSM/Legacy | Disabled | 建议关闭 |
| Fast Boot | Disabled | 建议关闭 |

### 3.3 保存并退出

1. 按 F10 保存设置
2. 选择「Yes」确认
3. 电脑会自动重启

---

## ⚠️ 避坑指南

> **坑 1**：制作启动盘会格式化 U 盘，**提前备份数据**
> 
> **坑 2**：选择 GPT 分区格式，不要选 MBR
> 
> **坑 3**：部分电脑必须关闭 Secure Boot 才能启动
> 
> **坑 4**：不同品牌进入 BIOS 的按键不同，提前查好
> 
> **坑 5**：笔记本建议同时关闭 Fast Boot
> 
> **坑 6**：建议准备 2 个 U 盘，以防万一

---

## 第 2 天任务清单

- [ ] 下载 GEAKOS ISO 镜像
- [ ] 准备 8GB+ U 盘
- [ ] 使用 Rufus 制作启动盘
- [ ] 进入 BIOS 设置
- [ ] 设置 U 盘启动优先
- [ ] 关闭 Secure Boot

---

## 明天预告

第 3 天我们将进行**系统安装**和**初始化配置**，这是最关键的步骤！

---

*本文是 GEAKOS 7 天教程系列第 2 篇*
*作者：NUC NAS Hub*
