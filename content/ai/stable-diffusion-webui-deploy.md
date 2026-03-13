---
title: "Stable Diffusion WebUI 完整部署指南：AI 绘画本地化方案"
date: 2026-03-08
category: "AI"
tags: ["Stable Diffusion", "WebUI", "本地部署", "AI 绘画", "Docker"]
description: "使用 Docker 快速部署 Stable Diffusion WebUI，实现 AI 绘画本地化"
---

# Stable Diffusion WebUI 完整部署指南：AI 绘画本地化方案

## 为什么选择本地部署

 Stable Diffusion 是当前最流行的开源 AI 绘画工具，本地部署可以让你：
- 无限次免费生成图片
- 保护隐私，不上传作品到云端
- 自定义模型和插件
- 离线也能使用

## 硬件要求

| 项目 | 最低配置 | 推荐配置 |
|------|---------|---------|
| 显卡 | GTX 1060 6GB | RTX 3060 12GB+ |
| 内存 | 16GB | 32GB |
| 存储 | 50GB | 100GB+ |

显存越大，可以使用的模型越大，出图速度越快。

## Windows 本地部署

### 环境准备

1. 安装 Python 3.10+
2. 安装 Git
3. 安装 NVIDIA CUDA 驱动

### 快速部署

```bash
# 克隆仓库
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# 进入目录
cd stable-diffusion-webui

# 运行（Windows）
webui-user.bat
```

首次启动会自动配置环境并下载依赖。

## Docker 部署（推荐）

Docker 部署更加便捷，环境隔离也更干净。

### 1. 安装 Docker

从 [Docker官网](https://www.docker.com/) 下载 Docker Desktop。

### 2. 创建启动脚本

创建 `docker-compose.yml`：

```yaml
version: '3.8'
services:
  sd-webui:
    image: alvd/sd-webui-stable-diffusion:latest
    container_name: sd-webui
    ports:
      - "7860:7860"
    volumes:
      - ./models:/app/stable-diffusion-webui/models
      - ./outputs:/app/stable-diffusion-webui/outputs
    environment:
      - CLI_ARGS=--xformers --api
    runtime: nvidia
```

### 3. 启动服务

```bash
docker-compose up -d
```

访问 http://localhost:7860 即可使用。

## 常用模型推荐

### 基础模型
- sd-v1-5.safetensors：最常用的基础模型
- sd-xl-base-1.0.safetensors：SDXL 系列

### 风格模型
- dreamshaper：艺术风格
- realistic-vision：写实风格
-动漫风格模型

## 常用参数设置

| 参数 | 说明 | 推荐值 |
|------|------|-------|
| Steps | 采样步数 | 20-30 |
| CFG Scale | 提示词权重 | 7-12 |
| Sampler | 采样器 | Euler a / DPM++ |

## 常见问题

**Q: 显存不够怎么办？**
A: 使用 Tiled VAE 或开启低显存模式。

**Q: 出图很慢怎么办？**
A: 安装 xformers 插件，显著提升速度。

**Q: 模型下载失败？**
A: 使用国内镜像或手动下载后放置到对应目录。

## 总结

本地部署 Stable Diffusion WebUI 是 AI 绘画的最佳选择，推荐使用 Docker 方式部署，环境配置更简单。
