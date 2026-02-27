---
title: "Day 2: 消息平台接入 - 飞书/Telegram/钉钉"
date: 2026-03-01
summary: "第二天学习如何将 OpenClaw 接入各大消息平台。"
categories: ["ai"]
slug: "openclaw-day2-platform"
tags: ["OpenClaw", "飞书", "Telegram", "教程"]
---

# Day 2: 消息平台接入 - 飞书/Telegram/钉钉

## 为什么需要接入消息平台？

OpenClaw 需要通过消息平台与你对话。接入后，你可以随时随地通过 Telegram、飞书、钉钉等平台与 AI 助理交流。

## 飞书接入

### 1. 创建飞书应用

1. 访问 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业应用 → 创建应用
3. 获取 App ID 和 App Secret

### 2. 配置权限

添加以下权限：
- `im:chat:isolation` - 获取群聊信息
- `im:message:send_as_bot` - 以机器人身份发送消息
- `im:message:receive` - 接收消息

### 3. 配置事件订阅

事件订阅地址：`https://your-domain.com/webhook/feishu`

### 4. 环境变量配置

```env
FEISHU_APP_ID=你的AppID
FEISHU_APP_SECRET=你的AppSecret
FEISHU_VERIFICATION_TOKEN=你的VerificationToken
```

## Telegram 接入

### 1. 创建机器人

1. 打开 Telegram，搜索 @BotFather
2. 发送 `/newbot` 创建新机器人
3. 获取 Bot Token

### 2. 配置环境变量

```env
TELEGRAM_BOT_TOKEN=你的BotToken
```

### 3. 启动测试

```bash
npm run gateway:start
```

发送 `/start` 给你的机器人开始对话。

## 钉钉接入

### 1. 创建企业内部应用

1. 登录钉钉开放平台
2. 创建应用 → 机器人
3. 获取 App Key 和 App Secret

### 2. 配置回调地址

回调地址：`https://your-domain.com/webhook/dingtalk`

### 3. 环境变量

```env
DINGTALK_APP_KEY=你的AppKey
DINGTALK_APP_SECRET=你的AppSecret
```

## 多平台同时接入

OpenClaw 支持同时接入多个平台：

```env
FEISHU_ENABLED=true
TELEGRAM_ENABLED=true
DINGTALK_ENABLED=true
```

## 常见问题

**Q: 消息发不出去？**
A: 检查 App 权限是否完整，是否已发布上线

**Q: 收不到消息？**
A: 检查回调地址是否可访问，是否配置正确

## 明天预告

Day 3我们将深入了解 OpenClaw 的核心概念：Agent、Session、Memory。

---

*关注我，每天学习 OpenClaw！*
