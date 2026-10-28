---
reviewedAt: "2026-10-28"
contentStatus: "reviewed"
title: "Ollama 本地模型入门：安装、运行和离线检查"
date: 2026-03-05
draft: false
description: "从安装 Ollama、运行一个本地模型，到确认云功能开关和离线检查步骤。"
tags: ["AI", "大模型", "Ollama", "本地部署", "新手入门", "DeepSeek"]
categories: ["AI"]
featured_image: ""
sticky: false
unversioned: false
author: "NUCNAS"
slug: "ollama-beginner-guide-2026"
lastmod: 2026-10-28
---

跟着这份指南，你可以在自己的电脑运行一个 Ollama 本地模型，并检查云功能是否关闭。文中的命令和设置按 Ollama 官方文档整理。

## 先确认你要运行什么

Ollama 可以管理和运行模型；本地模型的计算发生在自己的设备上，云模型则需要远端服务。不能仅凭界面里出现“Ollama”就判断数据去向。以下示例调用本地模型，不需要模型 API 密钥。

记录操作系统及架构、内存、显卡和显存、可用磁盘空间。模型文件大小不等于运行内存；上下文长度、量化和并发也会影响资源占用。先用小模型确认流程，不能据此推断大模型的速度。软件、模型各有许可证，设备、电力和存储也有成本，“本地”不等于无限免费。

## 安装与第一次对话

从 [Ollama 官方下载页](https://ollama.com/download)选择自己的系统。Windows/macOS 使用对应安装程序；Linux 按[官方安装说明](https://docs.ollama.com/linux)操作，执行下载脚本前先阅读内容与所需权限。不要把网上任意脚本当成官方安装器。

安装后重新打开终端，检查版本。下列命令适用于已经安装并启动 Ollama 的终端；若 Linux 服务尚未启动，按官方说明启动，手动运行时可用 `ollama serve`，不要重复启动占用同一端口。

```sh
ollama --version
ollama pull qwen3:0.6b
ollama ls
ollama run qwen3:0.6b
```

这里使用已核对存在的 [qwen3:0.6b 模型标签](https://ollama.com/library/qwen3:0.6b)作为小规模流程示例，并非模型质量或硬件购买推荐。首次下载需要网络与磁盘空间；若版本提示不支持模型，先查模型页与软件更新说明。

在交互界面输入一个不含个人信息的问题，例如“用三句话解释文件备份”；读完回答后输入 `/bye` 退出。退出交互窗口不一定立即卸载内存中的模型。

```sh
ollama ps
ollama stop qwen3:0.6b
```

`ls` 查看本地模型，`ps` 查看当前加载状态，`stop` 卸载指定运行模型。第二次运行同一标签应能使用已下载模型；记录 Ollama 版本、完整模型标签和实际结果。命令含义见 [CLI 文档](https://docs.ollama.com/cli)。

## 如何验证本地与离线使用

要让 Ollama 进入仅本地模式，可以在 `~/.ollama/server.json` 设置 `"disable_ollama_cloud": true`，也可以设置 `OLLAMA_NO_CLOUD=1`。修改后重启 Ollama；官方 FAQ 说明日志会显示 `Ollama cloud disabled: true`。关闭云功能会同时停用云模型和 Ollama 网页搜索。设置要应用到实际运行 Ollama 的服务或应用；只在另一个终端设置变量不会改变已启动的进程。不同系统的环境变量设置方法见 [官方 FAQ](https://docs.ollama.com/faq)。Ollama 默认绑定本机回环地址，不要把 11434 端口直接映射到公网。

先联网下载所需模型，再关闭外部工具与云选项，断开外网重做自己的测试任务。记录是否成功，以及日志中的云功能关闭状态。这只能验证所测流程：其他聊天前端、插件、网页搜索或远程模型仍需分别检查。日志和聊天记录也可能保存在本机，仍需访问控制与备份。

## 常见失败与下一步

| 现象 | 优先检查 |
| --- | --- |
| 找不到 ollama 命令 | 安装是否完成、终端是否重新打开、可执行文件路径 |
| 无法连接服务 | 应用/服务是否启动、默认 11434 端口是否被占用；先别扩大监听地址 |
| 模型不存在或下载失败 | 完整标签、模型页、网络代理及磁盘空间 |
| 运行很慢或内存不足 | 减小模型和上下文、关闭额外并发，观察系统资源；不要照搬网上速度数字 |
| 回答错误 | 回查原始资料；小模型能运行不代表答案可靠 |

先保留版本与模型记录，再按照官方方式升级；升级前保留重要配置和模型清单。不要为了修复连接问题直接删除整个模型目录。

完成标准：能再次运行同一模型、说明数据处理位置，并记录一项成功与一项失败情况。需要浏览器界面时继续 [Open WebUI 教程](/ai/ollama-openwebui/)；需要文档问答时继续 [本地知识库样例](/ai/local-ai-knowledge-base-guide/)。

官方步骤入口：[快速开始](https://docs.ollama.com/quickstart)。[返回本地 AI 阅读路线](/local-ai-roadmap/)。
