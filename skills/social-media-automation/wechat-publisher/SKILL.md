---
name: wechat-publisher
description: 微信公众号自动发布。功能：获取最新文章、生成公众号格式内容、发布到草稿箱。需要微信网页版cookie。
---

# 微信公众号发布助手

自动将网站文章发布到微信公众号草稿箱。

## 使用方法

```powershell
# 生成公众号内容
.\wechat-publisher.ps1 -Article "apple-mac-mini-m4"

# 发布到草稿箱
.\wechat-publisher.ps1 -Publish
```

## 内容模板

```
【标题】
正文内容...

---
点击上方蓝字关注我们
```

## 配置

在 `wechat-config.json` 中配置：

```json
{
  "cookie": "你的微信cookie",
  "token": "你的token"
}
```

## 注意事项

⚠️ 微信网页版需要扫码登录，cookie可能过期
⚠️ 建议手动复制粘贴到公众号后台
