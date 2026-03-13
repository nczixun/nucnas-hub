---
title: "Day 2：接入飞书/Telegram/Discord，打造你的专属AI助手"
date: 2026-03-01
categories: ["ai"]
slug: "openclaw-day2-platform-integration"
summary: "手把手教你将OpenClaw接入飞书、Telegram、Discord，实现随时随地的AI对话。包含详细配置步骤和多平台对比。"
tags: ["OpenClaw", "飞书机器人", "Telegram Bot", "Discord Bot", "AI助手配置"]
---

# Day 2：接入飞书/Telegram/Discord，打造你的专属AI助手


## 为什么要接入通讯平台

<a href="/ai/" target="_blank">OpenClaw</a> 默认只能在本机访问，接入通讯平台后，你可以：

- 📱 随时随地发送消息让 AI 做事
- 📲 手机远程控制电脑
- 👥 让团队成员也能使用 AI 助手

## 接入飞书（推荐国内用户）

### 步骤 1：创建飞书应用

1. 打开 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用
3. 获取 App ID 和 App Secret

### 步骤 2：配置应用权限

在飞书后台添加以下权限：
- im:chat:message:p2p
- im:resource:download

### 步骤 3：在 OpenClaw 中配置

```bash
openclaw config set channel feishu
openclaw config set feishu_app_id your_app_id
openclaw config set feishu_app_secret your_secret
```

## 多平台对比

| 平台 | 难度 | 国内访问 | 适合人群 |
|------|------|----------|----------|
| 飞书 | ⭐ | ✅ | 国内团队 |
| Telegram | ⭐⭐ | ❌ | 国际用户 |
| Discord | ⭐⭐ | ❌ | 社区运营 |

---

*更多<a href="/ai/" target="_blank">AI</a>教程请关注 [AI频道](/ai/)。*
<div class="page-nav">
  <a href="/ai/ollama-openwebui/" rel="prev">上一页：Ollama + OpenWebUI 搭建</a>
</div>

*本文由 NUC NAS Hub 自动生成*
