---
aliases: ["/openclaw/openclaw-day4-skills-system/"]
date: 2026-03-03
categories: ["ai"]
slug: "openclaw-day4-skills-system"
tags: ["OpenClaw", "Skills", "技能系统", "ClawHub", "插件"]

title: "Day 4：Skills技能的来源、安装与验收"
summary: "Day 4：Skills技能的来源、安装与验收：版本核对、操作边界与验收。"
reviewedAt: 2026-10-13
lastmod: 2026-10-13
contentStatus: reviewed
---

资料核对：**2026-10-13**。按核对日官方文档整理；本站未安装技能、接入真实账号或运行浏览器/文件操作测试。旧版本应先查看本机帮助及对应版本文档。

## 开始前

先完成本机模型对话，记录OpenClaw版本与所选Gateway。技能是含SKILL.md的指令目录，可能带脚本、依赖和凭据需求，不是看到名称就能安全执行的功能开关。

```sh
openclaw --version
openclaw skills --help
openclaw skills list
openclaw skills check
```

list/check查询所选Gateway的技能清单；远程Gateway不可用时先解决连接问题，不把客户端目录当成服务端已加载。

## 先核查来源，再安装

查作者、完整技能标识、版本、SKILL.md、辅助脚本和要求的权限。核对日官方文档使用openclaw skills进行安装，ClawHub独立CLI主要用于发布等操作。以下尖括号是占位符，不能原样粘贴，也不推荐未经审查的具体社区技能。

```text
openclaw skills install @owner/<slug> --version <version>
openclaw skills verify @owner/<slug>
```

安装默认面向活动工作区；--global会改变共享范围，应先判断是否需要。扫描通过不能代替读代码和权限审查；不要为绕过失败无条件使用force选项。凭据只写入自己实例要求的位置，不进入聊天、截图或Git。

## 验收与故障处理

用list/info/check确认所选实例发现技能、依赖满足，再用无敏感信息的小任务验证。需要发消息、发布、购买或写文件的技能，先限定实际对象与范围。记录版本和失败信息；不可用时检查Gateway、路径、二进制依赖及允许列表，不一次放开所有权限。

更新前保存技能版本和配置，按当前CLI帮助与官方文档恢复已知可用版本。旧稿的社区数量与未经核查的推荐已撤下，不作为当前目录规模保证。

## 官方依据

- [Skills系统与信任边界](https://docs.openclaw.ai/tools/skills)
- [Skills CLI与版本选项](https://docs.openclaw.ai/cli/skills)
- [七课阅读路线](/openclaw/)
