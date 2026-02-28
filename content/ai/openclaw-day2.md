---
title: "Day 2：接入飞�?Telegram，打造你的专属AI助手"
date: 2026-03-01
categories: ["ai"]
summary: "把AI助理接入通讯工具，随时随地使�?
image: "https://images.pexels.com/photos/4126724/pexels-photo-4126724.jpeg"
imageCredit: "Pexels"
---

# Day 2：接入飞�?Telegram，打造你的专属AI助手

## 为什么需要接入通讯平台�?
OpenClaw 默认只能在本机访问，接入通讯平台后，你可以：

- 🚀 随时随地发消息指�?AI 做事
- 📱 手机远程控制电脑
- 👥 让团队成员也能使�?AI 助理

## 接入飞书（推荐国内用户）

### 步骤 1：创建飞书应�?
1. 打开 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用
3. 获取 App ID �?App Secret

### 步骤 2：配置权�?
需要开通以下权限：
- 接收消息
- 发送消�?- 读取用户信息

### 步骤 3：配�?OpenClaw

�?`openclaw.yaml` 中添加：

```yaml
feishu:
  enabled: true
  app_id: "你的App ID"
  app_secret: "你的App Secret"
  verification_token: "你的Verification Token"
```

### 步骤 4：启动服�?
```bash
openclaw start
```

## 接入 Telegram

### 步骤 1：创�?Bot

1. 搜索 @BotFather
2. 发�?/newbot 创建新机器人
3. 获取 Bot Token

### 步骤 2：配�?OpenClaw

```yaml
telegram:
  enabled: true
  bot_token: "你的Bot Token"
  allowed_users:
    - 你的用户ID
```

## 接入 Discord

1. 打开 [Discord Developer Portal](https://discord.com/developers/applications)
2. 创建新应�?�?添加 Bot
3. 获取 Token �?Application ID
4. 配置�?openclaw.yaml

## 多平台对�?
| 平台 | 难度 | 国内访问 | 适合人群 |
|------|------|----------|----------|
| 飞书 | ⭐⭐ | �?| 国内团队 |
| Telegram | ⭐⭐ | �?| 国际用户 |
| Discord | ⭐⭐ | �?| 社区运营 |

## 明天预告

Day 3我们将深入了�?OpenClaw 的核心概念：AGENTS.md、SOUL.md �?MEMORY.md�?
---

*本文�?NUC NAS Hub 自动生成*
