---
title: "Stable Diffusion WebUI 本地部署教程：显卡配置指南"
date: 2026-03-08T15:03:00+08:00
category: ["AI"]
tags: ["Stable Diffusion", "WebUI", "本地部署", "AI 绘画", "显卡", "教程"]
draft: false
---

想用 Stable Diffusion 生成图片，但不想用在线服务？这篇教你本地部署 WebUI，画图更自由。

## 硬件要求

最低配置：
- 显存 6GB（勉强能跑）
- 内存 16GB
- 硬盘 50GB+（模型很大）

推荐配置：
- 显存 8GB+
- 内存 32GB
- SSD 存储

## 环境准备

### 1. 安装 Python

建议使用 Anaconda 或直接安装 Python 3.10+：

```bash
# 检查 Python 版本
python --version
```

### 2. 安装 Git

```bash
# Windows 下安装 Git
winget install Git.Git
```

### 3. 克隆项目

```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

## 显卡驱动配置

### NVIDIA 显卡

确保安装了最新驱动，然后安装 CUDA：

```bash
# 检查驱动
nvidia-smi

# 安装 CUDA Toolkit（如果没装）
winget install NVIDIA.CUDA Toolkit
```

### AMD 显卡（Linux）

需要安装 ROCm：

```bash
# 添加 ROCm 仓库
sudo apt update
sudo apt install rocm-libs
```

## 启动 WebUI

### Windows

直接运行：

```bash
./webui-user.bat
```

首次启动会下载基础模型，需要一些时间。

### 自定义参数

修改 `webui-user.bat`：

```bat
set COMMANDLINE_ARGS=--xformers --medvram --opt-split-attention
```

参数说明：
- `--xformers`：使用 xformers 优化，显存更省
- `--medvram`：中等显存优化
- `--opt-split-attention`：优化注意力机制

## 显存优化技巧

### 1. 启用 xformers

```bash
pip install xformers
```

### 2. 降低生成分辨率

首次生成建议用 512x512，熟悉后再调高。

### 3. 使用模型量化

选择量化后的模型（如 SD 1.5 4bit 量化版）。

## 常见问题

**Q: 显存不够怎么办？**
A: 使用 --lowvram 模式，或者升级显卡。

**Q: 生成很慢怎么办？**
A: 确认显卡驱动和 CUDA 正确安装，启用 xformers。

**Q: 模型下载到哪里？**
A: `models/Stable-diffusion/` 目录。

## 推荐模型

入门推荐：
- Stable Diffusion 1.5（最成熟，生态最好）
- DreamShaper（人物效果好）
- Realistic Vision（写实风格）

## 我的配置分享

这是我的启动参数：

```bat
set COMMANDLINE_ARGS=--xformers --medvram --api --listen
```

配合 RTX 3060 12GB，基本能跑 1024x1024 分辨率。

---
*测试显卡：RTX 3060 12GB，驱动 535.154，Python 3.10.11*
