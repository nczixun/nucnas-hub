---
title: "Day 5: 技能市场 - ClawHub 使用指南"
date: 2026-03-04
summary: "第五天学习使用 ClawHub 技能市场，安装和管理扩展功能。"
categories: ["ai"]
slug: "openclaw-day5-clawhub"
tags: ["OpenClaw", "ClawHub", "Skills", "教程"]
---

# Day 5: 技能市场 - ClawHub 使用指南

## 什么是 ClawHub？

ClawHub 是 OpenClaw 的官方技能市场，提供 1700+ 预制技能，一键安装即用。

## 安装技能

### 使用 CLI 安装

```bash
# 安装天气查询
clawhub install weather

# 安装股票查询
clawhub install stock

# 安装翻译
clawhub install translator
```

### 查看已安装技能

```bash
clawhub list
```

## 推荐技能分类

### 🧠 AI & 大模型（159个）

| 技能 | 功能 |
|------|------|
| llm-chat | 大模型对话 |
| image-generator | AI 画图 |
| summarizer | 文章摘要 |

### 🔍 搜索 & 研究（148个）

| 技能 | 功能 |
|------|------|
| web-search | 搜索引擎 |
| wikipedia | 维基百科 |
| news-fetcher | 新闻获取 |

### 🏠 智能家居（50个）

| 技能 | 功能 |
|------|------|
| home-assistant | Home Assistant |
| mqtt-controller | MQTT 控制 |
| smart-plug | 智能插座 |

### 📝 笔记 & 知识（61个）

| 技能 | 功能 |
|------|------|
| notion-sync | Notion 同步 |
| obsidian | Obsidian 笔记 |
| readwise | 阅读收藏 |

## 开发自定义技能

### 技能结构

```bash
my-skill/
  SKILL.md      # 技能定义
  handler.js     # 处理逻辑
  config.yaml   # 配置
```

### SKILL.md 示例

```markdown
# skill: my-custom-skill
# description: 自定义技能
# triggers: /hello

你好！我是一个自定义技能。
```

### 发布到 ClawHub

```bash
clawhub publish my-skill
```

## 安全提醒

⚠️ 安装第三方技能前请务必检查源码，防范恶意代码。

## 明天预告

Day 6我们将学习实际的 OpenClaw 使用案例。

---

*关注我，每天学习 OpenClaw！*
