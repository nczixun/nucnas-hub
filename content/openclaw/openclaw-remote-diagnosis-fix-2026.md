---
title: "OpenClaw 远程诊断与修复：解决 Gateway 服务停止问题"
date: 2026-03-10
categories: ["教程"]
summary: "详细记录 OpenClaw 远程诊断过程，包含 Gateway 服务重启和安全审计修复"
image: "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg"
imageCredit: "Pexels"
---

# OpenClaw 远程诊断与修复全记录

> 本文详细记录了远程协助用户诊断 OpenClaw 异常的全过程，包括问题发现、原因分析和解决方案。

## 一、问题描述

用户报告另一台 Linux 服务器上的 OpenClaw 出现异常，需要远程诊断修复。

**目标服务器信息：**
- IP 地址：192.168.2.201
- SSH 端口：2202
- 系统：Linux (node 22.22.0)
- OpenClaw 版本：2026.3.8

## 二、诊断过程

### 2.1 获取系统状态

首先通过 SSH 连接到服务器，执行状态检查命令：

```bash
openclaw status
```

### 2.2 状态输出分析

```
┌─────────────────┬──────────────────────────────────────────────────────────────────────┐
│ Item            │ Value                                                                │
├─────────────────┼──────────────────────────────────────────────────────────────────────┤
│ Gateway         │ local · ws://127.0.0.1:18789 · reachable 17ms                      │
│ Gateway service │ systemd installed · enabled · stopped (state inactive)              │
│ Agents          │ 1 · sessions 2                                                      │
│ Memory          │ 0 files · cache on                                                  │
│ Feishu          │ ON · OK · configured                                                │
└─────────────────┴──────────────────────────────────────────────────────────────────────┘
```

### 2.3 发现的问题

#### 问题 1：Gateway 服务已停止

```
Gateway service: systemd installed · enabled · stopped (state inactive)
```

**影响：** Gateway 服务虽然设为开机自启，但当前处于停止状态。虽然本地访问正常，但远程访问可能受限。

#### 问题 2：安全审计警告

```
Summary: 5 critical · 5 warn · 1 info
```

**严重警告包括：**
1. Control UI 允许来源包含通配符 "*"
2. Host-header 源回退被启用（危险）
3. Feishu 群组策略为 "open"（存在安全风险）

## 三、修复步骤

### 3.1 重启 Gateway 服务

```bash
# 重启 Gateway 服务
sudo openclaw gateway restart

# 检查服务状态
sudo openclaw gateway status

# 设置开机自启
sudo systemctl enable openclaw-gateway
```

### 3.2 安全审计修复

#### 修复 1：限制 Control UI 允许来源

编辑配置文件：

```bash
# 找到配置文件位置
find ~/.openclaw -name "*.toml" | head -5
```

修改 `gateway.controlUi.allowedOrigins`：

```toml
[gateway.controlUi]
allowedOrigins = ["https://your-domain.com"]  # 替换为实际域名
dangerouslyAllowHostHeaderOriginFallback = false
```

#### 修复 2：调整 Feishu 群组策略

```toml
[channels.feishu]
groupPolicy = "allowlist"  # 从 "open" 改为 "allowlist"
```

### 3.3 验证修复

```bash
# 重新运行安全审计
openclaw security audit

# 检查 Gateway 状态
openclaw gateway status
```

## 四、预防措施

### 4.1 定期检查

建议添加定时任务定期检查 OpenClaw 状态：

```bash
# 添加到 crontab
crontab -e

# 每天早上 9 点检查状态
0 9 * * * /usr/local/bin/openclaw gateway status >> /var/log/openclaw-check.log
```

### 4.2 日志监控

设置日志监控，及时发现异常：

```bash
# 监控错误日志
tail -f /var/log/openclaw.log | grep -i error
```

### 4.3 自动重启

创建 systemd 自动恢复服务：

```bash
sudo systemctl edit openclaw-gateway
```

添加：

```ini
[Service]
Restart=always
RestartSec=10
```

## 五、常见问题排查

### Q1：Gateway 无法启动

```bash
# 查看详细错误日志
sudo journalctl -u openclaw-gateway -n 50

# 检查端口占用
sudo lsof -i :18789

# 检查配置文件语法
openclaw configure --validate
```

### Q2：Feishu 连接失败

```bash
# 测试 Feishu 连接
openclaw status --deep

# 检查 Feishu 配置
cat ~/.openclaw/config.toml | grep -A 10 feishu
```

### Q3：内存不足

```bash
# 清理缓存
openclaw memory --clear

# 清理旧会话
rm -rf ~/.openclaw/agents/*/sessions/*.jsonl
```

## 六、总结

本次远程诊断发现的主要问题是 **Gateway 服务意外停止**，以及若干安全配置需要优化。通过以下命令可以快速修复：

```bash
# 一键重启 Gateway
sudo openclaw gateway restart

# 重新运行安全审计
openclaw security audit
```

**关键提醒：**
- 定期检查 Gateway 服务状态
- 关注安全审计警告
- 做好配置备份

---

*本文由 NUC NAS Hub 自动生成*
