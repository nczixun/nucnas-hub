---
title: 「NAS跑AI」完全指南：用Ollama在私有云上部署本地大模型
date: "2026-03-30"
category: "ai"
tags: ["NAS", "AI", "Ollama", "本地部署", "私有云", "大模型"]
description: "本文详解如何在NAS上通过Ollama部署本地大模型，包括硬件要求、部署步骤、性能测试以及模型推荐，让你的NAS变成一台7x24小时运行的AI服务器。"
---

2026年，本地AI部署不再是极客专属。随着开源模型的性能提升和NAS硬件的升级，越来越多的普通用户开始在私有云上运行自己的大模型。

这篇文章，我们来聊聊如何在NAS上用Ollama跑起来。

## 一、为什么用NAS跑AI？

先回答一个问题：已经有云服务了，为什么还要在NAS上跑本地模型？

**核心优势有三个：**

### 1. 隐私安全
数据不上传服务器，敏感文档、工作记录、家庭照片都在本地处理。2025年多起云服务数据泄露事件让很多人意识到，隐私才是最贵的。

### 2. 7x24小时在线
NAS本身就是为了7x24小时运行设计的。不用像云服务那样担心API限速、超时，也不用担心欠费停机。半夜让它跑个长文本分析，早上直接看结果。

### 3. 低成本长期运行
用电量约30W/小时（比普通台式机低70%），按0.6元/度算，一天不到0.5元。折算下来比按量付费的云服务便宜得多。

---

## 二、硬件要求

不是所有NAS都适合跑AI。先看配置要求：

### 最低配置（能跑7B模型）
- CPU：Intel Celeron J4125 或同等性能
- 内存：8GB（建议16GB）
- 盘位：2个以上（用于数据和模型存储）

### 推荐配置（能跑14B+模型）
- CPU：Intel N100 / AMD R5 5600G 或更高
- 内存：32GB
- 存储：NVMe SSD（模型加载速度关键）

### 实测参考

| NAS型号 | CPU | 内存 | 可跑模型 | 速度 |
|--------|-----|------|---------|------|
| 绿联DXP4800 Plus | N100 | 16GB | Qwen2.5-7B | ~15 token/s |
| 群晖DS923+ | R1000 | 8GB | Phi-3-mini | ~8 token/s |
| 极空间Z4Pro | i3-N305 | 32GB | DeepSeek-14B | ~12 token/s |

---

## 三、Ollama部署教程（3步完成）

### Step 1：安装Docker

大部分NAS系统都支持Docker。以绿联DXP4800 Plus为例：

```bash
# SSH登录NAS
ssh admin@192.168.1.x

# 安装Docker（Ubuntu/Debian）
sudo apt update
sudo apt install docker.io docker-compose
```

### Step 2：部署Ollama容器

```yaml
# docker-compose.yml
version: '3.8'
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - /volume1/docker/ollama:/root/.ollama
    environment:
      - OLLAMA_HOST=0.0.0.0
    restart: unless-stopped
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

**注意**：如果你的NAS没有独立GPU，Ollama会自动使用CPU推理，性能会低一些。

### Step 3：下载并运行模型

```bash
# 进入容器
docker exec -it ollama bash

# 下载Qwen2.5 7B模型（约4.4GB）
ollama pull qwen2.5:7b

# 下载DeepSeek 14B模型（约8.9GB）
ollama pull deepseek-r1:14b

# 测试运行
ollama run qwen2.5:7b "你好，请用三句话介绍自己"
```

---

## 四、常用模型推荐

### 按硬件配置选模型

| 内存容量 | 推荐模型 | 适用场景 |
|---------|---------|---------|
| 8GB | Phi-3-mini, Qwen2.5-3B | 简单问答、文本分类 |
| 16GB | Qwen2.5-7B, Phi-4 | 对话、翻译、代码 |
| 32GB | DeepSeek-R1-14B, Qwen2.5-14B | 复杂推理、长文分析 |

### 模型来源

推荐从这几个渠道获取：
- **Ollama官方库**：ollama.com/library
- **魔搭社区**：modelscope.cn（国内镜像，速度快）
- **HuggingFace**： huggingface.co（最大模型库）

---

## 五、性能优化技巧

### 1. 使用NVMe缓存

NAS自带的机械硬盘读取速度约150MB/s，NVMe SSD可达3500MB/s。将模型文件放在NVMe上，加载速度提升20倍。

```bash
# 将模型链接到NVMe目录
ln -s /volume1/nvme/ollama /root/.ollama
```

### 2. 启用GPU加速

如果你用的是带核显的Intel N系列CPU（如N100），Ollama支持Sycl加速：

```bash
# 设置环境变量
export OLLAMA_HOST=0.0.0.0
export OLLAMA_INTEL_GPU=true

# 重启容器
docker restart ollama
```

### 3. 批量处理优化

处理长文档时，关闭实时流式输出能提升约30%速度：

```python
import requests

response = requests.post(
    "http://192.168.1.x:11434/api/generate",
    json={
        "model": "qwen2.5:7b",
        "prompt": "你的提示词",
        "stream": False  # 关闭流式输出
    }
)
print(response.json()["response"])
```

---

## 六、NAS配置推荐

如果你的NAS还在规划阶段，这里是跑AI的最佳配置：

### 入门方案（预算2000元内）
- CPU：Intel N100
- 内存：16GB DDR5
- 存储：1TB NVMe + 4TB HDD
- 适用：Qwen2.5-7B，日常对话够用

### 进阶级方案（预算4000元）
- CPU：Intel i3-N305（8核，3.8GHz）
- 内存：32GB DDR5
- 存储：2TB NVMe + 8TB HDD
- 适用：DeepSeek-14B，中等复杂度推理

### 发烧级方案（预算8000元+）
- CPU：AMD R9 7900X
- 内存：64GB DDR5
- 存储：2TB NVMe x2 RAID0 + 16TB HDD
- 适用：Llama3-70B，复杂任务处理

---

## 总结

在NAS上跑AI已经不是极客专属。只要一台N100以上级别的NAS，16GB内存，就能跑起来7B参数的本地大模型。

**关键点回顾：**
1. 硬件门槛：N100 + 16GB内存是甜点配置
2. 部署方式：Docker + Ollama，3步搞定
3. 模型选择：Qwen2.5-7B最适合入门
4. 性能优化：NVMe缓存是关键

你的NAS配置够跑AI吗？欢迎评论区聊聊。

---

*相关阅读：*
- *[DDR5内存跌破300元！装机党终于等到了](https://nucnas.top/hardware/ddr5-memory-price-2026-03-30/)*

---

作者：NUC NAS Hub | 专注迷你主机、NAS与本地化AI部署