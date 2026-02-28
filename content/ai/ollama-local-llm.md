---
title: "本地部署 AI 大模型：Ollama 安装使用教程"
date: 2026-02-28
categories: ["ai"]
summary: "Ollama 本地部署 AI 大模型教程，教你如何在电脑上运行 LLaMA、Qwen 等大模型"
image: "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg"
slug: "ollama-local-llm"
tags: ["Ollama", "本地部署", "大模型", "LLaMA"]
brand: "教程"
model: "AI部署"
---

# 本地部署 AI 大模型：Ollama 安装使用教程

还在为 ChatGPT API 付费而心疼？本文教你如何用 Ollama 在本地部署大模型，完全免费，离线可用！

## 什么是 Ollama？

Ollama 是一个简化大语言模型本地部署的工具，支持 Windows、Mac、Linux 系统，让你可以在自己的电脑上运行各种开源大模型。

## 支持的模型

- **LLaMA 3**：Meta 开源大模型
- **Qwen**：阿里通义千问
- **Mistral**：欧洲最强开源模型
- **Phi**：微软小模型
- **Gemma**：Google 开源模型

## 安装步骤

### Windows 安装

1. 下载 Ollama for Windows
   官网：https://ollama.com

2. 运行安装程序

3. 打开终端（PowerShell 或 CMD）

4. 验证安装：
```bash
ollama --version
```

### 模型下载

选择你想要的模型，运行以下命令：

```bash
# 下载 Qwen（推荐中文用户）
ollama pull qwen

# 下载 LLaMA 3
ollama pull llama3

# 下载 Mistral
ollama pull mistral

# 下载 Phi（最小模型，适合低配置）
ollama pull phi
```

### 运行模型

```bash
# 交互式对话
ollama run qwen

# 指定参数运行
ollama run llama3 --temperature 0.7 --top-p 0.9
```

## 硬件要求

| 模型 | 最低显存 | 推荐显存 |
|------|----------|----------|
| Phi | 4GB | 8GB |
| Mistral | 8GB | 12GB |
| LLaMA 3 8B | 12GB | 16GB |
| Qwen 14B | 16GB | 24GB |
| LLaMA 3 70B | 40GB | 80GB |

**没有独立显卡？** 可以用 CPU 运行，但速度较慢。

## 集成到应用

### 作为 API 调用

```bash
# 启动 API 服务
ollama serve

# 调用示例
curl http://localhost:11434/api/generate -d '{
  "model": "qwen",
  "prompt": "你好",
  "stream": false
}'
```

### 在 VS Code 中使用

安装 Cody 等插件，配置本地 Ollama 作为后端。

## 性能优化

### GPU 加速

确保显卡驱动正确安装，Ollama 会自动调用 GPU。

### 量化模型

下载量化版本，减少显存占用：

```bash
ollama pull llama3:8b-q4_0
```

### 批量处理

避免频繁调用，使用批处理提高效率。

## 常见问题

**Q：模型下载太慢？**
A：建议配置代理或使用镜像站。

**Q：显存不够怎么办？**
A：选择小模型（如 Phi）或量化版本。

**Q：回答速度慢？**
A：确保显卡加速驱动正确，或使用更小的模型。

## 相关工具

- **LM Studio**：图形界面，https://lmstudio.ai
- **GPT4All**：开源大模型管理工具
- **Text Generation WebUI**：功能最全的 Web 界面

---

*本文由 NUC NAS Hub 自动生成*
