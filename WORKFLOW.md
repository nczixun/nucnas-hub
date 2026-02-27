# NUC NAS Hub 内容自动发布流程

## 概述

本流程实现每天自动生成并发布3-5篇文章到网站。

## 流程架构

```
┌─────────────────────────────────────────────────────────────┐
│                    每日 8:00 AM                              │
│                         │                                   │
│         ┌───────────────┴───────────────┐                   │
│         ▼                               ▼                   │
│  ┌──────────────┐              ┌──────────────┐           │
│  │ 生成内容脚本  │              │  Cron Job    │           │
│  │ generate-    │              │  定时触发     │           │
│  │ content.ps1  │              │              │           │
│  └──────┬───────┘              └──────┬───────┘           │
│         │                               │                   │
│         ▼                               ▼                   │
│  ┌──────────────────────────────────────────┐             │
│  │ 1. 读取 content_plan.json                 │             │
│  │ 2. AI生成文章内容                         │             │
│  │ 3. Pexels获取配图                        │             │
│  │ 4. 生成 Hugo MD 文件                     │             │
│  └──────────────────┬───────────────────────┘             │
│                     ▼                                      │
│            ┌──────────────┐                               │
│            │ Hugo 构建    │                               │
│            │ hugo         │                               │
│            └──────┬───────┘                               │
│                   ▼                                       │
│            ┌──────────────┐                               │
│            │ Git 自动推送 │                               │
│            │ git add/push │                               │
│            └──────────────┘                               │
└─────────────────────────────────────────────────────────────┘
```

## 文件结构

```
nucnas-hub/
├── scripts/
│   ├── generate-content.ps1    # 内容生成脚本
│   ├── build-and-push.ps1     # 构建推送脚本
│   └── ai-writer.ps1          # AI写作模块
├── content/                   # 文章目录
│   ├── hardware/             # 硬件测评
│   ├── nas/                  # NAS学院
│   └── ai/                   # AI
├── secrets.json              # 密钥配置
└── WORKFLOW.md               # 本文档
```

## 配置

### 1. 环境变量

```powershell
# 设置Pexels API Key
$env:PEXELS_TOKEN = "your_pexels_token"

# 设置GitHub Token (已有)
$env:GITHUB_TOKEN = "your_github_token"
```

### 2. secrets.json

```json
{
  "pexels_token": "your_pexels_api_key",
  "schedule": {
    "daily_time": "08:00",
    "posts_per_day": 3
  }
}
```

## 使用方法

### 手动运行

```powershell
# 生成3篇文章
.\scripts\generate-content.ps1 -Count 3

# 指定分类
.\scripts\generate-content.ps1 -Count 2 -Category "hardware"
```

### 自动运行 (Cron)

```bash
# 每天早上8点自动运行
openclaw cron add --cron "0 8 * * *" --name "daily-content" --message "生成并发布内容"
```

## 内容来源

### 1. 计划任务 (content_plan.json)

预先规划的文章主题：

```json
[
  {
    "status": "pending",
    "keywords": "M4芯片,静音,雷电5",
    "type": "hardware",
    "model": "Mac mini M4",
    "brand": "Apple"
  }
]
```

### 2. AI 生成

使用大模型生成实际文章内容，包括：
- 产品介绍
- 性能分析
- 使用场景
- 优缺点总结

### 3. 图片

从 Pexels 获取免版权配图

## 定时任务

| 任务 | 时间 | 说明 |
|------|------|------|
| 内容生成 | 每天 8:00 | 生成3-5篇文章 |
| 网站构建 | 生成后 | Hugo构建 |
| Git推送 | 构建后 | 推送到GitHub |

## 监控

查看定时任务运行状态：

```bash
openclaw cron list
openclaw cron runs <job-id>
```

## 注意事项

1. ⚠️ API配额：注意Pexels和AI的API限制
2. ⚠️ 内容审核：自动生成内容需人工审核
3. ⚠️ GitHub Actions：可配合CI/CD自动部署到Cloudflare Pages
