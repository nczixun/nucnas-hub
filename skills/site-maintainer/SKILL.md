---
name: site-maintainer
description: 网站维护工具。自动构建、部署、备份、监控网站状态。
---

# 网站维护

自动化网站运维。

## 功能

- 自动构建 (Hugo)
- 自动部署到 GitHub
- 定时备份
- 监控网站状态
- 自动修复常见问题

## 使用方法

```bash
# 构建网站
site build

# 部署发布
site deploy

# 备份
site backup

# 检查状态
site status
```

## 定时任务

可设置自动执行：
- 每日构建发布
- 每周备份
- 定时检查网站状态
