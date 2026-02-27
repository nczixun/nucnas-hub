---
name: nucnas-social-promoter
description: 社交媒体自动推广工具。自动生成推广文案并发布到：(1) 飞书群 (2) Twitter/X (3) Telegram群。触发条件：用户要求推广文章、分享到社交媒体、自动发布更新通知。
---

# NUC NAS Hub 社交媒体推广

自动为网站内容生成推广文案并发布到多个平台。

## 支持平台

| 平台 | 支持 | 说明 |
|------|------|------|
| 飞书 | ✅ | 群聊/私聊 |
| Twitter/X | ✅ | 推文 |
| Telegram | ✅ | 群聊/私聊 |
| 微信 | ⚠️ | 需企业微信 |

## 推广文案模板

### 硬件测评

```
🖥️ 新品测评：{brand} {model}

关键词：{keywords}

👉 阅读全文：{url}

#NUC #NAS #{$brand}
```

### NAS教程

```
📚 NAS教程：{title}

{summary}

🔗 {url}

#NAS #飞牛OS #私有云
```

### AI技术

```
🤖 AI前沿：{title}

{summary}

🔗 {url}

#AI #大模型 #本地部署
```

## 使用方法

```powershell
# 推广最新文章
nucnas-promote -Platform "feishu" -Latest

# 推广指定文章
nucnas-promote -Platform "telegram" -Slug "asus-nuc-14-pro-plus"

# 推广所有平台
nucnas-promote -Platform "all"
```

## 工作流程

1. 获取最新发布的文章（按 date 排序）
2. 根据分类选择对应文案模板
3. 生成平台适配的推广内容
4. 调用对应平台 API 发布

## 配置

在 `promotion-config.json` 配置：

```json
{
  "feishu": {
    "webhook": "https://open.feishu.cn/...",
    "chat_id": "oc_xxx"
  },
  "twitter": {
    "bearer_token": "xxx",
    "api_key": "xxx"
  },
  "telegram": {
    "bot_token": "xxx",
    "chat_id": "xxx"
  }
}
```

## 定时推广

可设置定时任务自动推广新文章：

```bash
# 每天发布后自动推广
openclaw cron add --cron "0 9 * * *" --name "nucnas-promote" --message "推广最新文章"
```

## 最佳实践

- 配图优先使用原文章图片
- 添加 2-3 个相关话题标签
- 保持文案简洁有吸引力
- 避免过度推广（每天1-2条）
