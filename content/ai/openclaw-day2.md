---
title: "Day 2：接入飞书/Telegram/Discord，打造你的专属AI助手"
date: 2026-03-01
categories: ["ai"]
slug: "openclaw-day2-platform-integration"
summary: "手把手教你将OpenClaw接入飞书、Telegram、Discord，实现随时随地对话。含详细配置步骤和多平台对比。"
tags: ["OpenClaw", "飞书机器人", "Telegram Bot", "Discord Bot", "AI助手配置"]
image: "https://images.pexels.com/photos/4126724/pexels-photo-4126724.jpeg"
imageCredit: "Pexels"
---

# Day 2：接入飞书/Telegram/Discord，打造你的专属AI助手

![AI助手接入多平台](https://images.pexels.com/photos/4126724/pexels-photo-4126724.jpeg "OpenClaw 多平台接入")

## 为什么需要接入通讯平台？

OpenClaw 默认只能在本机访问，接入通讯平台后，你可以：

- 🚀 随时随地发消息指挥 AI 做事
- 📱 手机远程控制电脑
- 👥 让团队成员也能使用 AI 助理

> 相关文章：[Day 1 安装指南](/ai/openclaw-day1-intro/)

## 接入飞书（推荐国内用户）

### 步骤 1：创建飞书应用

1. 打开 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用
3. 获取 App ID 和 App Secret

### 步骤 2：配置权限

需要开通以下权限：
- 接收消息
- 发送消息
- 读取用户信息

### 步骤 3：配置 OpenClaw

在 `openclaw.yaml` 中添加：

```yaml
feishu:
  enabled: true
  app_id: "你的App ID"
  app_secret: "你的App Secret"
  verification_token: "你的Verification Token"
```

### 步骤 4：启动服务

```bash
openclaw start
```

## 接入 Telegram

### 步骤 1：创建 Bot

1. 搜索 @BotFather
2. 发送 /newbot 创建新机器人
3. 获取 Bot Token

### 步骤 2：配置 OpenClaw

```yaml
telegram:
  enabled: true
  bot_token: "你的Bot Token"
  allowed_users:
    - 你的用户ID
```

## 接入 Discord

1. 打开 [Discord Developer Portal](https://discord.com/developers/applications)
2. 创建新应用 → 添加 Bot
3. 获取 Token 和 Application ID
4. 配置到 openclaw.yaml

## 多平台对比

| 平台 | 难度 | 国内访问 | 适合人群 |
|------|------|----------|----------|
| 飞书 | ⭐⭐ | ✅ | 国内团队 |
| Telegram | ⭐⭐ | ❌ | 国际用户 |
| Discord | ⭐⭐ | ❌ | 社区运营 |

## 明天预告

Day 3我们将深入了解 OpenClaw 的核心概念：AGENTS.md、SOUL.md 和 MEMORY.md。

---

*本文由 NUC NAS Hub 自动生成*
