---
title: "本地大模型部署指南：Ollama配置全攻略"
date: 2026-03-18
categories: ["AI"]
tags: ["Ollama", "本地大模型", "LLM", "AI部署", "本地AI"]
description: "详解Ollama本地大模型部署配置，从安装到优化，手把手教你搭建私人AI助手。"
keywords: ["Ollama", "本地大模型", "LLM部署", "私有AI", "本地AI助手"]
author: "NUC NAS Hub"
---

# 本地大模型部署指南：Ollama配置全攻略

## 为什么选择Ollama？

Ollama是目前最流行的本地大模型运行平台：
- **一键安装**：apt-get install ollama
- **模型丰富**：Llama、Qwen、Mistral等
- **跨平台**：支持Linux、Mac、Windows
- **高性能**：GPU/CPU自适应

## 硬件要求

### 最低配置

| 配置 | 要求 |
|------|------|
| 内存 | 8GB |
| 存储 | 10GB可用空间 |
| 系统 | Ubuntu 20.04+ |

### 推荐配置

| 配置 | 要求 | 可运行模型 |
|------|------|----------|
| 内存 | 16GB | 7B Q4 |
| 内存 | 32GB | 13B Q4 |
| 显存 | 8GB | 7B FP16 |

## 安装步骤

### Linux安装

```bash
# 安装Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 验证安装
ollama --version

# 启动服务
ollama serve
```

### Docker安装（推荐）

```yaml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    environment:
      - OLLAMA_HOST=0.0.0.0
    restart: unless-stopped

volumes:
  ollama_data:
```

## 常用命令

### 模型管理

```bash
# 查看可用模型
ollama list

# 拉取模型
ollama pull qwen2.5:7b

# 删除模型
ollama remove qwen2.5:7b

# 复制模型
ollama cp qwen2.5:7b qwen2.5:7b-custom
```

### 运行模型

```bash
# 交互式对话
ollama run qwen2.5:7b

# 带参数运行
ollama run qwen2.5:7b --temperature 0.7 --top-p 0.9

# API服务模式
# 自动启动，无需额外配置
```

## 推荐模型

### 中文模型

```bash
# Qwen2.5（推荐）
ollama pull qwen2.5:7b
ollama pull qwen2.5:7b-instruct

# 通义千问
ollama pull qwen:7b
ollama pull qwen:14b

# DeepSeek
ollama pull deepseek-r1:7b
ollama pull deepseek-r1:14b
```

### 英文/代码模型

```bash
# Llama 3.1
ollama pull llama3.1:8b

# Mistral
ollama pull mistral:7b

# Phi
ollama pull phi3.5:3.8b

# CodeLlama
ollama pull codellama:7b
```

### 轻量模型（低配设备）

```bash
# 3B级别
ollama pull phi3.5:3.8b
ollama pull llama3.2:3b

# 7B量化版
ollama pull qwen2.5:7b-q4_K_M
ollama pull mistral:7b-q4_K_M
```

## API调用

### Python调用示例

```python
import requests

url = "http://localhost:11434/api/chat"
payload = {
    "model": "qwen2.5:7b",
    "messages": [
        {"role": "user", "content": "你好"}
    ],
    "stream": False
}

response = requests.post(url, json=payload)
print(response.json()["message"]["content"])
```

### REST API

```bash
# 对话接口
curl -X POST http://localhost:11434/api/chat \
  -d '{
    "model": "qwen2.5:7b",
    "messages": [{"role": "user", "content": "你好"}]
  }'

# 生成接口
curl -X POST http://localhost:11434/api/generate \
  -d '{
    "model": "qwen2.5:7b",
    "prompt": "写一首诗"
  }'
```

## 性能优化

### 环境变量配置

```bash
# 设置GPU层数（0=只用CPU）
export OLLAMA_GPU_LAYERS=999

# 设置线程数
export OLLAMA_NUM_THREADS=8

# 设置内存
export OLLAMA_MAX_LOADED_MODELS=1

# 开启Flash Attention
export OLLAMA_FLASH_ATTENTION=1
```

### 配置文件

```bash
# 创建配置文件
mkdir -p ~/.config/ollama
nano ~/.config/ollama/ollama.env

# 添加以下内容
OLLAMA_GPU_LAYERS=999
OLLAMA_NUM_THREADS=8
OLLAMA_FLASH_ATTENTION=1
```

## 搭配OpenWebUI

### Docker Compose

```yaml
version: '3.8'

services:
  openwebui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: openwebui
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    depends_on:
      - ollama
    restart: unless-stopped

  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    volumes:
      - ollama_data:/root/.ollama
    restart: unless-stopped

volumes:
  ollama_data:
```

### 使用体验

- Web界面直观友好
- 支持多模型切换
- 对话历史自动保存
- 支持角色扮演

## 常见问题

### 问题1：内存不足

**解决**：使用量化模型
```bash
ollama pull qwen2.5:7b-q4_K_M
```

### 问题2：速度太慢

**解决**：
1. 检查GPU是否被识别
2. 减少并发请求
3. 使用量化模型

### 问题3：模型加载失败

**解决**：
1. 检查磁盘空间
2. 重新拉取模型
3. 查看日志：`docker logs ollama`

### 问题4：无法远程访问

**解决**：
```bash
# 设置环境变量
export OLLAMA_HOST=0.0.0.0
```

## 进阶应用

### 个人知识库（RAG）

结合LangChain + ChromaDB：
```python
from langchain_community.llms import Ollama
from langchain_community.embeddings import OllamaEmbeddings
```

### API封装

使用FastAPI创建自定义API：
```python
from fastapi import FastAPI
from langchain_community.llms import Ollama

app = FastAPI()
llm = Ollama(model="qwen2.5:7b")

@app.post("/chat")
def chat(message: str):
    return {"response": llm.invoke(message)}
```

## 总结

Ollama让本地大模型部署变得简单。推荐配置：
- **入门**：8GB内存 + N100/N150
- **主流**：16GB内存 + 8845HS
- **专业**：32GB内存 + 独立显卡

**下一步建议**：
- 搭配OpenWebUI获得更好的交互体验
- 使用RAG构建个人知识库
- 尝试不同模型找到最适合自己的

**相关文章**：
- [8845HS大模型实测](/review/8845hs-llm-benchmark)
- [本地AI部署方案对比](/ai/local-ai-deployment-comparison)
