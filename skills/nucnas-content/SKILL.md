---
name: nucnas-content
description: 自动生成 NUC NAS Hub 网站文章。从 content_plan.json 读取主题，使用 AI 生成完整文章，获取配图，生成 Hugo MD 文件。触发：用户要求生成文章、自动更新网站。
metadata: { "openclaw": { "emoji": "📝" } }
---

# NUC NAS Hub 内容生成

根据计划自动生成文章。

## 功能

- 读取 content_plan.json 待生成主题
- 调用 AI 生成完整文章内容
- 从 Pexels 获取免版权配图
- 生成 Hugo 格式 Markdown 文件
- 自动检测重复并跳过
- 支持指定分类（hardware/nas/ai）

## 使用方法

```bash
# 生成文章
nucnas-content --count 3

# 指定分类
nucnas-content --category hardware --count 5

# 生成并发布
nucnas-content --publish --count 3
```

## 配置

需要配置：
- Pexels API (获取免费图片)
- MiniMax/Kimi API (生成文章)

## 输出

生成文件路径：`content/{category}/{slug}.md`

## 注意事项

- 自动检测重复文章
- 根据 type 自动归类（hardware/nas/ai）
- SEO 优化：自动生成 keywords、description
