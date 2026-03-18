---
title: "零刻迷你主机部署 DeepSeek R1：本地大模型实测"
date: 2026-03-07
categories: ["ai"]
slug: "deepseek-r1-minipc-deploy-2026"
tags: ["本地部署", "DeepSeek", "Ollama", "AI大模型"]
draft: true
---

# 零刻迷你主机部署 DeepSeek R1：本地大模型实测

用零刻 SER8 跑了一周 DeepSeek R1，今天来聊聊实际体验。

## 测试设备

- **主机**：零刻 SER8（AMD Ryzen 7 8845HS）
- **内存**：32GB DDR5-5600（双通道）
- **硬盘**：1TB NVMe SSD
- **系统**：Windows 11 专业版

## 安装步骤

1. **下载 Ollama**
   官网下载安装包：https://ollama.com
   
2. **拉取模型**
   ```bash
   ollama pull deepseek-r1:8b
   ```
   8B 模型约 4.7GB，14B 约 8GB，根据显存选择。

3. **运行模型**
   ```bash
   ollama run deepseek-r1:8b
   ```

## 性能实测

用 LM Studio 和 Ollama 分别测试了不同参数模型的生成速度：

| 模型 | 显存占用 | 首token速度 | 生成速度 |
|------|----------|-------------|----------|
| DeepSeek R1 8B | 16GB | 120 ms/s | 35 tokens/s |
| DeepSeek R1 14B | 28GB | 180 ms/s | 22 tokens/s |
| Qwen2.5 7B | 14GB | 90 ms/s | 42 tokens/s |

8845HS 的 NPU 没用上，纯 CPU+GPU 跑。16GB 内存跑 8B 模型有点吃力，建议 32GB。

## 使用体验

**优点**：
- 完全离线，隐私有保障
- 响应速度快，不需要等 API
- 部署简单，小白也能上手

**缺点**：
- 14B 模型单次回复较慢
- 32GB 内存跑 8B 只能说是勉强够用
- 风扇噪音明显增大

## 适用场景

- **代码辅助**：DeepSeek R1 写代码能力很强，14B 模型已经够用
- **文档摘要**：本地处理敏感文档，不用上传云端
- **学习研究**：离线部署，玩提示词工程不怕泄露

## 总结

AMD 8845HS 跑 8B 模型办公用没问题，14B 需要等一会。如果想好好玩本地大模型，建议等下一代 8845HS+48GB 内存的配置，或者直接上台式机加显卡。

有问题评论区聊！
