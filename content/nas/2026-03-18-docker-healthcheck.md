---
date: 2026-03-18
categories: ["nas"]
tags: ["Docker", "容器健康检查", "自动重启", "NAS"]
keywords: ["Docker健康检查", "HEALTHCHECK", "容器自动重启", "Docker restart policy"]
author: "NUC NAS Hub"

slug: "docker容器健康检查与自动重启配置实战"







title: "Docker健康检查与重启策略：两者有什么区别"

summary: "Docker健康检查与重启策略：两者有什么区别"

description: "Docker健康检查与重启策略：两者有什么区别：前提、核对方法与验收。"

lastmod: "2026-10-13"

contentStatus: "reviewed"

contentType: "资料整理"
reviewedAt: 2026-10-13
---

资料核对：**2026-10-13**。旧稿存在无法恢复的乱码和缺少证据的结论。本次重写可确认的操作边界；本站未进行真实设备或软件部署实测。

## 前提

先读镜像自己的运行说明，确认容器内有哪些命令，以及哪个探测真正代表应用可用。不要把curl写进没有curl的镜像。

## 健康状态不等于自动恢复

Compose的healthcheck执行探测并标记健康状态；普通Docker重启策略主要响应容器退出。容器仅变成unhealthy不会因写了restart就自动重启。修复或监控方案需要另行设计，不能靠无限重启掩盖数据问题。

## 只读检查

```sh
docker compose ps
docker compose logs --tail=100 SERVICE
docker inspect --format '{{json .State.Health}}' CONTAINER
```

SERVICE/CONTAINER是占位符，替换为实际名称；未配置健康检查时可能没有Health字段。先用测试环境验证探测成功与失败，再核对日志、超时和启动宽限期。生产变更先备份配置，密钥不写进教程示例。

## 资料与下一步

- [Docker Compose服务配置](https://docs.docker.com/reference/compose-file/services/)
- [Docker重启策略](https://docs.docker.com/engine/containers/start-containers-automatically/)
