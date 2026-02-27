---
name: content-generator
description: 自动生成网站文章内容。从 content_plan.json 读取主题，使用 AI 生成完整文章，获取配图，生成 Hugo MD 文件。
---

# 内容生成器

根据计划自动生成文章。

## 使用方法

```bash
# 生成文章
content-generator --count 3

# 指定分类
content-generator --category hardware --count 5
```

## 功能

- 读取 content_plan.json 待生成主题
- 调用 AI 生成完整文章内容
- 从 Pexels 获取免版权配图
- 生成 Hugo 格式 Markdown 文件
- 自动检测重复并跳过

## 配置

需要配置 Pexels API 和 AI 模型：
- Pexels: 用于获取免费图片
- MiniMax/Kimi: 用于生成文章内容
