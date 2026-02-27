---
name: nucnas-content-generator
description: 自动生成并发布 NUC NAS Hub 网站内容。支持：(1) 根据 content_plan.json 生成硬件测评文章 (2) 定时自动发布 (3) SEO优化 (4) 获取Pexels免版权配图。触发条件：用户要求生成文章、发布内容、自动更新网站。
---

# NUC NAS Hub 内容生成器

自动为 NUC NAS Hub 网站生成和发布内容。

## 快速开始

```powershell
# 生成内容
nucnas-generate -Count 3

# 构建并发布
nucnas-publish
```

## 工作流程

1. 读取 `content_plan.json` 获取待生成主题
2. 使用 AI 生成文章内容
3. 从 Pexels 获取免版权配图
4. 生成 Hugo MD 文件
5. 构建并推送到 GitHub

## 文件结构

```
D:\Projects\nucnas-hub\
├── content/
│   ├── hardware/    # 硬件测评
│   ├── nas/         # NAS学院
│   └── ai/          # AI
├── content_plan.json   # 内容计划
├── secrets.json        # API密钥
└── scripts/
    ├── generate.ps1    # 生成脚本
    └── publish.ps1     # 发布脚本
```

## 内容分类

| 分类 | 路径 | 权重 |
|------|------|------|
| hardware | /review/ | 40% |
| nas | /guide/ | 30% |
| ai | /ai/ | 30% |

## 文章模板

```markdown
---
title: "{{title}}"
date: {{date}}
summary: "{{summary}}"
categories: ["{{category}}"]
tags: [{{tags}}]
image: "{{image}}"
imageCredit: "{{photographer}}"
---

# {{title}}

![{{title}}]({{image}})

{{content}}

---
*本文由 NUC NAS Hub 自动生成*
```

## SEO 要求

- title: 20-60字符
- summary: 100-160字符
- tags: 3-5个相关标签
- 图片: Pexels免版权

## 定时任务

每天 8:00 自动执行：

```bash
openclaw cron add --cron "0 8 * * *" --name "nucnas-daily" --message "生成并发布内容"
```

## 内容计划

编辑 `content_plan.json` 添加新主题：

```json
{
  "status": "pending",
  "keywords": "关键词1,关键词2",
  "type": "hardware",
  "model": "产品型号",
  "brand": "品牌"
}
```

## API 配置

在 `secrets.json` 配置：

```json
{
  "pexels_token": "Pexels API Key",
  "github_token": "GitHub Token"
}
```
