# NUC NAS Hub - 自动发布配置

## 定时任务设置

### 方式1: OpenClaw Cron (推荐)

```bash
# 添加每日自动发布任务
openclaw cron add --cron "0 8 * * *" --name "nucnas-daily-publish" --message "构建并推送网站" --timeout-seconds 180
```

### 方式2: Windows 任务计划程序

创建 `publish-task.xml`:
```xml
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>2026-01-01T08:00:00</StartBoundary>
      <ScheduleByDay>
        <DaysInterval>1</DaysInterval>
      </ScheduleByDay>
    </CalendarTrigger>
  </Triggers>
  <Actions>
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-File "D:\Projects\nucnas-hub\scripts\publish.ps1"</Arguments>
    </Exec>
  </Actions>
</Task>
```

### 方式3: GitHub Actions (推荐)

创建 `.github/workflows/daily-publish.yml`:

```yaml
name: Daily Publish
on:
  schedule:
    - cron: '0 0 * * *'  # 每天 UTC 0点 = 北京时间 8点
  workflow_dispatch:

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.157.0'
          
      - name: Build
        run: hugo --minify
        
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

## 改进项 (V2)

### ✅ 已改进

1. **智能去重**
   - 大小写不敏感
   - 检测所有分类目录
   - 多种文件名变体

2. **SEO优化**
   - 自动生成 keywords
   - 添加 description
   - 更丰富的标签

3. **内容增强**
   - 生成完整文章结构
   - 添加前言/总结
   - 适用场景说明

4. **错误处理**
   - Pexels失败时使用默认图
   - 详细的日志输出
   - 统计报告

### 🚧 待完成

1. 接入AI生成真正完整内容
2. 社交媒体自动推广配置
3. 内容审核工作流
