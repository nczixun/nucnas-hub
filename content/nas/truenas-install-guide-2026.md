---
title: "TrueNAS 安装教程：从零搭建专业级 NAS 系统"
date: 2026-03-07
categories: ["nas"]
brand: "TrueNAS"
model: "Scale"
slug: "truenas-install-guide-2026"
---

# TrueNAS 安装教程：从零搭建专业级 NAS 系统

想搭建专业级 NAS？**TrueNAS Scale** 是最佳选择。基于 Linux 的开源 NAS 系统，支持 ZFS 文件系统、Docker 容器、虚拟机，完全免费。

这篇文章手把手教你从零安装 TrueNAS，搭建属于你的专业存储服务器。


## 一、TrueNAS 是什么？

TrueNAS 是企业级开源 NAS 系统，分为两个版本：

| 版本 | 基础系统 | 适合场景 |
| :--- | :--- | :--- |
| **TrueNAS Core** | FreeBSD | 传统 NAS 存储 |
| **TrueNAS Scale** | Linux Debian | Docker、虚拟机、现代应用 |

**推荐选择 Scale 版本**，原因：
- 支持 Docker 容器（Kubernetes）
- 硬件兼容性更好
- 社区更活跃
- 适合家庭 All-in-One 场景


## 二、硬件要求

### 2.1 最低配置

| 组件 | 要求 |
| :--- | :--- |
| CPU | 64 位双核处理器 |
| 内存 | 8GB（推荐 16GB+） |
| 系统盘 | 120GB SSD（单独） |
| 数据盘 | 任意容量 HDD/SSD |
| 网络 | 1G 网口（推荐 2.5G） |

### 2.2 推荐配置

| 组件 | 推荐 |
| :--- | :--- |
| CPU | Intel N100/N305 或 AMD 5800U+ |
| 内存 | 32GB DDR4/DDR5 |
| 系统盘 | 256GB NVMe SSD |
| 数据盘 | 4×4TB NAS 硬盘（组 RAID） |
| 网络 | 双 2.5G 网口 |

> ⚠️ **重要：** ZFS 对内存需求较高，每 1TB 存储建议配 1GB 内存。


## 三、安装步骤

### 3.1 下载镜像

1. 访问官网：https://www.truenas.com/download-truenas-scale/
2. 选择最新稳定版（2026 年推荐 24.04+）
3. 下载 ISO 镜像（约 3GB）

### 3.2 制作启动盘

**Windows 用户：**
```bash
# 使用 Rufus（推荐）
1. 插入 U 盘（8GB+）
2. 打开 Rufus
3. 选择 TrueNAS ISO
4. 点击"开始"写入
```

**Linux/Mac 用户：**
```bash
# 使用 dd 命令
sudo dd if=TrueNAS-24.04.iso of=/dev/sdX bs=4M status=progress
```

### 3.3 安装系统

1. **启动安装**
   - 插入 U 盘，从 U 盘启动
   - 选择"Boot TrueNAS Scale"

2. **选择安装盘**
   - 选择系统盘（SSD）
   - ⚠️ 注意：不要选到数据盘！

3. **设置密码**
   - 设置 root 管理员密码
   - 建议 12 位以上，包含大小写和数字

4. **等待安装**
   - 安装过程约 5-10 分钟
   - 完成后自动重启

5. **移除 U 盘**
   - 重启时拔掉 U 盘
   - 系统从 SSD 启动


## 四、初始配置

### 4.1 访问 Web 界面

1. 查看屏幕显示的 IP 地址（如：192.168.1.100）
2. 浏览器访问：`https://192.168.1.100`
3. 使用 root 账号登录

### 4.2 创建存储池

1. 进入 **Datasets** 页面
2. 点击 **Create Pool**
3. 命名存储池（如：tank）
4. 选择硬盘（建议至少 2 块组镜像）
5. 选择 RAID 类型：
   - **Mirror**：2 块盘镜像，安全
   - **RAIDZ1**：3 块盘以上，允许 1 块故障
   - **RAIDZ2**：4 块盘以上，允许 2 块故障

### 4.3 创建共享

**SMB 共享（Windows 访问）：**
1. 进入 **Shares** → **SMB**
2. 点击 **Add**
3. 选择路径（如：/mnt/tank/share）
4. 设置权限
5. 保存

**NFS 共享（Linux/Mac 访问）：**
1. 进入 **Shares** → **NFS**
2. 点击 **Add**
3. 选择路径
4. 设置访问权限
5. 保存


## 五、Docker 应用部署

TrueNAS Scale 支持一键部署常用应用：

1. 进入 **Apps** 页面
2. 点击 **Discover Apps**
3. 搜索并安装：
   - **Jellyfin**：媒体服务器
   - **QBittorrent**：下载工具
   - **Nextcloud**：私有云盘
   - **Home Assistant**：智能家居

**以 Jellyfin 为例：**
```yaml
# 配置要点
- 媒体库路径：/mnt/tank/media
- 转码硬件加速：开启（Intel QuickSync）
- 网络模式：Host
```


## 六、常见问题解决

### Q1: 无法访问 Web 界面？
A：检查网络连接，确认 IP 地址正确。尝试 ping 测试。

### Q2: 硬盘识别不到？
A：检查 SATA 线连接，进入 BIOS 确认硬盘模式为 AHCI。

### Q3: 内存不足警告？
A：ZFS 需要较多内存，建议升级到 16GB+。

### Q4: 如何备份配置？
A：进入 **System Settings** → **Manage Config** → **Download Config**。

### Q5: 支持休眠吗？
A：支持，进入 **System Settings** → **Power Management** 设置。


## 七、优化建议

### 7.1 性能优化
- 启用 SSD 缓存（L2ARC）
- 调整 ZFS ARC 大小
- 开启压缩（lz4 算法）

### 7.2 安全加固
- 修改默认 SSH 端口
- 启用防火墙
- 定期更新系统
- 创建普通用户，减少 root 使用

### 7.3 备份策略
- 启用快照（每小时/每天）
- 配置远程备份（另一台 NAS 或云存储）
- 重要数据 3-2-1 备份原则


## 八、总结

TrueNAS Scale 是**功能强大、完全免费**的专业 NAS 系统。虽然学习曲线稍陡，但一旦掌握，可以搭建出媲美企业级的存储服务器。

**适合人群：**
- 想深入学习 NAS 技术的玩家
- 需要 Docker、虚拟机功能的用户
- 追求数据安全的家庭用户
- 有旧硬件想利用的用户

**关键词：** TrueNAS、NAS 安装、ZFS 文件系统、Docker NAS、私有云搭建、家庭服务器、开源 NAS
