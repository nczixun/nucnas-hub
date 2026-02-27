---
title: "Day 3: 核心概念 - Agent/Session/Skills"
date: 2026-03-02
summary: "第三天深入理解 OpenClaw 的三大核心概念。"
categories: ["ai"]
slug: "openclaw-day3-core"
tags: ["OpenClaw", "Agent", "Skills", "教程"]
---

# Day 3: 核心概念 - Agent/Session/Skills

## 三大核心概念

OpenClaw 有三个核心概念：Agent（代理）、Session（会话）和 Skill（技能）。

## 1. Agent（代理）

Agent 是 OpenClaw 的核心执行单元。每个 Agent 有自己的：
- **角色定义** - 告诉 AI 你是谁
- **能力范围** - 能做什么、不能做什么
- **工具集** - 可使用的技能

### 创建 Agent

```bash
openclaw agent create my-agent
```

### Agent 配置文件

```yaml
# AGENTS.md
# 你的名字
- name: 我的助手
- 角色: 你是一个乐于助人的 AI 助手
- 能力:
  - 回答问题
  - 执行命令
```

## 2. Session（会话）

Session 是用户与 Agent 之间的对话上下文。

**会话类型：**
- **Main Session** - 主会话，最长记忆
- **Group Chat** - 群聊中的会话
- **Sub-agent** - 子代理会话

### 会话管理

```bash
# 查看当前会话
openclaw sessions list

# 查看会话历史
openclaw sessions history <session-id>
```

## 3. Skills（技能）

Skill 是扩展 OpenClaw 能力的插件。

### 内置技能

| 技能 | 功能 |
|------|------|
| shell | 执行终端命令 |
| browser | 控制浏览器 |
| editor | 读写文件 |
| message | 发送消息 |

### 安装 ClawHub 技能

```bash
# 安装天气查询技能
clawhub install weather

# 安装代码生成技能
clawhub install code-generator
```

## 三大核心文件

OpenClaw 通过几个核心文件配置：

### 1. AGENTS.md
定义 Agent 的身份和行为

```markdown
# IDENTITY.md
- name: 小助手
- 角色: 你是用户的贴心 AI 助理
```

### 2. SOUL.md
定义 Agent 的性格和交流风格

```markdown
# SOUL.md
- 语气: 友好、专业
- 习惯: 简洁明了，不说废话
```

### 3. MEMORY.md
长期记忆存储

记录重要的用户偏好、设置和历史交互。

## 明天预告

Day 4我们将学习 OpenClaw 的记忆系统。

---

*关注我，每天学习 OpenClaw！*
