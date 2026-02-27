---
name: social-scheduler
description: 社交媒体定时发布。设置定时任务自动发布内容到各平台。
---

# 社交媒体定时发布

设置自动发布任务。

## 使用方法

```powershell
# 设置定时发布
.\schedule-post.ps1 -Platform "weibo" -Time "09:00" -Days "Mon,Tue,Wed,Thu,Fri"

# 查看定时任务
.\schedule-post.ps1 -List
```

## 定时规则

| 参数 | 说明 | 示例 |
|------|------|------|
| Time | 发布时间 | "09:00" |
| Days | 发布日期 | "Mon,Tue,Wed,Thu,Fri" |
| Platform | 平台 | "weibo,xiaohongshu" |

## 工作流程

1. 每天定时检查新文章
2. 生成适配各平台的内容
3. 发布到对应平台
4. 记录发布状态

## 平台最发布时间

| 平台 | 最佳时间 |
|------|----------|
| 微博 | 9:00-10:00 |
| 小红书 | 12:00-13:00 |
| 抖音 | 18:00-20:00 |
| 微信公众号 | 20:00-22:00 |
