---
title: "Day 5：自动化任务与心跳机制 - AI主动为你工作"
date: 2026-03-04
categories: ["ai"]
slug: "openclaw-day5-automation-heartbeat"
summary: "OpenClaw心跳机制详解，定时任务自动执行，让AI主动为你检查邮件、天气、新闻等。"
tags: ["OpenClaw", "心跳", "自动化", "Cron", "定时任务"]
---

# Day 5：自动化任务与心跳机制


<a href="/ai/" target="_blank">OpenClaw</a>心跳机制让AI主动为你工作。

## 什么是心跳机制

心跳是 OpenClaw 的定期检查机制，让 AI 可以主动执行任务而无需等待用户指令。

### 典型应用场景

- 📧 检查新邮件
- 🌤️ 天气预报提醒
- 📰 新闻摘要
- 🔔 社交媒体通知

## 配置心跳任务

在 `HEARTBEAT.md` 中配置：

```markdown
# HEARTBEAT.md

## 每日任务

| 时间 | 任务 |
|------|------|
| 08:00 | 检查邮件 |
| 12:00 | 天气提醒 |
| 18:00 | 新闻汇总 |
```

## Cron 定时任务

```bash
# 每天早上 8 点执行
0 8 * * * openclaw task morning-brief

# 每小时检查一次
0 * * * * openclaw check-notifications
```

---

*更多<a href="/ai/" target="_blank">AI</a>教程请关注 [AI频道](/ai/)。*
<div class="page-nav">
  <a href="/guide/fnos-full-guide/" rel="prev">上一页：飞牛OS深度体验</a>
</div>

*本文由 NUC NAS Hub 自动生成*
