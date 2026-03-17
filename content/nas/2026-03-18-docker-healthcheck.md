---
title: "Docker容器健康检查与自动重启配置实战"
date: 2026-03-18
categories: ["NAS"]
tags: ["Docker", "容器健康检查", "自动重启", "NAS"]
description: "详解Docker健康检查机制，实现容器故障自动恢复，提升NAS稳定性。"
keywords: ["Docker健康检查", "HEALTHCHECK", "容器自动重启", "Docker restart policy"]
author: "NUC NAS Hub"
---

# Docker容器健康检查与自动重启配置实战

## 为什么需要健康检查？

NAS上的Docker容器可能因为各种原因崩溃：内存泄漏、依赖服务不可用、配置错误等。健康检查机制可以：
- 自动检测容器健康状态
- 故障时自动重启
- 保障服务持续可用

## Docker健康检查详解

### HEALTHCHECK指令

Dockerfile中可以通过HEALTHCHECK定义健康检查：

```dockerfile
FROM nginx:latest

# 每30秒检查一次，超时5秒，连续3次失败视为不健康
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### 健康检查选项

| 参数 | 说明 | 示例值 |
|------|------|--------|
| --interval | 检查间隔 | 30s |
| --timeout | 单次检查超时 | 5s |
| --start-period | 启动等待时间 | 10s |
| --retries | 连续失败次数 | 3 |

## docker-compose中的健康检查

### 标准配置示例

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 10s
    restart: unless-stopped

  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: password
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 30s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  redis:
    image: redis:7
    command: redis-server --appendonly yes
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 3s
      retries: 3
    restart: unless-stopped
```

### 常用服务健康检查命令

| 服务 | 检查命令 |
|------|----------|
| Nginx | `curl -f http://localhost/` |
| MySQL | `mysqladmin ping -h localhost` |
| PostgreSQL | `pg_isready -U postgres` |
| Redis | `redis-cli ping` |
| Elasticsearch | `curl -f http://localhost:9200/_cluster/health` |
| Jellyfin | `curl -f http://localhost:8096/health` |

## restart policy（重启策略）

### 四种策略对比

| 策略 | 行为 | 适用场景 |
|------|------|----------|
| no | 不重启 | 临时测试 |
| on-failure | 失败时重启 | 开发环境 |
| always | 始终重启 | 需要持续运行 |
| unless-stopped | 手动停止外始终重启 | 生产环境推荐 |

### 推荐配置

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant:latest
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8123/"]
      interval: 30s
      timeout: 10s
      retries: 3

  jellyfin:
    image: jellyfin/jellyfin:latest
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096/health"]
      interval: 60s
      timeout: 10s
      retries: 3
```

## 监控与告警

### 查看容器健康状态

```bash
# 查看所有容器状态
docker ps -a

# 查看健康检查详情
docker inspect --format='{{.State.Health}}' container_name

# 查看健康检查日志
docker inspect container_name | grep -A 10 "Health"
```

### 配合Portainer监控

Portainer提供了可视化健康状态查看：
- 绿色：健康
- 黄色：正在检查
- 红色：不健康

### 告警脚本

```bash
#!/bin/bash
# health-alert.sh

CONTAINER=$1
STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER)

if [ "$STATUS" = "unhealthy" ]; then
    curl -s -X POST "https://notify.example.com/send" \
        -d "message=$CONTAINER is unhealthy!"
fi
```

## 常见问题解决

### 问题1：健康检查误报

**原因**：检查间隔太短，容器启动慢
**解决**：增加 `--start-period` 值

### 问题2：curl命令不存在

**解决**：使用wget或安装curl：
```dockerfile
RUN apt-get update && apt-get install -y curl
```

### 问题3：服务已停止但容器显示健康

**原因**：健康检查命令有问题
**解决**：仔细测试检查命令，确保能正确检测服务状态

## 总结

健康检查是保障NAS Docker服务稳定运行的关键。建议：
1. 所有长期运行的服务都配置健康检查
2. 使用 `restart: unless-stopped` 策略
3. 定期检查容器健康状态日志

**相关文章**：
- [NAS Docker应用推荐](/nas/nas-docker-apps-recommend-2026)
- [Docker最佳实践](/nas/docker-best-practice)
