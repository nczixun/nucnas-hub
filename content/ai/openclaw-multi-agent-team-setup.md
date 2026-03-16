---
title: "从0到1完整搭建OpenClaw多角色团队"
date: 2026-03-16
categories: ["ai"]
summary: "手把手教你搭建OpenClaw多Bot团队：主脑+专才协作模式，完整配置教程，含目录规划、Agent创建、记忆规范。"
tags: ["OpenClaw", "多Agent", "团队协作", "Telegram Bot", "教程"]
slug: "openclaw-multi-agent-team-setup"
description: "从0到1完整搭建OpenClaw多角色团队：主脑+专才协作模式，三种方案对比，完整配置教程含openclaw.json示例。"
---

# 从0到1完整搭建OpenClaw多角色团队

> 将多个独立的Telegram Bot组建成一个分工协作的Agent团队，实现复杂任务的自动化流转。

---

## 前言

在[上一篇文章](https://x.com/ResearchWang/status/2027683428154675476)中，我们用20元搭建好了账号池，已经是极低的成本使用OpenClaw了。

本文将教你如何搭建**多Bot团队协作**，让不同的Bot扮演不同角色（主脑、程序员、研究员等），实现复杂任务的自动化。

---

## 什么是多Bot团队协作？

将多个独立的Telegram Bot组建成一个分工协作的Agent团队。通过合理的架构配置，让不同的Bot扮演不同角色，实现复杂任务的自动化流转。

### 三种协作模式对比

| 模式 | 特点 | 适用场景 |
|------|------|----------|
| **模式A**：主脑+专才 | 主脑统一调度，专才互相独立 | 严格流程控制的流水线作业 |
| **模式B**：独立共享 | 无主脑，专才直接面向用户并共享记忆 | 任务边界清晰，用户明确知道该找谁 |
| **模式C**（推荐）：混合推荐 | 主脑调度，专才共享记忆，可绕过主脑 | 生产级推荐，兼顾前两者优点 |

---

## 阶段1：基础概念与前置准备

### 第一步：明晰前置需求

在组建团队之前，每个Bot都需要进行基础的注册和身份获取。

你需要确定团队的角色分配，例如：
- 主脑（main）
- 程序员（coder）
- 研究员（researcher）
- 写手（writer）

### 第二步：获取凭证

在Telegram的BotFather中为每个角色创建新机器人（/newbot），保存所有的botToken。

同时获取你个人的Telegram数字ID以便配置权限。

### 实践任务1：获取Bot Token与个人ID

```bash
# 方法一：DM你的bot，然后查日志，看from.id字段
openclaw logs --follow

# 方法二：通过Bot API获取
curl "https://api.telegram.org/bot<token>/getUpdates"
```

✅ **完成标准**：成功记录所有角色的botToken以及你自己的Telegram数字ID

---

## 阶段2：目录规划与Agent创建

### 第三步：规划目录结构

合理的目录结构是多Bot协作的基础。

**核心原则**：专才们的workspace指向同一个目录（共享记忆），但agentDir各自独立（独立身份）。

### 实践任务2：创建工作区目录

```
~/.openclaw/
├── workspace-main/           # 主脑独立workspace
├── workspace-team-a/        # 团队A专才共享workspace（模式B/C使用）
├── agents/
│   ├── main/
│   │   ├── agent/           # 主脑agentDir（auth、配置）
│   │   └── sessions/
│   ├── coder/
│   │   ├── agent/
│   │   └── sessions/
│   ├── researcher/
│   │   ├── agent/
│   │   └── sessions/
│   └── writer/
│       ├── agent/
│       └── sessions/
└── openclaw.json
```

✅ **完成标准**：理解共享workspace（记忆）与独立agentDir（身份）的区别，并在本地建立好基础文件夹

### 第四步：创建Agent实例

在OpenClaw中注册团队成员：

```bash
# 依次添加团队成员
openclaw agents add main
openclaw agents add coder
openclaw agents add researcher
openclaw agents add writer
```

---

## 阶段3：核心架构与完整配置

### 第五步：选择并应用协作模式（推荐模式C）

打开openclaw.json，配置推荐的**模式C（混合模式）**：

```json
{
  "agents": {
    "list": [
      {
        "id": "main",
        "workspace": "~/.openclaw/workspace-main",
        "agentDir": "~/.openclaw/agents/main/agent"
      },
      {
        "id": "coder",
        "workspace": "~/.openclaw/workspace-team-a",
        "agentDir": "~/.openclaw/agents/coder/agent",
        "tools": { "deny": ["browser", "nodes"] }
      },
      {
        "id": "researcher",
        "workspace": "~/.openclaw/workspace-team-a",
        "agentDir": "~/.openclaw/agents/researcher/agent",
        "tools": { "deny": ["exec", "write", "edit"] }
      },
      {
        "id": "writer",
        "workspace": "~/.openclaw/workspace-team-a",
        "agentDir": "~/.openclaw/agents/writer/agent",
        "tools": { "deny": ["exec", "browser", "nodes"] }
      }
    ]
  },
  "session": { "dmScope": "main" },
  "tools": {
    "agentToAgent": {
      "enabled": true,
      "allow": ["main", "coder", "researcher", "writer"]
    }
  },
  "bindings": [
    { "agentId": "main", "match": { "channel": "telegram", "accountId": "main" } },
    { "agentId": "coder", "match": { "channel": "telegram", "accountId": "coder" } },
    { "agentId": "researcher", "match": { "channel": "telegram", "accountId": "researcher" } },
    { "agentId": "writer", "match": { "channel": "telegram", "accountId": "writer" } }
  ],
  "channels": {
    "telegram": {
      "accounts": {
        "main": {
          "botToken": "111111:TOKEN_MAIN",
          "dmPolicy": "pairing"
        },
        "coder": {
          "botToken": "222222:TOKEN_CODER",
          "dmPolicy": "allowlist",
          "allowFrom": ["tg:你的数字ID"]
        },
        "researcher": {
          "botToken": "333333:TOKEN_RESEARCHER",
          "dmPolicy": "allowlist",
          "allowFrom": ["tg:你的数字ID"]
        },
        "writer": {
          "botToken": "444444:TOKEN_WRITER",
          "dmPolicy": "allowlist",
          "allowFrom": ["tg:你的数字ID"]
        }
      }
    }
  }
}
```

✅ **完成标准**：成功将团队配置写入openclaw.json并保存

---

## 阶段4：记忆规范与多团队隔离

### 第六步：配置各Agent的SOUL.md

为确保团队成员各司其职，需要设定人设。

**主脑SOUL.md**（放在workspace-main/）：

```markdown
# SOUL.md - 主脑
你是团队的协调者和对外入口。

## 职责
- 理解用户意图，判断任务复杂度
- 简单任务直接自己处理，不必每次派发
- 编码类 → 派给coder（sessions_send）
- 调研/搜索类 → 派给researcher
- 写作/文案类 → 派给writer
- 收集专才结果，整合后回复用户（不是简单转发）

## 原则
- 派发任务时说清楚背景和期望输出格式
- 等专才完成后再整合，不要催
- 汇总时做真正的整合，给用户一个完整的答案
```

**专才SOUL.md**（放在workspace-team-a/）：

```markdown
# SOUL.md - 专才
你是团队的专业成员，可能被主脑派发任务，也可能被用户直接联系。

## 共享记忆规范
- 读MEMORY.md了解团队整体上下文
- 写记忆时标明身份，格式：`[coder] 今天完成了...`
- 不要覆盖其他agent写的记忆条目

## 原则
- 专注自己的领域
- 任务完成后，清晰地返回结果
- 感知到其他专才已经做过的工作，避免重复
```

### 第七步：启动与验证

```bash
# 重启gateway使配置生效
openclaw gateway restart

# 验证agent列表和bindings
openclaw agents list --bindings

# 验证各channel状态
openclaw channels status --probe

# 实时日志（调试用）
openclaw logs --follow
```

✅ **完成标准**：控制台无报错，且各个Bot均能正常响应对应的Telegram消息

---

## 实践任务清单

| 阶段 | 任务 | 内容 |
|------|------|------|
| 新手 | 任务1 | 获取所有Bot Token及个人Telegram ID |
| 进阶 | 任务2 | 建立共享与独立的目录结构，注册Agent |
| 中级 | 任务3 | 完成模式C的核心配置 |
| 高级 | 任务4 | 编写SOUL.md，重启并验证多Bot通讯 |

---

## 常见问题解答

**Q1：模式C里专才并发写记忆会冲突吗？**
偶发，但实际影响小。建议在写记忆时加上agent标识（如`[coder] 修复了xxx问题...`），可以有效减少混淆。

**Q2：我能绕过主脑直接联系专才吗？**
模式C中可以。专才的`dmPolicy: allowlist`允许你通过数字ID直接DM。

**Q3：agentToAgent开了之后，专才能主动联系主脑吗？**
能，allow列表是双向的。专才也可以用sessions_send主动给主脑发消息汇报进度。

**Q4：专才共享workspace，SOUL.md不就一样了吗？**
是的，共享workspace意味着SOUL.md也共享。如果需要给专才设定截然不同的人格，建议把SOUL.md放在它们各自的agentDir下。

---

## 选型建议

| 场景 | 推荐模式 |
|------|----------|
| Bot较少（2-3个） | 模式B，配置简单上手快 |
| 任务复杂，需要流程控制 | 模式A，强管控 |
| 生产级、长期稳定运营 | 模式C（混合） |
| 有多个独立业务线 | 各自用模式C，物理隔离 |

---

## 总结

完成OpenClaw多角色配置后，你的OpenClaw已经可以变成一个公司团队了。

你可以尝试让这个团队去完成你的小任务。配置多Bot的大致思路就是这些，之后无非就是升级SOUL.md、学习更多Skill，让每一只OpenClaw获取更强的技术技能。

---

*参考来源：Twitter @ResearchWang*
