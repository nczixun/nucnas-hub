---
title: "Day 5：自动化任务与心跳机制 - AI主动为你工作"
date: 2026-03-04
lastmod: 2026-10-06
categories: ["ai"]
aliases: ["/openclaw/openclaw-day5-automation-heartbeat/"]
slug: "openclaw-day5-automation-heartbeat"
summary: "区分心跳与独立定时任务，使用官方automations命令创建、验收、暂停任务，检查时区和投递结果。"
tags: ["OpenClaw", "心跳", "自动化", "Cron", "定时任务"]
---

目标是创建一个有明确时区、可查运行历史、可暂停的测试任务，再扩展到真实工作。

**资料核对日期：2026-10-06。** 以下为当前官方文档整理，未在站方实际网关执行定时任务。先检查本机版本和帮助，旧版本命令与心跳存储方式可能不同。

## 1. 心跳和独立任务分别做什么

| 机制 | 适用场景 | 关键限制 |
|---|---|---|
| 心跳 | 周期性查看是否有值得提醒的变化 | 会受活动时间、繁忙队列等条件影响，不是精确闹钟 |
| 独立automation | 指定时区的日程、一次性提醒、独立运行与历史追踪 | 网关、模型与投递通道均需可用 |

当前官方文档使用 `openclaw automations` 管理任务，`openclaw cron` 仍为别名。心跳也由自动化调度器管理，频率在agent的heartbeat配置中维护。

**在Markdown里写“08:00检查邮件”不会自行注册日程。** 当前心跳指令来自monitor scratch，运行时不再读取HEARTBEAT.md。旧文件迁移需先备份，再按当前官方说明考虑 `openclaw doctor --fix`；它会修改状态，不应作为无风险查看命令运行。

旧文的 `openclaw task morning-brief` 和 `openclaw check-notifications` 示例已移除，请不要照抄。

依据：[自动化概览](https://docs.openclaw.ai/automation/cron-jobs)、[当前心跳机制](https://docs.openclaw.ai/gateway/heartbeat)。

## 2. 前置检查

```bash
openclaw --version
openclaw gateway status
openclaw automations --help
openclaw automations list --all
```

确认已有任务，避免重复创建。确认模型能在普通对话中回答；需要发送到平台时先完成Day 2的通道与权限验证。后台任务可能消耗模型额度，频率先从低频开始。

本节命令写为单行，避免把Bash续行符直接粘贴进PowerShell。

## 3. 创建每天08:00的测试任务

下面将结果投递给已配置的Telegram测试账号。先把 `YOUR_TELEGRAM_USER_ID` 替换为你已确认的收件账号ID；若未配置Telegram，先在控制界面选择已有通道和明确的投递对象，不要原样执行。

```bash
openclaw automations create "0 8 * * *" "只回复：自动化测试完成。不要读取外部资料或执行其他操作。" --name "每日自动化测试" --tz "Asia/Shanghai" --session isolated --announce --channel telegram --to "YOUR_TELEGRAM_USER_ID"
```

这条命令使用OpenClaw内置调度器，不是让你把它放入操作系统crontab。不要在多个调度器里重复安排同一任务。

保存返回的job ID，并检查实际保存的时区、提示词和投递对象：

```bash
openclaw automations list
openclaw automations get YOUR_JOB_ID
openclaw automations show YOUR_JOB_ID
```

参数以[官方任务管理示例](https://docs.openclaw.ai/automation/cron-jobs/managing-jobs)为依据，调度行为见[时间规则](https://docs.openclaw.ai/automation/cron-jobs/schedules)。请核对显示的下一次运行时间；准点日程仍可能因网关忙碌或离线而延迟。

## 4. 立即测试，再暂停

以下操作会真实调用一次模型并尝试发送测试结果：

```bash
openclaw automations run YOUR_JOB_ID --wait --wait-timeout 10m --poll-interval 2s
openclaw automations runs YOUR_JOB_ID --limit 10
openclaw automations disable YOUR_JOB_ID
```

将所有 `YOUR_JOB_ID` 替换为创建结果中的实际ID。手动运行不会替你取消后续日程，所以测试后先暂停。

验收时同时检查：

- 运行历史是否有本次记录，而不是只看到“已入队”。
- 任务执行和整个运行的完成状态是否成功。
- 指定收件账号是否确实收到消息，是否重复收到。
- 暂停后任务是否显示禁用；确认后才考虑重新启用。

当前历史中的执行 `status: ok` 不一定表示投递成功，还需查看 `completionStatus` 与投递详情。不要只依据模型生成了文本判断消息已经送达。

需要重新启用时：

```bash
openclaw automations enable YOUR_JOB_ID
```

## 5. 再扩展为实际维护

把测试提示词替换为真实任务前，明确数据来源、允许动作、成功条件、通知条件和结束日期。例如：“只检查指定页面；仅失败时通知；记录状态码；不得修改配置”。有文件写入或发布的任务还需明确目标范围，并采用可重复执行且不会重复发布的设计。

不要把日程定义放进心跳scratch。scratch适合短检查说明；独立定时工作用automation管理。若只是查看心跳，可先从 `openclaw cron list --all` 找到系统monitor，不要手改系统任务来替代heartbeat配置。

## 6. 常见故障

| 现象 | 排查方向 |
|---|---|
| 没有到点记录 | 网关是否运行、任务是否启用、保存的时区/下一次时间、调度是否被禁用 |
| 已入队但没有结束 | 查看本次运行状态、队列和超时，不连续手动触发重复工作 |
| 执行成功但没收到消息 | 检查completionStatus、通道、收件ID及投递授权 |
| 心跳不运行 | 活动时间、队列忙碌、频率设置、空scratch及调度器状态 |
| 重复提醒 | 检查是否重复创建或同时使用系统cron；先暂停重复项再处理 |
| 重启后任务异常 | 查运行历史与持久状态，不假定漏跑任务已自动补做 |

进一步查看[官方自动化排错](https://docs.openclaw.ai/automation/cron-jobs/troubleshooting)。保留脱敏的job ID、运行时间、版本和错误信息，便于定位。

前置：[Day 2 平台接入](/ai/openclaw-day2-platform-integration/) · [Day 3 工作区](/ai/openclaw-day3-core-concepts/) · 后续：[Day 7 部署安全](/ai/openclaw-day7-deployment-security/)
