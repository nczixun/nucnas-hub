---
title: "本地大模型性能优化：让模型跑得更快"
date: 2026-03-06
categories: ["ai"]
summary: "通过量化、GPU加速等方式提升本地大模型运行速度"
image: "https://images.pexels.com/photos/159538/pexels-photo-159538.jpeg"
imageCredit: "Pexels"
tags: ["LLM", "optimization", "performance"]
---

# 本地大模型性能优化：让模型跑得更快

模型跑太慢？试试这几个优化方法。

## 1. 模型量化

量化就是用更少精度表示模型参数。

- FP16：精度损失小，速度提升有限
- INT8：速度提升2-3倍，效果还行
- INT4：速度提升4-5倍，效果打折但能用

推荐：Ollama默认就是量化后的模型，直接用即可。

## 2. GPU加速

有显卡的一定要开GPU加速。

Ollama设置：
```bash
# 查看是否用GPU
ollama list

# 重新加载模型用GPU
OLLAMA_HOST=0.0.0.0:11434 ollama serve
```

实测：
- 纯CPU：3 token/s
- GPU加速：25 token/s
差距巨大。

## 3. 降低上下文长度

上下文越长，内存和延迟越高。

```bash
ollama run llama3.2 --num.ctx 2048
```

一般对话2048足够，写代码可以开4096。

## 4. 使用更小的模型

7B模型足够日常使用，14B以上需要大内存。

实测对比：
- Llama 3.2 7B：8GB内存，流畅
- Llama 3.2 14B：16GB内存，卡顿

5. 关闭Swap

Linux下关闭Swap能减少内存抖动：
```bash
sudo swapoff -a
```

## 总结

- 优先用GPU
- 量化选INT4
- 够用就行，别盲目追大模型