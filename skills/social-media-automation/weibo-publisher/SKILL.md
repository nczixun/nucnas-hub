---
name: weibo-publisher
description: 微博自动发布。支持定时发布、带话题、@相关账号。需要微博cookie。
---

# 微博发布助手

自动将网站文章发布到微博。

## 使用方法

```powershell
# 生成微博内容
.\weibo-post.ps1 -Article "apple-mac-mini-m4"

# 直接发布
.\weibo-post.ps1 -Publish
```

## 内容模板

```
【标题】

正文内容...

#话题1 #话题2 #话题3

🔗 原文链接
```

## 配置

```json
{
  "cookie": "你的微博cookie",
  " Referer": "https://weibo.com"
}
```

## 热门话题推荐

- #数码
- #科技
- #测评
- #NAS
- #迷你主机
- #数码测评
