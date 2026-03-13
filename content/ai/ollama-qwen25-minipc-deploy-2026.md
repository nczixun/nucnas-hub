---
title: "迷你主机跑本地大模型：Ollama部署Qwen2.5实测"
date: 2026-03-07
categories: ["ai"]
tags: ["Ollama", "本地大模型", "Qwen", "LLM部署"]
slug: "ollama-qwen25-minipc-deploy-2026"
---

# 迷你主机跑本地大模型：Ollama部署Qwen2.5实测

想用迷你主机跑本地大模型？没问题，今天手把手教你用 Ollama 部署 Qwen2.5，实测可用。

## 环境要求

- 迷你主机（推荐 AMD 8845HS 或 Intel Ultra 7 以上）
- 内存 32GB 以上（16GB 勉强跑 7B 模型）
- 硬盘 50GB 以上空间

## 安装步骤

### 1. 安装 Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Windows 用户直接去官网下载安装包。

### 2. 拉取模型

根据内存选择模型大小：

```bash
# 7B 模型（需要 16GB 内存）
ollama pull qwen2.5:7b

# 14B 模型（需要 32GB 内存）
ollama pull qwen2.5:14b
```

### 3. 启动服务

```bash
ollama serve
```

新开终端对话：

```bash
ollama run qwen2.5:7b
```

## 实测数据

**测试机型：** 零刻 SER8 8845HS + 32GB 内存

| 模型 | 首次加载 | 生成速度 | 内存占用 |
|------|----------|----------|----------|
| Qwen2.5:7b | 15 秒 | 20 token/s | 14GB |
| Qwen2.5:14b | 28 秒 | 12 token/s | 28GB |

## 进阶：WebUI 界面

推荐用 Open WebUI，界面美观：

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

访问 http://localhost:3000 即可。

## 适用场景

- 本地知识库问答
- 代码辅助编程
- 文档总结写作
- 离线 AI 助手

相比云端 API，本地部署**隐私安全**，**无限畅聊**，**成本为零**。感兴趣的赶紧试试！
