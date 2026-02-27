# 使用指南

## 技能1: nucnas-content-generator
**自动生成网站文章**

### 快速使用

```powershell
# 1. 进入项目目录
cd D:\Projects\nucnas-hub

# 2. 生成文章（默认3篇）
.\skills\nucnas-content-generator\scripts\generate.ps1

# 3. 指定数量
.\skills\nucnas-content-generator\scripts\generate.ps1 -Count 5

# 4. 指定分类
.\skills\nucnas-content-generator\scripts\generate.ps1 -Count 3 -Category "hardware"

# 5. 生成后自动发布
.\skills\nucnas-content-generator\scripts\generate.ps1 -Publish
```

### 工作原理
1. 读取 `content_plan.json` 中的待写主题
2. 自动获取 Pexels 免费图片
3. 生成 Hugo 格式 Markdown 文件
4. `-Publish` 会自动构建并推送到 GitHub

---

## 技能2: nucnas-social-promoter
**自动推广到社交媒体**

### 首次配置

创建 `promotion-config.json`：

```json
{
  "feishu": {
    "webhook": "你的飞书Webhook地址"
  },
  "telegram": {
    "bot_token": "你的Bot Token",
    "chat_id": "你的Chat ID"
  }
}
```

### 使用方法

```powershell
# 推广最新文章到飞书
.\skills\nucnas-social-promoter\scripts\promote.ps1 -Platform feishu

# 推广到Telegram
.\skills\nucnas-social-promoter\scripts\promote.ps1 -Platform telegram

# 推广到所有平台
.\skills\nucnas-social-promoter\scripts\promote.ps1 -Platform all

# 推广指定文章（根据slug）
.\skills\nucnas-social-promoter\scripts\promote.ps1 -Slug "asus-nuc-14-pro-plus"
```

---

## 完整工作流

```powershell
# 每天早上：生成内容 + 发布
cd D:\Projects\nucnas-hub
.\skills\nucnas-content-generator\scripts\generate.ps1 -Publish

# 发布后：自动推广
.\skills\nucnas-social-promoter\scripts\promote.ps1 -Platform all
```

---

## 定时自动运行

已配置的定时任务：
- 每天 8:00 自动构建发布（ID: 953a6dbe...）

需要我帮你配置社交媒体账号吗？
