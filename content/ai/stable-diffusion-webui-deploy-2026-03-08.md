---
title: "Stable Diffusion WebUI 本地部署教程：AI 绘画一键安装"
date: 2026-03-08T15:03:00+08:00
category: ["AI"]
tags: ["Stable Diffusion", "WebUI", "本地部署", "AI 绘画", "Docker"]
draft: false
---

 Stable Diffusion 是目前最流行的开源 AI 绘画工具，本文将详细介绍在本地部署 Stable Diffusion WebUI 的完整方案，让你可以轻松实现 AI 生成图片。

## 硬件要求

**最低配置**
- 显存： 6GB（RTX 1060 6GB 起步）
- 内存： 16GB
- 存储： 50GB+ SSD

**推荐配置**
- 显存： 8GB+
- 内存： 32GB
- SSD： 100GB+

显卡性能直接影响出图速度，建议使用 NVIDIA 显卡以获得最佳体验。

## Windows 系统部署

### 1. 安装 Python 和 Git

首先从官网下载并安装 Python 3.10+ 和 Git。

```bash
# 验证安装
python --version
git --version
```

### 2. 克隆 WebUI 仓库

```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

### 3. 运行启动脚本

```bash
# Windows 用户直接运行
webui-user.bat
```

首次启动会自动下载所需模型，可能需要较长时间。

## Docker 部署（推荐）

### 1. 安装 Docker Desktop

从官网下载并安装 Docker Desktop。

### 2. 创建配置文件

创建 `docker-compose.yml` 文件：

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
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

### 3. 启动容器

```bash
docker-compose up -d
```

## 模型下载与配置

### 常用模型推荐

| 模型 | 用途 | 大小 |
|------|------|------|
| sd-v1-5.safetensors | 基础模型 | 4GB |
| dreamshaper | 艺术风格 | 2GB |
| realistic-vision | 写实风格 | 2GB |

### 模型存放路径

```
stable-diffusion-webui/
└── models/
    └── Stable-diffusion/
        └── your-model.safetensors
```

## 常见问题

1. **显存不足**：尝试使用更小的模型或开启低显存模式
2. **启动失败**：检查 NVIDIA 驱动和 CUDA 是否正确安装
3. **下载慢**：建议使用国内镜像源或手动下载模型

## 性能优化

- 使用 xformers 提升出图速度
- 开启 attention slicing 降低显存占用
- 使用 VAE 优化图片质量
