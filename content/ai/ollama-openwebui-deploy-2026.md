---
title: "Ollama + OpenWebUI 本地部署：10分钟构建私人AI助手"
date: 2026-03-07
categories: ["ai"]
summary: "Ollama 2026 最新版安装教程，配合 OpenWebUI 实现 ChatGPT 体验。支持 DeepSeek R1、Qwen2.5、Llama3.1 等主流模型，完全离线运行，数据不出本地。"
slug: "ollama-openwebui-deploy-2026"
tags: ["Ollama", "OpenWebUI", "本地部署", "DeepSeek R1", "AI 教程"]
---

# Ollama + OpenWebUI 本地部署：10分钟构建私人AI助手

2026 年，本地 AI 部署已经非常成熟。Ollama + OpenWebUI 组合，能让你在本地拥有和 ChatGPT 几乎一样的体验，而且**完全免费、数据不出本地**。

## 为什么选择 Ollama + OpenWebUI？

1. **完全免费**：无需 API 费用
2. **数据隐私**：完全离线运行
3. **多模型支持**：DeepSeek R1、Qwen2.5、Llama3.1 等
4. **上手简单**：10 分钟部署完成

## 部署步骤

### 1. 安装 Ollama

```bash
# Windows
winget install Ollama.Ollama

# 或者使用安装包
```

### 2. 安装 OpenWebUI

```bash
# 使用 Docker
docker run -d -p 8080:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### 3. 访问使用

打开浏览器访问 `http://localhost:8080`

## 支持的模型

| 模型 | 显存要求 | 推荐场景 |
|------|----------|----------|
| Llama3.1 8B | 8GB | 日常对话 |
| Qwen2.5 14B | 16GB | 专业任务 |
| DeepSeek R1 70B | 80GB | 复杂推理 |

## 常见问题

**Q: 显存不够怎么办？**
A: 选择量化版本，如 Q4_K_M、Q5_K_S

**Q: 如何更新模型？**
A: `ollama pull 模型名称`
