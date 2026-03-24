---
title: "Ollama+DeepSeek R1本地部署完全指南：零基础也能学会"
date: 2026-03-24
categories: 
  - AI
  - 教程
tags: 
  - Ollama
  - DeepSeek R1
  - 本地部署
  - 大模型
---

# Ollama+DeepSeek R1本地部署完全指南：零基础也能学会

## 前言

DeepSeek R1作为国产开源大模型，凭借其强大的推理能力和开源特性，备受开发者关注。本文将详细介绍如何在本地使用Ollama部署DeepSeek R1，实现属于自己的AI助手。

## 为什么选择DeepSeek R1？

- **开源免费**：完全开源，可商用
- **推理能力强**：数学、代码能力出色
- **本地运行**：数据不出本地，隐私安全
- **多尺寸可选**：从1.5B到671B，满足不同硬件需求

## 硬件要求

| 模型尺寸 | 最低显存 | 推荐显存 | 适用场景 |
|----------|----------|----------|----------|
| 1.5B | 2GB | 4GB | 尝鲜体验 |
| 7B | 8GB | 12GB | 个人助手 |
| 14B | 16GB | 24GB | 专业使用 |
| 32B | 32GB | 48GB | 开发者 |
| 671B | 512GB+ | 1TB+ | 满血版 |

## 安装Ollama

### Windows系统

1. 访问 [Ollama官网](https://ollama.com)
2. 下载Windows版安装包
3. 运行安装程序，默认设置即可

### macOS系统

```bash
# 使用Homebrew安装
brew install ollama

# 或者下载dmg安装包
```

### Linux系统

```bash
# 一键安装脚本
curl -fsSL https://ollama.com/install.sh | sh
```

## 下载DeepSeek R1模型

### 查看可用模型

```bash
ollama list
```

### 选择并下载模型

```bash
# 入门体验（推荐配置低的用户）
ollama pull deepseek-r1:1.5b

# 主流选择（推荐大多数用户）
ollama pull deepseek-r1:7b

# 高性能选择（需要大显存）
ollama pull deepseek-r1:14b

# 满血版（需要大显存）
ollama pull deepseek-r1:671b
```

### 查看下载进度

```bash
# 下载完成后自动显示大小
ollama list
```

## 运行DeepSeek R1

### 基础对话

```bash
# 启动对话
ollama run deepseek-r1:7b
```

### 指定参数运行

```bash
# 指定上下文长度
ollama run deepseek-r1:7b --ctx-size 8192

# 指定线程数
ollama run deepseek-r1:7b --threads 8

# 开启交互模式
ollama run deepseek-r1:7b -i
```

## API服务配置

### 启动API服务

Ollama默认在11434端口提供API服务：

```bash
# 查看Ollama服务状态
curl http://localhost:11434/api/tags
```

### 调用API示例

```bash
# 使用curl调用
curl http://localhost:11434/api/generate -d '{
  "model": "deepseek-r1:7b",
  "prompt": "用Python写一个快速排序算法",
  "stream": false
}'
```

### 在Python中使用

```python
import requests

url = "http://localhost:11434/api/generate"
payload = {
    "model": "deepseek-r1:7b",
    "prompt": "你好，请介绍一下自己",
    "stream": False
}

response = requests.post(url, json=payload)
print(response.json()["response"])
```

## 性能优化

### GPU加速

确保NVIDIA GPU驱动已安装，Ollama会自动调用GPU加速。

```bash
# 查看GPU状态
ollama list
```

### 内存优化

如果显存不足，可以量化模型：

```bash
# Q4量化版本（更小更快）
ollama pull deepseek-r1:7b-q4_0
```

### 多模型管理

```bash
# 删除不需要的模型
ollama rm deepseek-r1:1.5b

# 复制模型
ollama cp deepseek-r1:7b my-deepseek
```

## 常见问题

### Q1: 下载速度慢怎么办？

建议使用国内镜像源，或者使用Aria2多线程下载。

### Q2: 模型运行内存不足？

选择更小的模型尺寸，或使用量化版本。

### Q3: 如何更新模型？

```bash
ollama pull deepseek-r1:7b
```

### Q4: 如何远程访问？

Ollama默认只监听本地，如需远程访问：

```bash
# 临时设置环境变量
export OLLAMA_HOST=0.0.0.0:11434
ollama serve
```

## 进阶应用

### 搭建个人AI助手

结合Open WebUI，可以搭建类似ChatGPT的Web界面：

```bash
# 安装Open WebUI
docker run -d -p 8080:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### RAG知识库

结合LangChain，可以搭建本地RAG系统：

```bash
# 安装LangChain
pip install langchain-ollama
```

## 总结

通过Ollama部署DeepSeek R1，整个过程简单易上手，即使是零基础用户也能在10分钟内完成部署。本地运行的大模型不仅响应速度快，而且数据隐私有保障，是追求高效和安全的用户的理想选择。

---

*更多AI教程和本地部署方案，欢迎访问NUC NAS Hub（nucnas.top）。*
