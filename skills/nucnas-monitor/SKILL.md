---
name: nucnas-monitor
description: 网站数据监控与分析。监控访问量、热门文章、SEO状态，生成数据报告。触发：用户要求查看数据、生成报告。
metadata: { "openclaw": { "emoji": "📊" } }
---

# 网站数据监控

监控和分析网站数据。

## 功能

- 访问量统计
- 热门文章排行
- SEO 健康度检查
- 死链检测
- 生成数据报告

## 使用方法

```bash
# 查看今日数据
nucnas-monitor --today

# 查看周报
nucnas-monitor --weekly

# SEO 检查
nucnas-monitor --seo

# 热门文章
nucnas-monitor --top
```

## 报告内容

- PV/UV 统计
- 流量来源
- 热门文章 Top 10
- SEO 分数
- 建议改进项

## 注意事项

- 需要网站部署后才能获取分析数据
- 部分功能需要分析工具配合
