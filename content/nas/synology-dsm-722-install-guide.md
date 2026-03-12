---
title: "群晖 DSM 7.2 安装教程：从零开始部署私有云"
date: 2026-03-07
categories: ["nas"]
brand: "Synology"
model: "DSM 7.2"
slug: "synology-dsm-722-install-guide"
---

# 群晖 DSM 7.2 安装教程：从零开始部署私有云

群晖系统是 NAS 界的标杆，今天手把手教你安装。

**准备工作：**

- 一台 x86 架构主机（Intel/AMD 处理器）
- 至少 2 条 4GB 以上内存
- 至少 2 块硬盘
- U 盘一个（8GB 以上）

**安装步骤：**

1. 下载 **Synology Assistant** 和 **DSM 固件**
2. U 盘量产启动盘（使用 **Rufus** 或 **Synology Bootloader**）
3. 主机 BIOS 设置 U 盘启动
4. 自动进入 DSM 界面，按照指引设置

**初始化配置：**

- 创建存储池（建议 SHR 模式）
- 开启 SSH 和 Telnet
- 配置 QuickConnect 实现外网访问

整个过程大约 30 分钟，新手也能搞定。后续会出更多 DSM 进阶教程。
