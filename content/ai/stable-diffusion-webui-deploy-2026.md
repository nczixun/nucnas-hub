---
title: "Stable Diffusion WebUI 本地部署教程：2026最新版"
date: 2026-01-01
categories: ["ai"]
summary: "Stable Diffusion WebUI 本地部署教程，生成 AI 绘画"
tags: ["Stable Diffusion", "AI 绘画", "本地部署", "教程", "WebUI"]
slug: "stable-diffusion-webui-deploy-2026"
---

# Stable Diffusion WebUI 本地部署教程：2026最新版

## 什么是 Stable Diffusion？

Stable Diffusion 是一个开源的 AI 图像生成模型，可以生成高质量的图片。

## 系统要求

### 最低配置

| 组件 | 要求 |
|------|------|
| 显卡 | GTX 1660 Ti |
| 显存 | 6GB |
| 内存 | 16GB |
| 存储 | 50GB SSD |

### 推荐配置

| 组件 | 推荐 |
|------|------|
| 显卡 | RTX 4070+ |
| 显存 | 12GB+ |
| 内存 | 32GB |
| 存储 | 100GB SSD |

## 安装步骤

### 1. 安装依赖

```powershell
# 安装 Python 3.10
winget install Python.Python.3.10

# 安装 Git
winget install Git.Git
```

### 2. 克隆项目

```powershell
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

### 3. 运行 WebUI

```powershell
# Windows
./webui.bat

# Linux/macOS
./webui.sh
```

## 常用参数

### 文生图参数

| 参数 | 说明 | 推荐值 |
|------|------|--------|
| Prompt | 提示词 | 详细描述 |
| Negative Prompt | 负面提示词 | 低质量、变形 |
| Steps | 采样步数 | 20-30 |
| CFG Scale | 引导强度 | 7-10 |
| Seed | 随机种子 | -1 随机 |

### 高分辨率修复

```python
# 开启 Hires.fix
Hires fix: True
Upscale by: 2
Denoising strength: 0.4
```

## 推荐模型

### 写实风格

| 模型 | 特点 |
|------|------|
| Realistic Vision | 真实感强 |
| Juggernaut XL | 高细节 |
| Deliberate | 创意丰富 |

### 动漫风格

| 模型 | 特点 |
|------|------|
| Animagine XL 3.1 | 动漫专用 |
| Pix2Pix | 风格转换 |
| Counterfeit | 复古动漫 |

## 本地模型存放位置

```
stable-diffusion-webui/
└── models/
    └── Stable-diffusion/
        └── model.safetensors
```

## 常用插件

| 插件 | 功能 |
|------|------|
| ControlNet | 姿势控制 |
| LoRA | 风格微调 |
| VAE | 画质提升 |
| Deforum | 动画生成 |

## 常见问题

### Q: 显存不够怎么办？

A: 使用量化版本模型，或开启 CPU 模式（不推荐，速度慢）

### Q: 生成速度慢？

A: 使用 xFormers 加速：

```powershell
pip install xformers
```

### Q: 模型放在哪里？

A: `models/Stable-diffusion` 目录

## 性能优化

### 显存优化

1. 使用 --lowvram 参数
2. 选择量化模型
3. 减少批处理数量

### 速度优化

1. 安装 xFormers
2. 使用 TensorRT 优化
3. 选择合适的采样器 (DPM++ 2M Karras)

## 总结

Stable Diffusion WebUI 让 AI 绘画变得简单，部署到本地可以无限生成图片。

**下一步**：选择一个喜欢的模型，开始创作吧！
