---
title: "Ollama + OpenWebUI 搭建本地 AI 聊天界面"
date: 2026-02-18
categories: ["ai"]
summary: "使用 Ollama + OpenWebUI 搭建一个美观易用的本地 AI 聊天界面，支持多模型切换。"
image: "https://images.pexels.com/photos/4126724/pexels-photo-4126724.jpeg"
imageCredit: "Photo by Pexels"
tags: ["Ollama", "OpenWebUI", "教程"]
---

# Ollama + OpenWebUI 搭建本地 AI 聊天界面

虽然命令行可以运行大模型，但一个美观的聊天界面体验更好。本文介绍如何使用 OpenWebUI 搭建本地 AI 聊天界面。

## 什么是 OpenWebUI？

OpenWebUI 是一个为 Ollama 打造的 Web 图形界面，功能包括：
- 美观的聊天界面
- 多模型支持
- 对话历史保存
- 模型管理

## 安装步骤

### 1. 安装 Docker

首先确保系统已安装 Docker。

### 2. 启动 OpenWebUI

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### 3. 访问界面

打开浏览器访问 http://localhost:3000，首次使用需要注册账号。

## 功能介绍

- **模型选择**：右上角可以切换不同模型
- **对话历史**：左侧边栏查看历史对话
- **设置**：可以调整模型参数

---

*本文由 NUC NAS Hub 自动生成*
