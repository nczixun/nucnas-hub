# 🛠️ NAS 实用脚本合集

> 开源、免费、实用的 NAS 自动化脚本

---

## 📦 脚本列表

| 脚本 | 功能 | 难度 | 平台 |
|------|------|------|------|
| [硬盘健康检测](#硬盘健康检测) | SMART 检测 + 告警 | ⭐⭐ | 全平台 |
| [Docker 批量部署](#docker-批量部署) | 一键部署常用容器 | ⭐⭐ | Docker |
| [自动备份脚本](#自动备份脚本) | 定时备份 + 清理 | ⭐⭐⭐ | Linux |
| [配置导出工具](#配置导出工具) | 系统配置备份 | ⭐⭐ | 群晖/威联通 |
| [远程访问助手](#远程访问助手) | 内网穿透配置 | ⭐⭐⭐ | 全平台 |

---

## 💾 硬盘健康检测

### 功能
- 自动检测所有硬盘 SMART 状态
- 温度监控（超温告警）
- 坏道扫描
- 健康报告生成
- 微信/邮件告警

### 使用
```bash
# 下载脚本
wget https://raw.githubusercontent.com/nczixun/nucnas-hub/main/scripts/smart-check.sh

# 添加执行权限
chmod +x smart-check.sh

# 运行检测
./smart-check.sh

# 定时检测（每天凌晨 3 点）
crontab -e
0 3 * * * /path/to/smart-check.sh
```

### 告警阈值
| 指标 | 警告 | 严重 |
|------|------|------|
| 温度 | >45°C | >55°C |
| 重映射扇区 | >10 | >100 |
| 通电时间 | >30000h | >50000h |
| 启动/停止计数 | >50 | >200 |

---

## 🐳 Docker 批量部署

### 功能
- 一键部署 10+ 常用容器
- 自动创建目录结构
- 配置文件自动生成
- 网络/端口自动配置

### 使用
```bash
# 下载脚本
wget https://raw.githubusercontent.com/nczixun/nucnas-hub/main/scripts/docker-deploy.sh

# 查看可部署的容器
./docker-deploy.sh list

# 部署单个容器
./docker-deploy.sh install jellyfin

# 批量部署
./docker-deploy.sh install jellyfin qbittorrent navidrome

# 全部部署
./docker-deploy.sh install all
```

### 支持容器
| 容器 | 用途 | 端口 |
|------|------|------|
| jellyfin | 媒体服务器 | 8096 |
| qbittorrent | BT 下载 | 8080 |
| navidrome | 音乐服务器 | 4533 |
| nextcloud | 私有云盘 | 8081 |
| homeassistant | 智能家居 | 8123 |
| portainer | 容器管理 | 9000 |
| transmission | PT 下载 | 9091 |
| alist | 网盘挂载 | 5244 |
| emby | 媒体服务器 | 8097 |
| syncthing | 文件同步 | 8384 |

---

## 📁 自动备份脚本

### 功能
- 定时备份指定目录
- 增量备份（节省空间）
- 自动清理旧备份
- 备份完整性校验
- 远程同步（可选）

### 使用
```bash
# 下载脚本
wget https://raw.githubusercontent.com/nczixun/nucnas-hub/main/scripts/auto-backup.sh

# 编辑配置
vim backup-config.conf

# 配置示例
BACKUP_SOURCE="/data/photos /data/documents"
BACKUP_DEST="/backup/daily"
RETENTION_DAYS=30
BACKUP_TIME="02:00"
NOTIFY_EMAIL="your@email.com"

# 运行备份
./auto-backup.sh

# 添加到定时任务
crontab -e
0 2 * * * /path/to/auto-backup.sh
```

### 备份策略
| 类型 | 频率 | 保留时间 | 空间占用 |
|------|------|----------|----------|
| 每日 | 每天 | 7 天 | 中 |
| 每周 | 每周日 | 4 周 | 低 |
| 每月 | 每月 1 号 | 12 月 | 低 |

---

## ⚙️ 配置导出工具

### 功能
- 导出系统配置
- 导出 Docker 配置
- 导出网络设置
- 生成备份包
- 支持导入还原

### 使用
```bash
# 导出配置
./config-export.sh --output backup-20260308.tar.gz

# 导入配置
./config-import.sh --input backup-20260308.tar.gz

# 仅查看配置
./config-export.sh --list
```

### 备份内容
- 系统设置（网络/用户/权限）
- Docker 配置（容器/镜像/卷）
- 共享文件夹设置
- 定时任务
- 应用配置

---

## 🌐 远程访问助手

### 功能
- 自动配置内网穿透
- 支持多种方案（FRP/ZeroTier/Tailscale）
- 自动获取公网 IP
- DDNS 自动更新
- 连接测试

### 使用
```bash
# 下载脚本
wget https://raw.githubusercontent.com/nczixun/nucnas-hub/main/scripts/remote-access.sh

# 查看支持方案
./remote-access.sh list

# 配置 ZeroTier
./remote-access.sh setup zerotier --network-id YOUR_NETWORK_ID

# 配置 FRP
./remote-access.sh setup frp --config frp.ini

# 测试连接
./remote-access.sh test
```

### 支持方案
| 方案 | 难度 | 速度 | 成本 |
|------|------|------|------|
| ZeroTier | ⭐⭐ | 中 | 免费 |
| Tailscale | ⭐⭐ | 快 | 免费 |
| FRP | ⭐⭐⭐⭐ | 快 | 服务器成本 |
| 公网 IP+DDNS | ⭐⭐⭐ | 最快 | 免费 |

---

## 📥 安装脚本

### 一键安装所有脚本
```bash
# 下载安装器
wget https://raw.githubusercontent.com/nczixun/nucnas-hub/main/scripts/install.sh

# 运行安装
chmod +x install.sh
./install.sh

# 选择安装
./install.sh --selective

# 查看帮助
./install.sh --help
```

### 安装目录
```
/usr/local/bin/nas-scripts/
├── smart-check.sh
├── docker-deploy.sh
├── auto-backup.sh
├── config-export.sh
└── remote-access.sh
```

---

## 🔧 脚本配置

### 全局配置文件
```bash
# /etc/nas-scripts/config.conf

# 通知设置
NOTIFY_ENABLE=true
NOTIFY_METHOD="wechat"  # wechat/email/dingtalk
NOTIFY_RECEIVER="your_id"

# 日志设置
LOG_LEVEL="info"  # debug/info/warning/error
LOG_DIR="/var/log/nas-scripts"

# 代理设置（可选）
PROXY_ENABLE=false
PROXY_URL="http://proxy:7890"
```

---

## 🐛 常见问题

### Q: 脚本运行报错
**A**: 检查权限 `chmod +x script.sh`，确认依赖已安装

### Q: 定时任务不执行
**A**: 检查 cron 服务 `systemctl status cron`，查看日志

### Q: Docker 容器启动失败
**A**: 检查端口冲突 `docker ps`，查看容器日志

### Q: 备份占用空间过大
**A**: 调整保留时间，启用压缩 `tar -zcf`

---

## 📞 反馈与支持

- **GitHub Issues**: https://github.com/nczixun/nucnas-hub/issues
- **邮箱**: feedback@nucnas.top
- **讨论区**: https://nucnas.top/forum/scripts/

---

## 📄 许可证

MIT License - 自由使用、修改、分发

---

*最后更新：2026-03-08 | 版本：v1.0.0*
