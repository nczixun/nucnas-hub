---
title: "Stable Diffusion WebUI 本地部署教程：免费生成 AI 画作"
date: 2026-03-08
category: "AI"
tags: ["Stable Diffusion", "本地部署", "AI 绘图", "Docker"]
description: "详解 Stable Diffusion WebUI 本地部署方法，零成本运行 AI 绘图"
---

# Stable Diffusion WebUI 本地部署教程：免费生成 AI 画作

## 为什么本地部署？

 Stable Diffusion（简称 SD）是开源 AI 绘图模型，完全免费可用。部署在本地意味着：
- 无限生成，不受 API 费用限制
- 隐私安全，图片不外传
- 可自定义模型、插件

## 硬件要求

| 配置 | 最低 | 推荐 |
|------|------|------|
| 显卡 | GTX 1060 6GB | RTX 3060 12GB+ |
| 内存 | 16GB | 32GB |
| 存储 | 50GB | 100GB+ |

核显或低端显卡也能运行，但生成速度较慢。

## 方法一：Windows 一键安装（推荐新手）

### 第一步：安装 Python 与 Git

1. 下载 [Python 3.10.6](https://www.python.org/)（**务必勾选 Add to PATH**）
2. 下载 [Git for Windows](https://git-scm.com/)

### 第二步：克隆项目

```powershell
# 创建工作目录
mkdir C:\SD-WebUI
cd C:\SD-WebUI

# 克隆官方仓库
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
```

### 第三步：下载模型

1. 访问 [Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0) 下载 `sd_xl_base_1.0.safetensors`
2. 放入 `models\Stable-diffusion` 目录

### 第四步：启动运行

```powershell
cd C:\SD-WebUI
webui-user.bat
```

首次启动会下载依赖，约 10-15 分钟。启动成功后，浏览器访问 `http://127.0.0.1:7860`。

## 方法二：Docker 部署（适合进阶用户）

```yaml
# docker-compose.yml
version: '3.8'
services:
  sd-webui:
    image: ghcr.io/akebus/stable-diffusion-webui:latest
    container_name: sd-webui
    ports:
      - "7860:7860"
    volumes:
      - ./models:/app/stable-diffusion-webui/models
      - ./outputs:/app/stable-diffusion-webui/outputs
    environment:
      - CLI_ARGS=--xformers --precision full --no-half
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

```bash
docker-compose up -d
```

## 基础使用指南

1. **Prompt（正向提示词）**：描述你想画的内容，如 `1girl, long hair, sunset, detailed`
2. **Negative Prompt（反向提示词）**：不想要的元素，如 `low quality, blurry, extra fingers`
3. **Sampling Steps**：采样步数，20-30 足够
4. **CFG Scale**：提示词引导强度，7-12 推荐
5. **尺寸**：默认 512x512，可设为 1024x1024（需要高清模型）

## 常见问题

**Q：生成速度多少？**
A：RTX 3060 约 3-5 秒/图，RTX 4090 约 1-2 秒/图。

**Q：模型放哪里？**
A：`models\Stable-diffusion` 目录，支持 .safetensors 和 .ckpt 格式。

**Q：报 CUDA 错误怎么办？**
A：确保 NVIDIA 驱动 >= 535，更新 CUDA Toolkit。

---

本地部署 Stable Diffusion 是 AI 绘画的第一步。部署完成后，你可以尝试 ControlNet 控图、LoRA 微调、ComfyUI 工作流等进阶玩法，画出商业级作品。
