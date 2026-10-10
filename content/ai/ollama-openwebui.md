---
slug: "ollama-openwebui"
title: "Ollama + OpenWebUI 搭建本地 AI 聊天界面"
date: 2026-02-18
categories: ["ai"]
summary: "使用内置Ollama镜像建立单机测试环境，验证会话持久化，记录版本与备份回退。"
tags: ["Ollama", "OpenWebUI", "教程"]
description: "Open WebUI单机教程：官方镜像、版本占位配置、回环端口、持久化卷与升级回退验证。"
lastmod: 2026-10-10
---

资料核对：**2026-10-10**。本文采用官方提供的“Open WebUI 内置 Ollama”镜像做单机 CPU 入门示例，避免首次部署时混淆宿主机和容器的 localhost。本次未启动 Docker 容器，以下步骤需要在你的环境验收。

## 前置条件与范围

先完成 [Docker 基础](/guide/docker-best-practice/)，确认 `docker version` 与 `docker compose version` 可用。需要联网拉取镜像和模型，并预留对应存储与内存。没有统一的“最低配置就能流畅”保证。

这个方案会建立**独立的 Ollama 实例和模型卷**，不会自动复用宿主机已有模型。若已按 [Ollama 入门](/ai/ollama-beginner-guide-2026/)安装，先选择是否接受这份独立存储；接入已有服务的方案应按[官方快速开始](https://docs.openwebui.com/getting-started/quick-start/)配置容器到宿主机的地址与可达性，不能将容器里的 localhost 当成宿主机。

## 选择版本并建立测试项目

新建空目录 `openwebui-demo`，后续命令都在此目录执行。先从[官方发布页](https://github.com/open-webui/open-webui/releases)选定一个已发布版本，阅读其兼容性和迁移说明。下面的 `X.Y.Z` 是必须替换的占位符，不是可运行的镜像标签；内置 Ollama 变体使用 `vX.Y.Z-ollama`。不要以为浮动 `main` 或 `latest` 等同于稳定发布版。

在本机用 Python 生成随机密钥（没有 Python 时可使用官方文档的 OpenSSL 方法）：

```sh
python -c "import secrets; print(secrets.token_hex(32))"
```

将版本和自己生成的密钥填入 `.env`，不要把这个文件上传到公开仓库或截图分享：

```dotenv
OPEN_WEBUI_IMAGE=ghcr.io/open-webui/open-webui:vX.Y.Z-ollama
WEBUI_SECRET_KEY=替换为刚生成的随机密钥
```

保存 `compose.yaml`：

```yaml
name: openwebui-demo
services:
  webui:
    image: ${OPEN_WEBUI_IMAGE:?Set a verified release image in .env}
    ports:
      - "127.0.0.1:3000:8080"
    environment:
      WEBUI_SECRET_KEY: ${WEBUI_SECRET_KEY:?Set a random persistent secret in .env}
      OLLAMA_NO_CLOUD: "1"
    volumes:
      - open-webui:/app/backend/data
      - ollama:/root/.ollama
    restart: unless-stopped
volumes:
  open-webui:
  ollama:
```

此处只开放本机浏览器端口；不发布 Ollama 的 11434，也不启用 GPU。界面数据和模型各放在独立卷中，固定密钥随配置备份保存。云功能变量作用于内置 Ollama，不会替你禁用界面中配置的其他外部服务。

## 启动并验证

```sh
docker compose config --quiet
docker compose pull
docker compose up -d
docker compose ps
docker compose logs --tail 80 webui
docker compose exec webui ollama pull qwen3:0.6b
docker compose exec webui ollama list
```

`config --quiet` 只检查配置，不验证镜像存在或模型能运行。查看日志时避免公开个人信息或密钥。打开 `http://127.0.0.1:3000`，完成首次账户设置，选择下载的模型，发起无敏感信息的测试对话。菜单名称随版本变化，以所选版本说明为准；不要通过关闭认证来解决登录问题。

随后运行 `docker compose restart webui`，重新登录，确认测试会话和模型仍存在。在界面中核对模型连接指向内置 Ollama；不能仅看到网页能打开就宣称部署完成。若本机 3000 已被占用，只修改映射左侧端口，例如 `127.0.0.1:3001:8080`，再使用新地址。

| 现象 | 检查顺序 |
| --- | --- |
| 镜像拉取失败 | `.env` 是否替换占位符、版本是否存在、网络和磁盘空间 |
| 页面打不开 | 容器状态和日志、端口冲突；在运行 Docker 的同一机器访问 |
| 界面没有模型 | 内置实例的 `ollama list`、界面连接设置、刷新模型列表 |
| 重建后像全新安装 | Compose 项目名和目录、原数据卷挂载；先找原卷，不删除重建 |
| 模型很慢 | CPU 资源和内存、小模型是否合适；GPU 加速另按官方硬件说明配置 |

## 停止、备份与升级

临时停止用 `docker compose stop`；正常拆除容器可用 `docker compose down`。**不要加 `-v`**，它会删除此项目声明的命名卷。卷能跨容器保留数据，不等于已经有独立备份。

升级前记录实际镜像版本/摘要，停止写入后备份 UI 数据卷、`.env` 和 Compose 文件；模型卷可备份或记录清单后重新下载。升级后验证登录、会话与模型调用。若版本涉及数据库迁移，只改回旧镜像可能无法恢复，需同时恢复匹配版本的数据备份。先用测试数据演练，别把首次回退留给真实故障。

官方依据：[镜像变体、存储与版本标签](https://docs.openwebui.com/getting-started/quick-start/)、[Compose 数据卷](https://docs.docker.com/engine/storage/volumes/)、[down 参数](https://docs.docker.com/reference/cli/docker/compose/down/)、[Ollama 云功能设置](https://docs.ollama.com/faq)。

[返回本地 AI 阅读路线](/local-ai-roadmap/) · [继续知识库样例](/ai/local-ai-knowledge-base-guide/)
