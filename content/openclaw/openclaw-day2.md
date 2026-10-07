---
draft: true
# Duplicate retained for history; published version lives in content/ai.
title: "Day 2：接入飞书/Telegram/Discord，打造你的专属AI助手"
date: 2026-03-01
lastmod: 2026-10-05
categories: ["ai"]
slug: "openclaw-day2-platform-integration"
summary: "按官方资料配置飞书、Telegram 与 Discord：包含版本前提、私聊配对、接入验证和故障排查。"
tags: ["OpenClaw", "飞书机器人", "Telegram Bot", "Discord Bot", "AI助手配置"]
---

本篇目标是先让你自己的账号通过一个通讯平台与 OpenClaw 对话，再考虑开放群聊。任选一个平台完成即可，不必同时接入三个。

**资料核对日期：2026-10-05。** 本文为官方文档整理，未在站方真实机器人账号上进行端到端实测。飞书向导要求 OpenClaw **2026.5.29 或更新版本**；其他命令以核对日官方文档为准，不承诺适用于所有旧版本。

## 开始前：确认本机已经能对话

先完成 OpenClaw 安装及模型配置，并在已有界面验证模型能正常回答。通讯平台只负责收发消息，不会自动补齐模型凭据或修复模型故障。

在运行 OpenClaw 的主机上检查：

```bash
openclaw --version
openclaw gateway status
```

保留现有配置备份。若使用自定义配置路径、容器或服务账号，应修改该实例实际读取的文件；默认配置为 `~/.openclaw/openclaw.json`。下面的配置片段需要合并到已有配置，**不要用它覆盖整份文件**。

准备平台应用管理权限，并确认网关主机可连接所选平台。凭据只在本机配置或官方平台输入，不发到群聊、截图、Git 仓库或反馈工单。示例中的占位符必须替换为你自己创建的机器人凭据。

| 平台 | 准备内容 | 建议先验证 |
|---|---|---|
| 飞书/Lark | 应用及机器人权限；App ID、App Secret，或向导扫码 | 自己账号的私聊 |
| Telegram | BotFather 创建的机器人及 token | 私聊配对和回复 |
| Discord | 开发者应用、机器人 token、测试服务器 | 私聊，再检查服务器权限 |

## 方案一：飞书 / Lark

### 1. 运行当前官方向导

```bash
openclaw channels login --channel feishu
```

向导会在缺少时安装官方 `@openclaw/feishu` 插件，并提供扫码或手动配置。扫码路径会将私聊限制为扫码账号；若扫码无反应，改用手动方式。

手动方式：在[飞书开放平台](https://open.feishu.cn/)创建自建应用，准备 App ID 和 App Secret，并在向导中选择正确的飞书或 Lark API 域。旧文中的顶层 `feishu_app_id`、`feishu_app_secret` 配置写法已移除，请勿继续照抄。

### 2. 检查平台侧配置

确认应用已启用机器人能力，并按当前向导及平台要求授予对应消息权限。不要继续沿用旧文章的两项权限清单，也不要为解决消息故障一次开放全部文档或云盘权限。

在事件订阅中确认包含 `im.message.receive_v1`；使用本教程默认的 WebSocket 长连接方式。完成发布和所需审批，确认测试账号在应用可用范围内。长连接方式无需为机器人另开公网回调地址。

### 3. 验证私聊

```bash
openclaw channels status --probe
```

网关离线时先启动网关，再检查通道。用配置时指定的账号发一条简单消息。如果你选择的是 `pairing` 私聊策略，需要先审核配对请求；扫码默认的账号白名单方式不应被误当成配对故障。

依据：[飞书接入向导](https://docs.openclaw.ai/channels/feishu/setup)、[飞书通道说明](https://docs.openclaw.ai/channels/feishu)、[飞书排错](https://docs.openclaw.ai/channels/feishu/troubleshooting)。

## 方案二：Telegram

### 1. 创建机器人

在 Telegram 找到用户名准确为 **@BotFather** 的官方机器人，发送 `/newbot` 并按提示创建。妥善保存生成的 token。

### 2. 合并最小私聊配置

在默认配置文件中合并以下字段；已有 `channels` 时在其中新增 `telegram`，不要重复创建同名对象：

```json
{
  "channels": {
    "telegram": {
      "enabled": true,
      "botToken": "YOUR_TELEGRAM_BOT_TOKEN",
      "dmPolicy": "pairing"
    }
  }
}
```

这里用文件配置，避免把真实 token 写入演示命令或终端历史。限制该文件的读取权限。Telegram 接入不使用飞书的登录命令。

### 3. 检查并配对

```bash
openclaw channels status --probe
```

用自己的 Telegram 账号私聊机器人，收到配对码后，在网关主机上列出并核对请求：

```bash
openclaw pairing list telegram
openclaw pairing approve telegram YOUR_PAIRING_CODE
```

将 `YOUR_PAIRING_CODE` 替换为本次请求的实际配对码。批准后再发送测试消息。不要批准来源不明的账号。群聊权限需另外配置，私聊配对不等于允许群成员调用助手。

依据：[Telegram 官方接入步骤](https://docs.openclaw.ai/channels/telegram/setup)。

## 方案三：Discord

### 1. 准备应用与测试服务器

打开 [Discord Developer Portal](https://discord.com/developers/applications)，创建应用并启用 Bot，取得机器人 token。首次测试使用你可管理的私有服务器。

在 Bot 设置中，普通服务器消息需要 **Message Content Intent**；角色白名单等功能还涉及 **Server Members Intent**。在 OAuth2 邀请设置中选择 `bot` 和 `applications.commands`。按实际功能授予查看频道、发送消息、读取历史等权限；需要文件或嵌入消息时增加相应权限，不要直接授予 Administrator。

### 2. 配置 token 并验证

将以下内容合并到当前配置。明文 token 字段是官方支持的简化方式；长期运行可按官方文档改用 SecretRef，避免把凭据提交到源码中。

```json
{
  "channels": {
    "discord": {
      "enabled": true,
      "token": "YOUR_DISCORD_BOT_TOKEN",
      "dmPolicy": "pairing"
    }
  }
}
```

```bash
openclaw channels status --probe
```

将机器人邀请进测试服务器，确认 Discord 的隐私设置允许该服务器成员私聊。向机器人发私信，在主机上审核：

```bash
openclaw pairing list discord
openclaw pairing approve discord YOUR_PAIRING_CODE
```

先完成私聊验收。之后若要使用服务器频道，再按[官方服务器工作区配置](https://docs.openclaw.ai/channels/discord/setup)限定服务器 ID、用户 ID 和提及规则；不要把“机器人已加入服务器”当作所有成员已经获准使用。

## 配对审批的范围

配对批准前先核对发起人的账号信息。当前官方文档说明：CLI 在尚未配置命令所有者时，首次配对批准还会初始化命令所有者。因此首次审批应由安装维护者对自己的账号完成。

私聊访问、群聊访问与命令所有者是不同权限。若只想批准私聊且需要明确查看所有者选项，可使用控制界面 **Settings → Channels → DM access requests**。详见[配对与权限说明](https://docs.openclaw.ai/channels/pairing)。

## 通用验收：连上平台还不等于接入完成

按顺序记录结果，任一步失败先排查该层：

1. 网关运行，`openclaw channels status --probe` 能探测到对应通道。
2. 指定账号发消息后，能观察到接收事件或预期的配对请求。
3. 访问审批完成后，一条简单文本能得到模型回复。
4. 若准备开放群聊，单独验证群白名单和提及要求；确认未授权账号不能触发助手。
5. 服务重启后再次检查通道，确认实际服务账号能读取配置。若使用环境变量，必须让后台服务也能读取它，不能只在临时终端设置。

## 常见故障与排查顺序

| 现象 | 优先检查 |
|---|---|
| 飞书向导命令不可用 | 版本是否达到要求；检查当前版本帮助和官方向导，不套用旧配置命令 |
| 飞书探测正常但没有消息 | 应用发布/审批、账号可用范围、消息事件订阅、长连接模式及权限 |
| Telegram 配对列表为空 | 是否先向正确机器人发送消息、网关是否运行、token 是否属于该机器人 |
| Discord 私聊无响应 | 邀请是否成功、隐私设置是否允许私聊、通道探测和配对请求 |
| 私聊正常、群聊无响应 | 群/服务器授权与提及规则；Discord intent；Telegram 群隐私模式 |
| 收到消息但模型报错 | 回到本机检查模型认证、额度或服务连通性；平台在线不代表模型可用 |
| 重启后掉线 | 配置路径、运行账号、服务环境是否与手动启动时一致 |

需要进一步观察时运行：

```bash
openclaw logs --follow
```

只分享脱敏后的错误片段，不公开 token、App Secret 或包含个人聊天内容的整份日志。若凭据已经泄露，在对应官方平台撤销或轮换，再更新本地配置。

完成本篇后，记录所用版本、平台、配置位置和验收日期，继续阅读站内 [OpenClaw 系列](/openclaw/)。
