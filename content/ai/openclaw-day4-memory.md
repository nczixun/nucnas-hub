---
title: "Day 4: 记忆系统 - 让 AI 记住一切"
date: 2026-03-03
summary: "第四天学习 OpenClaw 的记忆系统，让 AI 成为真正的私人助理。"
categories: ["ai"]
slug: "openclaw-day4-memory"
tags: ["OpenClaw", "Memory", "教程"]
---

# Day 4: 记忆系统 - 让 AI 记住一切

## 为什么记忆很重要？

普通的 AI 对话每次都是全新的上下文，AI 不会记得你们之前聊过什么。OpenClaw 的记忆系统让 AI 能够：
- 记住你的偏好
- 了解你的工作习惯
- 记住重要信息

## 记忆类型

### 1. 短期记忆（Session Memory）

每个会话中的上下文，关闭后清除。

```
工作原理：
用户发送消息 → 存入 Session → AI 参考后生成回复
```

### 2. 长期记忆（MEMORY.md）

持久存储，跨会话记住重要信息。

### 3. 工作记忆（Workspace）

当前工作目录下的文件。

## MEMORY.md 使用

### 自动记录

AI 会自动将重要信息写入 MEMORY.md：

```
## 用户偏好
- 喜欢简洁的回答
- 使用中文交流
- 关注技术教程

## 工作习惯
- 每天早上检查邮件
- 下午 3 点会议
```

### 手动更新

```bash
# 编辑记忆文件
notepad workspace/MEMORY.md
```

## 记忆调用机制

OpenClaw 会在每次对话前检索相关记忆：

1. **语义搜索** - 查找相关内容
2. **优先级排序** - 重要信息优先
3. **上下文注入** - 插入到对话开头

## 最佳实践

### 1. 定期整理

每周检查 MEMORY.md，删除过时信息。

### 2. 结构化存储

```markdown
# MEMORY.md

## 用户信息
- 名字: 张三
- 公司: XX科技

## 偏好设置
- 语言: 中文
- 时区: Asia/Shanghai

## 重要日期
- 生日: 1990-01-01
```

### 3. 分类管理

创建子目录管理不同类型的记忆：

```
workspace/
  memory/
    user.md      # 用户信息
    projects.md  # 项目信息
    notes.md     # 笔记
```

## 明天预告

Day 5我们将学习如何使用 ClawHub 安装和管理技能。

---

*关注我，每天学习 OpenClaw！*
