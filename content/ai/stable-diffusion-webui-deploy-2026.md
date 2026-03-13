---
title: "Stable Diffusion WebUI 本地部署教程：零刻 SER8 跑 AI 绘画实测"
date: 2026-03-08
categories: ["ai"]
brand: "SD"
model: "WebUI"
platform: "ollama"
slug: "stable-diffusion-webui-deploy"
tags: ["Stable Diffusion", "AI 绘画", "本地部署", "零刻 SER8", "WebUI"]
---

# Stable Diffusion WebUI 本地部署教程：零刻 SER8 跑 AI 绘画实测

Stable Diffusion (SD) 是目前最流行的开源 AI 绘画模型。之前很多人觉得必须要有显卡才能跑 SD，其实 AMD 核显也能跑！今天手把手教你在迷你主机上部署 SD WebUI。

## 环境说明

**测试设备：** 零刻 SER8 8845HS
**系统：** Ubuntu 22.04 LTS
**内存：** 32GB DDR5
**显卡：** AMD Radeon 780M（12CU）

## 安装步骤

### 1. 更新系统

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3.11 python3.11-venv git wget
```

### 2. 安装 AMD ROCm（关键步骤）

AMD 显卡需要安装 ROCm 驱动才能调用 GPU 加速：

```bash
# 添加 ROCm 源
wget https://repo.radeon.com/rocm/apt/6.1.3/rocm.gpg.key
sudo apt-key add rocm.gpg.key
echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/6.1.3/ ubuntu main' | sudo tee /etc/apt/sources.list.d/rocm.list

sudo apt update
sudo apt install rocm-libs rocm-dev
```

### 3. 克隆 WebUI 仓库

```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

### 4. 修改启动参数

编辑 `webui-user.sh`：

```bash
# 添加以下内容
export COMMANDLINE_ARGS="--precision full --no-half --use-rocm"
export HSA_OVERRIDE_GFX_VERSION=11.0.0
```

### 5. 启动 WebUI

```bash
./webui.sh
```

首次启动会自动下载模型，约 5-10GB。耐心等待。

## 性能实测

**生成参数：** 512x512 Steps 20 CFG 7

| 模型 | 生成时间 | 显存占用 |
|------|----------|----------|
| sd-v1-5 | 45 秒 | 4.2GB |
| sd-xl-base | 120 秒 | 8GB |

**实际体验：** 
- 512x512 出图可以接受
- 1024x1024 需要 3-4 分钟
- 不适合批量出图，但体验 AI 绘画足够

## 常见问题

**Q：ROCm 安装失败？**
A：检查系统版本，Ubuntu 22.04 最稳。也可以用 Docker 镜像方案。

**Q：出图很慢怎么办？**
A：AMD 核显性能有限，建议降低分辨率或使用优化模型（如 SD-Turbo）。

**Q：模型放哪里？**
A：默认路径 `stable-diffusion-webui/models/Stable-diffusion/`

## 总结

用零刻 SER8 部署 SD WebUI 完全可行，虽然速度不如 RTX 显卡，但作为学习体验完全够用。如果要商业出图，还是建议上 RTX 4080 以上的显卡。

下一期讲如何用 ComfyUI 搭建工作流，提升出图效率。