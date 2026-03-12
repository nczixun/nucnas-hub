---
title: "Ollama 本地部署 DeepSeek R1：最低配置要求"
date: 2026-03-07
categories: ["ai"]
brand: "本地部署"
model: "Ollama + DeepSeek R1"
slug: "ollama-deepseek-r1-deploy-minipc-2026"
---

# Ollama 本地部署 DeepSeek R1：最低配置要求

DeepSeek R1 开源后，很多人想本地部署。最低配置到底是多少？

**不同参数模型配置要求：**

| 模型 | 量化版本 | 显存要求 | 内存要求 | 推荐设备 |
| :--- | :--- | :--- | :--- | :--- |
| 1.5B | Q4_K_M | 4GB | 8GB | N100 迷你主机 |
| 7B | Q4_K_M | 8GB | 16GB | 核显轻薄本 |
| 14B | Q5_K_M | 12GB | 24GB | 游戏本 / 迷你主机 |
| 32B | Q4_K_M | 20GB | 32GB | 台式机 / 显卡坞 |
| 70B | Q4_K_M | 43GB | 64GB | 多卡服务器 |

**实测数据：**
- N100 部署 1.5B 模型：每秒 8 tokens
- 8845HS 部署 7B 模型：每秒 15 tokens
- 13900H + 32GB 内存：7B 模型每秒 25 tokens

**部署命令：**

```bash
ollama run deepseek-r1:1.5b
```

模型太大？用 **llama.cpp** 做量化处理，效果差不多，占用少一半。
