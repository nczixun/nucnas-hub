---
title: "Ollama 模型量化指南：节省显存提升性能"
date: 2026-01-01
categories: ["ai"]
summary: "Ollama 模型量化指南，教你用更少显存运行大模型"
tags: ["Ollama", "量化", "显存", "优化"]
slug: "ollama-quantization-guide-2026"
---

# Ollama 模型量化指南

## 什么是量化？

量化是将模型从高精度（FP16）转换为低精度（INT4/INT8）的技术，可以大幅减少显存占用。

## 量化级别

| 级别 | 精度 | 显存占用 | 质量 |
|------|------|----------|------|
| FP16 | 16bit | 100% | 最高 |
| Q8_0 | 8bit | 50% | 很高 |
| Q6_K | 6bit | 37.5% | 高 |
| Q5_K_M | 5bit | 31% | 中高 |
| Q4_K_M | 4bit | 25% | 中 |
| Q3_K_M | 3bit | 19% | 中低 |
| Q2_K | 2bit | 12.5% | 低 |

## 显存需求

| 模型 | FP16 | Q8_0 | Q4_K_M | Q2_K |
|------|------|-------|---------|-------|
| 7B | 14GB | 7GB | 3.5GB | 1.8GB |
| 13B | 26GB | 13GB | 6.5GB | 3.2GB |
| 70B | 140GB | 70GB | 35GB | 17GB |

## 使用方法

### 查看可用模型

```bash
ollama list
```

### 拉取量化版本

```bash
ollama pull llama3:8b-q4_0
ollama pull qwen2.5:14b-q4_k_m
```

### 创建自定义量化

```bash
ollama create mymodel -f Modelfile
```

## 性能对比

| 模型 | 量化 | 速度 | 质量 |
|------|------|------|------|
| Llama 3 8B | FP16 | 15 tok/s | 100% |
| Llama 3 8B | Q4_K_M | 35 tok/s | 95% |
| Llama 3 8B | Q2_K | 50 tok/s | 85% |

## 最佳实践

1. **日常使用**：Q4_K_M
2. **显存紧张**：Q2_K
3. **质量优先**：Q8_0
