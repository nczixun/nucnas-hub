---
title: "Day 7：部署上线与安全设置 - 打造安全的AI助手"
date: 2026-03-06
lastmod: 2026-10-06
categories: ["ai"]
slug: "openclaw-day7-deployment-security"
summary: "按官方Docker流程部署OpenClaw，核对端口、认证、持久化、访问范围，并完成安全审计与恢复验收。"
tags: ["OpenClaw", "部署", "Docker", "Nginx", "SSL", "安全"]
---

本篇从“容器启动了”推进到“认证、访问范围、数据和恢复方式都有证据”。先验证本机访问，再规划远程访问。

**资料核对日期：2026-10-06。** 内容依据当前官方文档整理，未在站方真实NAS或云主机实测，不保证旧版本拥有相同脚本和配置。命令面向Linux/macOS/WSL的Bash环境。

## 1. 部署前准备

准备Docker Engine或Docker Desktop、Compose v2、足够磁盘，以及可访问官方源码和镜像仓库的网络。官方文档说明，本地源码构建镜像至少需要6GB内存；使用预构建镜像可避免这项构建要求，但仍需按实际运行负载评估资源。

```bash
docker version
docker compose version
```

先确定主机上没有需要保留的同名旧部署。已有部署应先备份配置、状态及工作区，并记录当前镜像和挂载，不要用全新初始化流程覆盖它。

## 2. 新部署使用官方仓库流程

在准备安装的目录获取官方源码：

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
```

从官方发布记录选择需要的版本，并让该版本的脚本、Compose文件与镜像匹配。不要把下面示例的滚动latest视为可复现版本；正式长期运行时记录并固定验证过的发布标签或镜像摘要。

对全新测试部署，当前官方预构建镜像流程为：

```bash
export OPENCLAW_IMAGE="ghcr.io/openclaw/openclaw:latest"
./scripts/docker/setup.sh
```

脚本会执行初始化、生成网关token、写入.env并通过Compose启动。按向导在本机配置你选定的模型认证，不把凭据粘贴到文章反馈或公开聊天。

官方同时提供Docker Hub镜像，但旧文单独运行镜像、映射8080端口和挂载/data的示例不能代替完整初始化，现已移除。详见[官方Docker安装](https://docs.openclaw.ai/install/docker)。

## 3. 先检查网络暴露，再登录

当前官方默认控制界面地址是主机上的 `http://127.0.0.1:18789/`。在控制界面设置中使用本机.env里的token认证，不公开该文件或含token的链接。

Docker安装脚本默认使用容器内 `lan` 绑定，以便Docker发布端口工作。这不等于只允许主机本机访问：

- 容器内的loopback属于容器自身，不能直接套用主机安装的配置。
- 用Compose配置和实际端口列表确认主机监听地址，决定哪些网络可访问。
- 公网主机必须同时核对云侧访问规则、Docker端口发布及认证。不要以“修改了端口”代替访问控制。
- 不需要远程访问时，不要先开放公网端口来排除故障。

```bash
docker compose ps
docker compose logs --tail 100 openclaw-gateway
docker compose run --rm openclaw-cli dashboard --no-open
```

以上命令在部署的Compose目录执行；若使用额外overlay文件，沿用实际部署的完整Compose参数。dashboard输出可能包含认证信息，只在本机查看。

网络细节见[Docker网络与存储](https://docs.openclaw.ai/install/docker/networking-and-storage)。

## 4. 验证认证与最小功能

先完成以下检查，再启用外部通道或工具：

1. 控制界面能连接网关，普通模型对话可用。
2. 没有凭据的新浏览器会话不能直接获得管理权限；不要把已登录浏览器误当作未认证测试。
3. 确认模型或机器人token只存在于预期的私有配置位置。
4. 从计划允许和不允许的网络分别验证可达性；结果与设计一致。
5. 群聊、私聊配对、工具执行权限分别验证，避免将聊天白名单当作工具沙箱。

可在运行中的Docker部署执行只读审计：

```bash
docker compose run --rm openclaw-cli security audit
```

宿主机CLI安装对应命令为：

```bash
openclaw security audit
```

先阅读发现，再逐项修复。`--fix`会改配置或权限，不应在不了解变更内容时直接运行。审计通过也不能证明不存在全部风险。依据：[安全模型](https://docs.openclaw.ai/gateway/security)、[审计说明](https://docs.openclaw.ai/gateway/security/running-the-audit)。

## 5. 远程访问与反向代理

远程管理需要认证、可信来源和正确的代理设置共同工作。仅增加HTTPS证书不能替代身份验证。

先阅读[官方网络暴露指南](https://docs.openclaw.ai/gateway/security/network-exposure)和[暴露前检查表](https://docs.openclaw.ai/gateway/security/exposure-runbook)，再选择受控远程连接方式。使用反向代理时核对WebSocket转发、可信代理及控制界面来源设置；不要复制一个只代理普通HTTP的Nginx片段就认定部署完成。不要通过关闭设备认证或放开所有来源解决连接错误。

## 6. 持久化、备份与升级

用实际Compose配置确认状态和工作区的持久挂载。工作区的Markdown不是完整备份；凭据、会话状态等也需要按官方备份流程保护。

记录镜像标签/摘要、配置路径、挂载、恢复步骤。在独立测试环境验证备份恢复：能读取预期资料、完成认证并进行基本对话，才算完成恢复验收。

已有部署不要在空环境变量的shell中为了换镜像重跑setup：官方说明脚本会根据当前shell及默认值重写.env。升级时沿用现有Compose文件、overlay、卷和版本兼容说明。不要执行删除持久卷的命令作为常规更新步骤。

## 7. 故障排查

| 现象 | 优先检查 |
|---|---|
| 容器不断重启 | 网关日志、初始化是否完成、资源与挂载权限 |
| 本机网页打不开 | Compose端口、容器绑定、实际主机端口和容器状态 |
| 网页可见但无法连接 | token、设备配对、代理WebSocket和允许来源 |
| 容器无法访问本机模型 | 容器内127.0.0.1并非宿主机；按官方host.docker.internal说明检查，不直接向公网开放模型 |
| 重建后配置丢失 | 实际挂载位置、是否复用了原卷、服务用户权限 |
| 升级后异常 | 保留日志和备份，按版本兼容说明恢复；旧镜像未必可读取新状态 |

完成后记录：版本、部署方式、可达范围、认证验证、安全审计发现与恢复结果。没有做的验证明确标为待做。

[Day 5 自动化](/ai/openclaw-day5-automation-heartbeat/) · [系列目录](/openclaw/)
