---
name: social-media-automation
description: 国内社交媒体自动运营。支持微信公众号、微博、小红书、抖音/B站内容生成和定时发布。
---

# 社交媒体运营助手

自动为国内社交平台生成并发布内容。

## 支持平台

| 平台 | 状态 | 说明 |
|------|------|------|
| 微信公众号 | ⏳ | 需要微信扫码登录网页版 |
| 微博 | ⏳ | 需要微博cookie |
| 小红书 | ⏳ | 需要cookie |
| 抖音/B站 | ⏳ | 脚本生成 |

## 内容模板

### 微信公众号

```markdown
标题：xxx
正文：xxx
引导关注：点击上方蓝字关注我们
```

### 微博

```markdown
#话题# 内容文字
[图片]
@相关账号
```

### 小红书

```markdown
标题：xxx
标签：#xxx #xxx
正文：xxx
```

### 抖音/B站

```markdown
脚本：
1. 开场：xxx
2. 内容：xxx
3. 结尾：xxx

话题：#xxx
```

## 使用方法

```powershell
# 生成社交媒体内容
social-post -Platform "wechat" -Article "apple-mac-mini-m4"

# 定时发布
social-schedule -Platform "all" -Time "20:00"
```

## 自动化工流

1. 从网站文章获取素材
2. 根据平台特点改编内容
3. 定时发布到各平台
4. 监控数据反馈
