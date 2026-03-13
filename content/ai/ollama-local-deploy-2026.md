---
title: "Ollama 本地部署教程：迷你主机/NAS 跑大模型完全指南"
date: 2026-03-07
categories: ["ai"]
brand: "Ollama"
model: "Ollama"
slug: "ollama-local-deploy-2026"
---

# Ollama 本地部署教程：迷你主机/NAS 跑大模型完全指南

想在本地跑大模型？**Ollama** 是最简单的选择。一行命令安装，支持 Llama 3、DeepSeek R1、Qwen 等主流模型，完全离线运行。

这篇文章详细讲解如何在迷你主机、NAS 上部署 Ollama，打造你的私人 AI 服务器。


## 一、为什么选择 Ollama？

| 优势 | 说明 |
| :--- | :--- |
| 🚀 **极简安装** | 一行命令搞定，无需配置环境 |
| 📦 **模型丰富** | 支持 100+ 开源大模型 |
| 💻 **跨平台** | Windows/Mac/Linux/NAS 全支持 |
| 🔒 **完全离线** | 数据不出本地，隐私安全 |
| 🆓 **完全免费** | 无 API 费用，无使用限制 |
| ⚡ **性能优化** | 自动量化，显存占用更低 |


## 二、硬件要求与模型选择

### 2.1 内存/显存需求

| 模型参数量 | 最低内存 | 推荐内存 | 适合设备 |
| :--- | :--- | :--- | :--- |
| 1.5B-3B | 4GB | 8GB | N100 迷你主机 |
| 7B-8B | 8GB | 16GB | 8845HS/Ultra5 主机 |
| 14B-16B | 16GB | 32GB | 32GB 内存主机 |
| 32B-34B | 24GB | 48GB | 带 GPU 主机 |
| 70B+ | 48GB | 64GB+ | 高端工作站 |

### 2.2 推荐模型

**日常对话：**
- Llama 3.2 3B（轻量快速）
- Qwen2.5 7B（中文优秀）
- DeepSeek R1 7B（推理强）

**专业任务：**
- Qwen2.5 14B（代码/写作）
- Llama 3.1 70B（最强开源）
- Mixtral 8x7B（MoE 架构）

**中文优先：**
- Qwen2.5 系列（阿里出品）
- DeepSeek R1（国产之光）
- Yi 系列（零一万物）


## 三、安装教程

### 3.1 Windows 安装

1. 访问官网：https://ollama.com/download
2. 下载 Windows 安装包
3. 双击安装（约 1 分钟）
4. 打开命令行测试：
```bash
ollama --version
```

### 3.2 Linux/Mac 安装

```bash
# 一键安装脚本
curl -fsSL https://ollama.com/install.sh | sh

# 验证安装
ollama --version

# 启动服务（后台运行）
ollama serve
```

### 3.3 群晖 NAS 安装（Docker）

```bash
# 拉取镜像
docker pull ollama/ollama

# 创建数据目录
mkdir -p /volume1/docker/ollama

# 运行容器
docker run -d \
  --name ollama \
  --restart always \
  -v /volume1/docker/ollama:/root/.ollama \
  -p 11434:11434 \
  ollama/ollama
```

### 3.4 飞牛 OS 安装

飞牛 OS 应用中心直接搜索"Ollama"，一键安装即可。


## 四、下载与使用模型

### 4.1 下载模型

```bash
# 查看可用模型
ollama list

# 下载模型（以 Qwen2.5 7B 为例）
ollama pull qwen2.5:7b

# 下载量化版本（更省内存）
ollama pull qwen2.5:7b-q4_k_m

# 下载中文优化版
ollama pull qwen2.5:7b-instruct
```

### 4.2 开始对话

```bash
# 命令行对话
ollama run qwen2.5:7b

# 输入问题，直接得到回答
> 如何用 Python 读取 CSV 文件？
```

### 4.3 常用命令

```bash
# 查看已下载模型
ollama list

# 查看模型信息
ollama show qwen2.5:7b

# 删除模型
ollama rm qwen2.5:7b

# 更新模型
ollama pull qwen2.5:7b

# 复制模型
ollama cp qwen2.5:7b my-qwen
```


## 五、Web UI 配置（推荐）

命令行够用，但 Web 界面更友好。

### 5.1 Open WebUI（推荐）

```bash
# Docker 安装
docker run -d \
  --name open-webui \
  --network host \
  -v open-webui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

访问：`http://你的 IP:8080`

### 5.2 其他 Web UI

| 项目 | 特点 | 安装难度 |
| :--- | :--- | :--- |
| **Open WebUI** | 功能最全，类似 ChatGPT | ⭐⭐ |
| **Continue** | VSCode 插件，编程专用 | ⭐ |
| **AnythingLLM** | 支持本地知识库 | ⭐⭐ |
| **Lobe Chat** | 界面美观，插件丰富 | ⭐⭐ |


## 六、性能优化

### 6.1 GPU 加速（NVIDIA）

```bash
# 确认 GPU 识别
nvidia-smi

# Ollama 会自动调用 GPU
# 可通过环境变量调整
export OLLAMA_GPU_LAYERS=33
ollama run qwen2.5:7b
```

### 6.2 量化选择

| 量化级别 | 内存节省 | 质量损失 | 推荐场景 |
| :--- | :--- | :--- | :--- |
| Q4_K_M | 40% | 很小 | 日常使用 |
| Q5_K_S | 30% | 几乎无 | 专业任务 |
| Q6_K | 20% | 无 | 高精度需求 |
| Q8_0 | 10% | 无 | 极限测试 |

```bash
# 下载量化版本
ollama pull llama3.2:3b-q4_k_m
```

### 6.3 上下文长度

```bash
# 修改模型配置
ollama cp qwen2.5:7b qwen2.5-8k
ollama mod qwen2.5-8k context_window 8192
```


## 七、应用场景

### 7.1 私人助理
- 📝 文案写作、邮件回复
- 📊 数据分析、总结摘要
- 🌐 翻译、润色

### 7.2 开发辅助
- 💻 代码生成、Debug
- 📖 技术文档查询
- 🔧 脚本编写

### 7.3 本地知识库
配合 RAG 技术，构建私人知识库：
- 📁 企业文档
- 📕 个人笔记
- 🎓 学习资料

### 7.4 NAS+AI 组合
在 NAS 上部署 Ollama，全家设备都能访问：
- 手机 App 远程调用
- 智能家居语音助手
- 自动化任务处理


## 八、常见问题

### Q1: 下载速度慢？
A：使用国内镜像或夜间下载，7B 模型约 4GB。

### Q2: 回答速度慢？
A：1. 使用量化版本；2. 增加 GPU；3. 升级内存。

### Q3: 如何更新 Ollama？
A：Windows/Mac 重新下载安装包；Linux 重新运行安装脚本。

### Q4: 可以在 NAS 上 24 小时运行吗？
A：可以，Docker 方式部署后设置`--restart always`。

### Q5: 如何外网访问？
A：配置 Tailscale 组网或 Frp 内网穿透。


## 九、总结

Ollama 让**本地大模型部署**变得前所未有的简单。无论是迷你主机还是 NAS，都能轻松运行私人 AI。

**核心优势：**
- 🆓 免费开源，无 API 费用
- 🔒 数据本地，隐私安全
- ⚡ 离线可用，无网络依赖
- 🇨🇳 中文模型丰富，效果好

**关键词：** Ollama、本地大模型、迷你主机 AI、NAS 部署 AI、私有 AI 服务器、Llama 3、DeepSeek R1、离线 AI
