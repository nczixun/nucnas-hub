---
name: nucnas-social
description: 社交媒体内容生成与发布。将网站文章改编后发布到微博、小红书等平台。触发：用户要求发微博、推广文章、社交媒体更新。
metadata: { "openclaw": { "emoji": "📱" } }
---

# 社交媒体发布

自动生成并发布社交媒体内容。

## 支持平台

| 平台 | 状态 |
|------|------|
| 微博 | ✅ |
| 小红书 | ✅ |
| 微信公众号 | ⏳ |

## 功能

- 获取网站最新文章
- 适配各平台格式
- 生成吸引眼球的标题
- 添加话题标签

## 使用方法

```bash
# 生成微博内容
nucnas-social --platform weibo --latest

# 生成小红书
nucnas-social --platform xiaohongshu --article "文章slug"

# 生成所有平台
nucnas-social --platform all --latest
```

## 内容模板

### 微博
```
【标题】

正文内容...

#话题1 #话题2 #话题3

🔗 原文链接
```

### 小红书
```
【标题】

正文内容...

#标签1 #标签2 #标签3
```

## 注意事项

- 需要平台账号配置才能自动发布
- 目前只支持内容生成
