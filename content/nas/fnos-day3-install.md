---
title: "Day 3: 飞牛OS安装教程 —— 多种方式任你选"
date: 2026-03-09
summary: "详细介绍飞牛OS的多种安装方式：U盘启动、硬盘挂载、虚拟机。"
categories: ["nas"]
slug: "fnos-day3-install"
tags: ["飞牛OS", "安装", "教程", "U盘启动"]
---

# Day 3: 飞牛OS安装教程


## 安装方式一览

| 方式 | 难度 | 适用场景 |
|------|------|----------|
| U盘启动 | ⭐ | 体验/测试 |
| 硬盘安装 | ⭐⭐ | 主流用户 |
| 虚拟机 | ⭐⭐⭐ | 学习/测试 |

## 方式一：U盘启动安装

### 步骤1：下载镜像

访问飞牛OS官网下载最新镜像（.img.gz格式）

### 步骤2：制作启动盘

```bash
# Windows (使用Rufus)
# 1. 插入U盘
# 2. 打开Rufus，选择镜像
# 3. 点击开始

# Linux
sudo apt install gzip dd
sudo dd if=fnos.img of=/dev/sdX bs=4M status=progress
```

### 步骤3：设置启动

1. 进入BIOS设置U盘启动
2. 保存并重启
3. 按照屏幕提示完成安装

## 方式二：硬盘直装

### 步骤1：准备硬盘

建议使用SSD作为系统盘（至少16GB）

### 步骤2：使用Ventoy

1. 制作Ventoy启动盘
2. 放入飞牛OS镜像
3. 从Ventoy启动选择镜像

### 步骤3：安装到硬盘

```
选择目标磁盘 → 确认安装 → 等待完成
```

## 方式三：虚拟机安装

### 使用Proxmox

```yaml
# 创建虚拟机
qm create 100 \
  --name fnos \
  --cores 4 \
  --memory 8192 \
  --net0 virtio,bridge=vmbr0

# 导入镜像
qm importdisk 100 fnos.qcow2 vmbr0 --format qcow2
```

### 使用ESXi

类似Proxmox步骤，创建虚拟机后导入镜像即可。

---

<div class="page-nav">
  <a href="/nas/fnos-day2-hardware/" rel="prev">上一页：Day 2：飞牛OS硬件选购指南</a>
  <a href="/nas/fnos-day4-network/" rel="next">下一页：Day 4：飞牛OS网络设置</a>
</div>

*本文由 NUC NAS Hub 自动生成*
