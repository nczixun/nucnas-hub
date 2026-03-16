---
title: "OpenClaw保姆级教程（基础篇）：从安装到配置完全指南"
date: 2026-03-16
categories: ["ai"]
summary: "OpenClaw基础教程：本地AI网关的安装、配置、模型选择、网络代理完整指南。最低30元/月用上自己的AI助手。"
tags: ["OpenClaw", "AI工具", "Telegram", "教程", "安装配置"]
slug: "openclaw-beginner-tutorial"
description: "OpenClaw保姆级教程基础篇：Gateway架构、硬件要求、模型API选择、Telegram/Discord配置、网络代理设置、常见问题排查。最低30元/月用上自己的AI助手。"
---

# OpenClaw保姆级教程（基础篇）：从安装到配置完全指南

> 这是OpenClaw教学第一篇，之后会出中高阶详细用法

---

## 一、搞清楚OpenClaw到底是什么

**OpenClaw本质上是一个本地运行的AI网关。**

它的架构很简单：
1. 你的电脑跑一个Gateway进程（理解为中转站）
2. Gateway连接你的聊天软件（Telegram/Discord/WhatsApp）
3. Gateway再连接AI模型（Claude/GPT/DeepSeek）
4. 你在Telegram发消息 → Gateway转给AI → AI回复转回Telegram

### 为什么要这么设计？

因为大部分AI服务（Claude、GPT）都没有直接提供Telegram机器人，你要么用网页版，要么用App。

但OpenClaw让你可以在**任何聊天软件里和AI对话**，而且所有记忆、配置都存在你自己电脑上（`~/.openclaw/`），**没有隐私泄露风险**。

---

## 二、前期准备

### 1. 硬件与系统要求

| 系统 | 要求 |
|------|------|
| Mac | 最省心，原生支持 |
| Windows | 必须装WSL2，建议Ubuntu 22.04 |
| Linux | 直接开干 |

**如果想24小时挂机，建议：**
- Mac Mini（最省电，官方推荐）
- 云服务器VPS（DigitalOcean 12美元/月起）

### 2. 大模型API准备

OpenClaw支持几乎所有主流模型，但需要提前准备好API Key。

**推荐方案对比：**

| 方案 | 成本 | 评分 | 说明 |
|------|------|------|------|
| ChatGPT Plus订阅 | $20/月 | ⭐⭐⭐⭐⭐ | 官方白名单支持，最省心 |
| 阿里云百炼Coding Plan | ¥100-200/月 | ⭐⭐⭐⭐⭐ | 国内稳定，通义千问Qwen3-Max |
| OpenRouter | ~$3-15/天 | ⭐⭐⭐⭐ | 按量付费，多模型切换 |
| AI/ML API | 按量付费 | ⭐⭐⭐⭐ | OpenClaw官方集成伙伴 |
| Kimi K2.5 | 按量付费 | ⭐⭐⭐⭐ | 月之暗面积极支持 |
| 中转站 | 便宜 | ⭐⭐⭐ | 不稳定，风险高 |
| Ollama本地模型 | 免费 | ⭐⭐⭐ | 效果差，适合学习 |

**我的建议：**
- 新手先用OpenRouter或AI/ML API，按量付费
- 确定长期使用，再上ChatGPT订阅
- 千万别一上来就搞中转站，出问题了你都不知道是模型问题还是配置问题

### 3. 翻墙环境（重要）

Telegram和Discord都需要翻墙才能连接。

你需要：
- Clash Verge / Clash for Windows / Surge
- 一个稳定的机场节点
- **开启TUN模式**（很多人忘了，不开TUN模式终端走不了代理）

**验证方法：**
```bash
curl -I https://api.telegram.org
```
如果返回200，说明终端能访问Telegram API。

---

## 三、正式安装

### Step 1: 安装Homebrew和Node.js

打开终端，先装Homebrew：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

装完后安装Node.js：
```bash
brew install nodejs
```

验证安装：
```bash
node --version  # 应该显示 v22.x.x 或更高
npm --version
```

> 重要：OpenClaw要求Node.js版本≥22

### Step 2: 安装OpenClaw

推荐方式（官方向导）：
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

这个脚本会自动帮你：
- 安装OpenClaw CLI工具
- 创建配置目录（`~/.openclaw/`）
- 设置环境变量

安装完成后验证：
```bash
openclaw --version
```

### Step 3: 启动配置向导

这是最关键的一步：
```bash
openclaw onboard --install-daemon
```

`--install-daemon`参数会让OpenClaw在后台持续运行，即使重启电脑也会自动启动。

---

## 四、配置流程

### 4.1 选择AI模型提供商

向导会列出：OpenAI、kimi等。

- 如果有官方账号：直接选对应的，跳转浏览器授权
- 如果用第三方API：选择Skip（后面手动配置）

### 4.2 选择聊天平台

| 平台 | 特点 |
|------|------|
| Telegram（⭐推荐） | 配置最简单，3分钟搞定，无需审核 |
| WhatsApp | QR code登录 |
| Discord | 适合团队协作，配置约10分钟 |
| Slack | - |

**为什么推荐Telegram：**
- 配置最简单（3分钟搞定）
- Bot创建无需审核
- 支持长消息和文件传输
- 有完整的Bot管理面板

### 4.3 创建Telegram Bot

1. 打开Telegram，搜索[@BotFather](https://t.me/BotFather)
2. 发送`/start`开始对话
3. 按顺序发送：
   - `/newbot`（创建新机器人）
   - 输入Bot显示名称（如：我的AI助手）
   - 输入Bot用户名（必须以`_bot`结尾，如：`ai_helper_bot`）

成功后，BotFather会返回一个Token：
```
1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
```

复制这个Token，回到终端粘贴进去。

### 4.4 完成初始配置

向导会问你要不要安装Skills（技能插件），如Web搜索、邮件管理、日历同步等。

**新手建议先跳过**，等基础功能跑通了再慢慢加。

配置完成后，向导会自动启动Gateway：
```
✓ Gateway started on http://127.0.0.1:18789
✓ Telegram channel connected
✓ Ready to chat!
```

---

## 五、配置第三方AI模型

如果在4.1选择了Skip，现在需要手动配置模型。

### 方法1: 通过Web UI配置（推荐）

1. 打开浏览器访问：`http://127.0.0.1:18789`
2. 点击Settings → Models → Add Provider
3. 填入API信息：
   - Provider Name: 自定义（如openrouter）
   - Base URL: API地址
   - API Key: 你的密钥
   - Model ID: 具体模型名

### 方法2: 直接编辑配置文件

```bash
nano ~/.openclaw/openclaw.json
```

找到`models.providers`部分，添加：
```json
{
  "models": {
    "providers": {
      "openrouter": {
        "baseUrl": "https://openrouter.ai/api/v1",
        "apiKey": "your-api-key-here",
        "api": "openai-completions",
        "models": [
          {
            "id": "anthropic/claude-opus-4",
            "name": "Claude Opus 4",
            "reasoning": true
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "openrouter/anthropic/claude-opus-4"
      }
    }
  }
}
```

保存后重启：
```bash
openclaw restart
```

---

## 六、配置网络代理

很多人配完发现Bot不回消息，大概率是代理没配对。

### 确认代理端口

打开Clash Verge，查看：
- HTTP端口（一般是7890）
- SOCKS5端口（一般是7891）

### 设置环境变量

编辑shell配置文件：
```bash
# 如果用zsh
nano ~/.zshrc

# 如果用bash
nano ~/.bashrc
```

在文件末尾添加：
```bash
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7891
```

保存后重新加载：
```bash
source ~/.zshrc
```

重启OpenClaw:
```bash
openclaw restart
```

### 验证代理

在Telegram给Bot发消息：`帮我搜索一下OpenClaw的最新更新`

如果能返回结果，说明代理配置成功。

---

## 七、进阶配置

### 7.1 配置个性化SOUL

OpenClaw支持自定义AI的性格和行为规则。

```bash
nano ~/.openclaw/workspace/SOUL.md
```

写入你的要求：
```markdown
# 我的AI助手人格设定

- 称呼我为「老板」
- 回复风格：简洁专业，不说废话
- 擅长领域：产品设计、技术架构、内容创作
- 禁止事项：不要主动闲聊，不要说「很抱歉」这种客套话
```

### 7.2 安全配置（必须做）

1. **限制API花费上限**：在API提供商后台设置每日/每月预算
2. **开启敏感操作确认**：
```json
{
  "tools": {
    "exec": {
      "enabled": true,
      "approvalRequired": true
    },
    "email": {
      "enabled": true,
      "approvalRequired": true
    }
  }
}
```
3. **不要把OpenClaw暴露到公网**：Gateway默认监听127.0.0.1:18789

---

## 八、常见问题排查

### 问题1: Bot不回消息

```bash
# 1. 检查Gateway是否运行
openclaw status

# 2. 查看日志
openclaw logs --tail 50

# 3. 测试模型连接
openclaw agent --message "测试" --thinking high
```

| 错误 | 原因 |
|------|------|
| ECONNREFUSED / timeout | 网络代理问题 |
| 401 Unauthorized | API Key错误 |
| rate limit | API额度用完 |

### 问题2: 端口被占用

```bash
# 找到占用端口的进程
lsof -i :18789

# 杀掉进程
kill -9 <PID>

# 重启OpenClaw
openclaw restart
```

### 问题3: Telegram配对失败

```bash
# 查看配对码
openclaw pairing list

# 手动批准配对
openclaw pairing approve telegram <你的Telegram User ID>
```

你的User ID可以在Telegram搜索[@userinfobot](https://t.me/userinfobot)获取。

---

## 九、成本与选择建议

| 方案 | 成本 | 说明 |
|------|------|------|
| 最低成本 | ~30元/月 | Ollama本地模型 + Telegram |
| 性价比方案 | ~150元/月 | OpenRouter按量付费 + VPS |
| 土豪方案 | 1000元+/月 | 官方API + Mac Mini |

**建议**：先用性价比方案跑1-2周，确定自己真的会用，再考虑升级。

---

## 十、写在最后

OpenClaw的核心价值不是「又一个AI聊天工具」，而是把AI从「打开浏览器→登录→对话→复制结果」这个流程，缩短到**「在Telegram发一条消息」**。

这就是超级个体需要的生产力工具：无缝、随时、记忆连续。

**目前的问题：**
- 更新太快，文档跟不上
- Skills质量参差不齐
- 配置复杂度对小白不太友好

但这些都不妨碍它成为2026年最值得折腾的开源项目。

遇到问题不要急着放弃，善用Claude Code或者直接在GitHub提Issue。**技术永远是为人服务的，搞不定就让AI帮你搞定。**
