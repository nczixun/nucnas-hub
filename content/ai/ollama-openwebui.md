---
slug: "ollama-openwebui"
title: "Ollama + OpenWebUI 搭建本地 AI 聊天界面"
date: 2026-02-18
categories: ["ai"]
summary: "使用 Ollama + OpenWebUI 搭建一个美观易用的本地 AI 聊天界面，支持多模型切换。"
tags: ["Ollama", "OpenWebUI", "教程"]
slug: "ollama-openwebui"
---

# Ollama + OpenWebUI 搭建本地 AI 聊天界面


虽然命令行可以运行大模型，但一个美观的聊天界面体验更好。本文介绍如何使用 OpenWebUI 搭建本地 AI 聊天界面。

## 什么是 OpenWebUI？

<a href="/ai/ollama-openwebui/" target="_blank">OpenWebUI</a> 是一个为 <a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a> 打造的 Web 图形界面，功能包括：
- 美观的聊天界面
- 多模型支持
- 对话历史保存
- 模型管理

## 安装步骤

通过 <a href="/nas/docker-best-practice/" target="_blank">Docker</a> 一键部署：

```bash
docker run -d -p 3000:8080 -v ollama:/root/.ollama - --name openwebui openwebui/openwebui:main
```

---

*更多<a href="/ai/" target="_blank">AI</a>教程请关注 [AI频道](/ai/)。*

<div class="page-nav">
  <a href="/hardware/ugreen-dx4600/" rel="prev">上一页：绿联 DX4600 评测</a>
</div>

*本文由 NUC NAS Hub 自动生成*
