---
title: "Docker Compose 进阶教程：2026年多容器编排"
date: 2026-01-01
categories: ["nas"]
summary: "Docker Compose 进阶教程，教你如何编排多个容器"
tags: ["Docker", "Docker Compose", "NAS", "容器", "教程"]
slug: "docker-compose-advanced-2026"
---

# Docker Compose 进阶教程：2026年多容器编排

## 什么是 Docker Compose？

Docker Compose 是一个用于定义和运行多容器 Docker 应用的工具。

## 基础语法

```yaml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
```

## 进阶技巧

### 1. 环境变量

```yaml
services:
  database:
    image: postgres:15
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_DB=app
    env_file:
      - .env
```

### 2. 网络配置

```yaml
services:
  web:
    build: .
    networks:
      - frontend
      - backend
  
  db:
    image: postgres:15
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # 隔离网络
```

### 3. 数据持久化

```yaml
services:
  mysql:
    image: mysql:8
    volumes:
      - mysql_data:/var/lib/mysql
      - ./conf:/etc/mysql/conf.d
      - ./logs:/var/log/mysql

volumes:
  mysql_data:
```

### 4. 依赖关系

```yaml
services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
  
  db:
    image: postgres:15
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U admin -d app"]
      interval: 10s
      timeout: 5s
      retries: 5
```

### 5. 重启策略

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    restart: unless-stopped  # 始终重启，除非手动停止
```

## 完整示例：家庭影院

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - jellyfin_config:/config
      - jellyfin_cache:/cache
      - /mnt/media:/media:ro
    ports:
      - "8096:8096"
      - "8920:8920"
    restart: unless-stopped
    networks:
      - home_lab

  adguard:
    image: adguard/adguardhome
    container_name: adguard
    volumes:
      - adguard_work:/opt/adguardhome/work
      - adguard_conf:/opt/adguardhome/conf
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000/tcp"
    restart: unless-stopped
    networks:
      - home_lab

  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    ports:
      - "9443:9443"
      - "9000:9000"
    restart: unless-stopped
    networks:
      - home_lab

networks:
  home_lab:
    driver: bridge

volumes:
  jellyfin_config:
  jellyfin_cache:
  adguard_work:
  adguard_conf:
  portainer_data:
```

## 常用命令

```bash
# 启动所有服务
docker compose up -d

# 查看日志
docker compose logs -f

# 停止所有服务
docker compose down

# 重启指定服务
docker compose restart web

# 进入容器
docker compose exec web sh

# 查看状态
docker compose ps
```

## 最佳实践

1. **使用版本控制**：将 docker-compose.yml 纳入 Git 管理
2. **环境变量分离**：使用 .env 文件管理敏感信息
3. **健康检查**：为关键服务配置 healthcheck
4. **日志管理**：配置日志轮转
5. **资源限制**：为容器设置内存和 CPU 限制

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    deploy:
      resources:
        limits:
          memory: 4G
          cpus: '2.0'
        reservations:
          memory: 1G
          cpus: '0.5'
```

## 总结

Docker Compose 是管理家庭实验室服务的利器，熟练掌握可以大大提高运维效率。

**下一步**：尝试部署一套属于你的家庭影院系统吧！
