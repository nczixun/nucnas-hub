---
name: social-poster
description: 社交媒体自动发布。将网站文章改编后发布到微博、小红书、微信公众号等平台。
---

# 社交媒体发布

自动发布内容到各平台。

## 支持平台

| 平台 | 状态 |
|------|------|
| 微博 | ✅ |
| 小红书 | ✅ |
| 微信公众号 | ⏳ (需配置) |

## 使用方法

```bash
# 发布到微博
social-post --platform weibo --latest

# 发布到小红书
social-post --platform xiaohongshu --article "文章slug"

# 发布到所有平台
social-post --platform all --latest
```

## 内容适配

自动将文章改编为各平台风格：
- 微博：话题标签 + 短链接
- 小红书：种草风格 + emoji
- 微信公众号：引导关注格式
