---
title: "Day 1: 什么是 OpenClaw？安装与环境配置"
date: 2026-02-28
summary: "从零开始，第一天学习 OpenClaw 的基本概念和安装部署。"
categories: ["ai"]
slug: "openclaw-day1-intro"
tags: ["OpenClaw", "教程", "AI助理"]
image: "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg"
---

# Day 1: 什么是 OpenClaw？安装与环境配置

## 什么是 OpenClaw？

OpenClaw 是一个开源 AI 助理平台，让你拥有一个 24/7 在线的私人 AI 助理。它能理解你、帮助你、为你执行任务。

**核心特点：**
- 🧠 智能理解 - 理解你的意图并执行
- ⚡ 任务执行 - 帮你操作电脑、发送消息
- 💾 持久记忆 - 记住你们的对话上下文
- 🔌 多平台接入 - Telegram、Discord、飞书、钉钉等

## 系统要求

| 要求 | 最低配置 | 推荐配置 |
|------|----------|----------|
| 操作系统 | Windows/macOS/Linux | Windows 11/macOS/Linux |
| Node.js | v18+ | v20+ |
| 内存 | 4GB | 8GB+ |
| 存储 | 10GB | 50GB+ |

## 安装步骤

### 1. 安装 Node.js

**Windows:**
```powershell
winget install OpenJS.NodeJS.LTS
```

**macOS:**
```bash
brew install node
```

**Linux:**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 2. 克隆项目

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
```

### 3. 安装依赖

```bash
npm install
```

### 4. 启动配置

```bash
# 初始化配置
cp .env.example .env

# 编辑配置文件，添加你的 API Key
notepad .env
```

### 5. 运行 OpenClaw

```bash
# 启动网关
npm run gateway:start

# 在另一个终端启动
npm run start
```

## 首次配置

1. 打开浏览器访问 `http://localhost:8080`
2. 按照引导配置你的第一个 AI 助理
3. 连接你的消息平台（Telegram/飞书/钉钉）

## 常见问题

**Q: 启动失败怎么办？**
A: 检查 Node.js 版本是否 >= 18，检查 .env 配置是否正确

**Q: 无法连接消息平台？**
A: 确保网络畅通，部分平台需要代理

## 明天预告

Day 2我们将学习如何配置不同的消息平台，让你的 AI 助理接入 Telegram、飞书、钉钉等。

---

*关注我，每天学习 OpenClaw！*
