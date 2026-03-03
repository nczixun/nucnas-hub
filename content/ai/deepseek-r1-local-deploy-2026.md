---
title: "本地部署DeepSeek-R1：如何在迷你主机上运行671B参数的AI大模型？"
date: 2026-03-03
categories: ["ai"]
brand: "AI部署"
model: "DeepSeek-R1"
platform: "ollama"
official_url: "https://deepseek.com"
bilibili_url: "https://search.bilibili.com/all?keyword=DeepSeek-R1+本地部署"
youtube_url: "https://www.youtube.com/results?search_query=DeepSeek+R1+local+deploy"
pros: 
  - "推理能力超强"
  - "开源免费"
  - "支持蒸馏版本"
  - "中文能力优秀"
cons: 
  - "671B版本需要顶级配置"
  - "推理速度依赖硬件"
  - "显存要求极高"
slug: "deepseek-r1-local-deploy-2026"
tags: 
  - "教程"
  - "AI"
  - "大模型"
---

# 本地部署DeepSeek-R1：如何在迷你主机上运行最强开源推理模型

**更新日期：** 2026年3月3日

## 一、 前言

DeepSeek-R1是中国团队开发的开源推理大模型，在数学、代码、推理等任务上直逼GPT-4，且完全开源可免费使用。

本文详细介绍如何在迷你主机/NAS上本地部署DeepSeek-R1的不同参数版本。

## 二、 硬件要求

### 2.1 各版本硬件需求

| 模型版本 | 参数量 | 最低显存 | 推荐配置 |
| :--- | :--- | :--- | :--- |
| **R1-Distill-Qwen-1.5B** | 15亿 | 4GB | N100迷你主机 |
| **R1-Distill-Qwen-7B** | 70亿 | 8GB | 8845HS/12650H |
| **R1-Distill-Qwen-14B** | 140亿 | 16GB | 12700H+16GB |
| **R1-Distill-Qwen-32B** | 320亿 | 32GB | 12700H+RTX 4070 |
| **R1-Full** | 6710亿 | 128GB+ | 多卡A100/H100 |

### 2.2 推荐设备

**性价比之选：**
- 零刻SER8（8845HS + 32GB内存）
- Minisforum HX99G（12650H + 32GB）
- 任何支持64GB内存的NUC

**高性能之选：**
- 华硕RS500（12700H + RTX 4070）
- 自行组装ITX主机

## 三、 部署方案

### 方案一：Ollama（推荐新手）

**安装Ollama：**

```bash
# Linux/Windows WSL
curl -fsSL https://ollama.com/install.sh | sh

# Windows直接下载安装包
```

**运行DeepSeek-R1：**

```bash
# 1.5B版本（适合N100/N305）
ollama run deepseek-r1:1.5b

# 7B版本（适合8845HS）
ollama run deepseek-r1:7b

# 14B版本（需要16GB+内存）
ollama run deepseek-r1:14b
```

### 方案二：LM Studio（图形界面）

1. 下载 [LM Studio](https://lmstudio.ai/)
2. 搜索 "DeepSeek-R1"
3. 选择对应版本下载
4. 点击运行

### 方案三：vLLM（高性能推理）

```bash
# 安装vLLM
pip install vllm

# 启动API服务
python -m vllm.entrypoints.api_server \
  --model deepseek-ai/DeepSeek-R1-Distill-Qwen-7B \
  --tensor-parallel-size 1
```

## 四、 性能优化

### 4.1 GPU加速

确保安装CUDA驱动（NVIDIA显卡）：

```bash
# 检查CUDA
nvidia-smi

# 设置环境变量
export CUDA_VISIBLE_DEVICES=0
```

### 4.2 量化版本

如果显存不足，使用量化版本：

| 量化等级 | 显存需求 | 性能损失 |
| :--- | :--- | :--- |
| Q4_K_M | -40% | <5% |
| Q5_K_S | -25% | <3% |
| Q8_0 | 0 | 0% |

```bash
# 下载量化版本
ollama run deepseek-r1:14b-q4_K_M
```

### 4.3 多线程优化

```bash
# 设置线程数
export OLLAMA_NUM_PARALLEL=4
export OLLAMA_THREADS=8
```

## 五、 API调用

### 5.1 本地API

```bash
# 启动API服务
ollama serve

# 调用示例
curl http://localhost:11434/api/generate -d '{
  "model": "deepseek-r1:7b",
  "prompt": "写一个Python快速排序算法",
  "stream": false
}'
```

### 5.2 接入OpenWebUI

```bash
# 安装Open WebUI
docker run -d -p 8080:8080 \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
  --name openwebui \
  --restart always \
  ghcr.io/openwebui/openwebui:main
```

## 六、 常见问题

### Q1: 推理速度慢？

**解决：**
- 使用量化版本
- 确保GPU加速
- 降低max_tokens

### Q2: 内存不足？

**解决：**
- 选择更小参数版本
- 使用Q4_K_M量化
- 增加物理内存

### Q3: 中文回答质量差？

**解决：**
- 使用Distill-Qwen版本（中文优化更好）
- 调整system prompt强调中文

## 七、 实际应用场景

### 7.1 代码助手

```python
# 示例：让R1帮你写代码
prompt = """你是Python专家。请帮我写一个高效的文件去重脚本。
要求：
1. 内存高效
2. 支持大文件
3. 输出去重后的文件列表
"""
```

### 7.2 本地知识库

结合AnythingLLM + DeepSeek-R1：
1. 安装AnythingLLM
2. 配置Ollama为LLM后端
3. 上传文档即可对话

### 7.3 AI写作助手

- 长文写作
- 翻译润色
- 头脑风暴

## 八、 总结

DeepSeek-R1是目前最强的开源推理模型之一，通过合理选择参数版本，完全可以在迷你主机上本地部署：

| 推荐方案 | 适合人群 |
| :--- | :--- |
| 1.5B/7B + Ollama | 入门用户/N100设备 |
| 14B + LM Studio | 进阶用户/游戏本 |
| 32B + vLLM | 专业用户/台式机 |

**相关文章：**
- [Minipc本地部署LLM指南](/ai/deploy-llm-mini-pc-2026)
- [Ollama入门教程](/ai/ollama-local-llm)

---

### 📺 相关视频
<div style='display: flex; gap: 15px; flex-wrap: wrap; margin-top: 20px;'>
    <a href='https://search.bilibili.com/all?keyword=DeepSeek-R1+本地部署' target='_blank' class='glass-card' style='flex: 1; padding: 20px; display: flex; align-items: center; gap: 15px; text-decoration: none; color: inherit;'>
        <div style='width: 40px; height: 40px; background: #FB7299; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;'>B</div>
        <div><div style='font-weight: 700;'>Bilibili 教程</div></div>
    </a>
</div>
