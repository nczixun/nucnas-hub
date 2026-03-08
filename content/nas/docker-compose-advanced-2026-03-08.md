---
title: "Docker Compose 进阶：多容器编排实战指南"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 学院"]
tags: ["Docker", "Docker Compose", "NAS", "容器编排", "自动化", "教程"]
draft: false
---

会用 Docker 但不熟悉 Compose？这篇带你进阶。学会 docker-compose，一键管理所有容器。

## 为什么用 Docker Compose？

手动 docker run 每次都要敲一堆参数，容器多了根本记不住。Compose 用 YAML 文件定义服务，版本控制、迁移、备份都方便。

## 基础结构

```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret
```

## 进阶技巧

### 1. 环境变量管理

创建 `.env` 文件：

```bash
# .env
POSTGRES_PASSWORD=your_secure_password
DATA_PATH=/mnt/storage
```

Compose 自动读取：

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ${DATA_PATH}/postgres:/var/lib/postgresql/data
```

### 2. 网络隔离

```yaml
services:
  web:
    networks:
      - frontend
  db:
    networks:
      - backend

networks:
  frontend:
  backend:
    internal: true  # 完全隔离
```

### 3. 健康检查

```yaml
services:
  redis:
    image: redis
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 4. 依赖关系

```yaml
services:
  web:
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

## 常用命令

```bash
# 启动所有服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 更新镜像
docker-compose pull
docker-compose up -d

# 停止所有服务
docker-compose down
```

## 我的 NAS 配置分享

这是我目前在用的部分配置：

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    network_mode: host
    volumes:
      - ./ha:/config
    restart: unless-stopped

  portainer:
    image: portainer/portainer-ce
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./portainer:/data

  nginx:
    image: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/html:/usr/share/nginx/html
      - ./nginx/ssl:/etc/nginx/ssl:ro
```

## 总结

Docker Compose 真的是用了就回不去。配置一次，下次开机一键启动所有服务。建议大家都花时间学一下，真的能省很多功夫。

---
*测试环境：群晖 DS920+ Docker 24.0*
