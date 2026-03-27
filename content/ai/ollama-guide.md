---
title: "本地运行大模型：Ollama完全指南"
date: 2026-03-27T21:00:00+08:00
draft: false
categories: ["AI技术"]
tags: ["Ollama", "大模型", "本地部署", "LLM", "教程"]
description: "如何在本地运行大语言模型？Ollama让这一切变得简单。本文详解Ollama的安装、配置与模型选择。"
featured_image: "/images/ollama-cover.jpg"
toc: true
---

## 为什么选择本地运行大模型

- **隐私安全**：数据不出本地
- **成本可控**：一次性投入，无API调用费用
- **定制灵活**：可微调、可离线使用

## Ollama是什么

Ollama是一个开源的大模型运行框架，支持在本地运行 llama、mistral、qwen 等主流模型。

## 安装步骤

### 1. 下载安装
```bash
# macOS
brew install ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh

# Windows（WSL2推荐）
curl -fsSL https://ollama.com/install.sh | sh
```

### 2. 验证安装
```bash
ollama --version
```

### 3. 拉取模型
```bash
# 基础模型（约4GB）
ollama pull llama3.2:1b

# 中等模型（约8GB）
ollama pull qwen2.5:7b

# 中文优化模型
ollama pull qwen2.5:7b-instruct
```

## 使用方法

### 命令行交互
```bash
ollama run llama3.2:1b
```

### API调用
```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:1b",
  "prompt": "你好，介绍一下你自己"
}'
```

## 性能优化建议

### GPU加速
- NVIDIA显卡：自动启用CUDA加速
- AMD显卡：ROCm支持（实验性）

### 内存管理
- 8GB RAM：运行7B参数模型
- 16GB RAM：运行14B参数模型
- 32GB RAM：运行70B参数模型

### 模型量化
推荐使用Q4_K_M量化，平衡性能与显存占用。

## 常见问题

### 模型下载太慢？
使用镜像源或P2P下载工具。

### 显存不够？
选择更小的量化版本（如Q2_K）或更小的基础模型。

---

*参考文档：https://github.com/ollama/ollama*