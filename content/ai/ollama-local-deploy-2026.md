---
title: "Ollama 本地部署完全指南：2026最新版"
date: 2026-01-01
categories: ["ai"]
summary: "Ollama 本地部署教程，支持 Llama、Qwen、DeepSeek 等主流大模型"
tags: ["Ollama", "本地部署", "LLM", "AI", "教程"]
slug: "ollama-local-deploy-2026"
---

# Ollama 本地部署完全指南：2026最新版

## 什么是 Ollama？

Ollama 是一个让你在本地运行大语言模型的工具，支持 Llama、Qwen、DeepSeek 等主流开源模型。

## 支持的模型

| 模型 | 显存要求 | 推荐场景 |
|------|----------|----------|
| Llama 3.1 8B | 8GB | 日常对话 |
| Qwen2.5 14B | 16GB | 专业任务 |
| DeepSeek R1 8B | 8GB | 推理任务 |
| DeepSeek R1 70B | 80GB | 复杂推理 |

## 安装步骤

### Windows 安装

```powershell
# 使用 winget 安装
winget install Ollama.Ollama

# 或下载安装包
# https://ollama.com/download/windows
```

### macOS 安装

```bash
brew install ollama
```

### Linux 安装

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

## 常用命令

### 查看可用模型

```bash
ollama list
```

### 拉取模型

```bash
# 拉取 Llama 3
ollama pull llama3

# 拉取 Qwen 2.5
ollama pull qwen2.5

# 拉取 DeepSeek R1
ollama pull deepseek-r1:8b
```

### 运行模型

```bash
# 交互式对话
ollama run llama3

# 指定参数
ollama run qwen2.5 --temperature 0.7 --top-p 0.9
```

### 自定义模型

```bash
# 创建 Modelfile
FROM llama3
PARAMETER temperature 0.8
SYSTEM "你是一个专业的技术顾问"

# 导入自定义模型
ollama create my-model -f Modelfile
```

## API 调用

### 基础 API

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "你好",
  "stream": false
}'
```

### Python 调用

```python
import ollama

response = ollama.generate(
    model='llama3',
    prompt='什么是NAS？'
)
print(response['response'])
```

## 性能优化

### 量化版本

| 量化级别 | 显存占用 | 质量损失 |
|----------|----------|----------|
| FP16 | 100% | 无 |
| Q8_0 | 50% | 极小 |
| Q4_K_M | 25% | 较小 |
| Q2_K | 15% | 明显 |

### GPU 加速

确保 NVIDIA 驱动已安装：

```bash
nvidia-smi
```

## 常见问题

### Q: 显存不够怎么办？

A: 选择量化版本，如 `qwen2.5:7b-q4_k_m`

### Q: 模型下载慢？

A: 使用镜像源或先下载到本地再导入

### Q: 如何自定义端口？

```bash
OLLAMA_HOST=0.0.0.0:8080 ollama serve
```

## 搭配使用

### + OpenWebUI

```bash
docker run -d -p 8080:8080 \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

### + LangChain

```python
from langchain_community.llms import Ollama

llm = Ollama(model="llama3")
```

## 总结

Ollama 让本地运行大模型变得非常简单，是 AI 爱好者和开发者的必备工具。

**下一步**：选择一个模型，开始你的本地 AI 之旅吧！
