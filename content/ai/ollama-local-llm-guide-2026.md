---
title: "Ollama本地部署大模型：零基础入门指南"
date: 2026-03-06
categories: ["ai"]
summary: "用Ollama在本地部署大模型，无需显卡也能玩"
image: "https://images.pexels.com/photos/159538/pexels-photo-159538.jpeg"
imageCredit: "Pexels"
tags: ["Ollama", "local LLM", "deployment"]
---

# Ollama本地部署大模型：零基础入门指南

本地跑大模型，Ollama是最简单的方案。

## 环境要求

- Mac：M1/M2/M3芯片（推荐）
- Windows：至少16GB内存
- Linux：任意主流发行版

## 安装步骤

Mac/Linux：
```bash
brew install ollama
```

Windows：
- 下载安装包：ollama.ai
- 一路下一步安装

## 运行模型

```bash
# 列出可用模型
ollama list

# 跑一个试试
ollama run llama3.2
```

## 硬件要求与速度

- 7B模型：8GB内存可跑，速度3-5token/s
- 14B模型：16GB内存可跑，速度1-3token/s
- 70B模型：需要32GB+内存，显卡更好

## 进阶玩法

- WebUI：Open WebUI安装，图形界面更友好
- API调用：localhost:11434/api/generate
- 自定义模型：导入GGUF格式模型

现在本地跑大模型没想象中那么难，感兴趣可以试试。