---
title: "NAS数据迁移全攻略：换机不换数据"
date: 2026-03-18
categories: ["NAS"]
tags: ["NAS迁移", "数据迁移", "换机", "NAS教程"]
description: "详解NAS数据迁移的多种方案，从单盘到多盘，从同系统到跨系统全覆盖。"
keywords: ["NAS数据迁移", "NAS换机", "数据迁移", "NAS备份"]
author: "NUC NAS Hub"
---

# NAS数据迁移全攻略：换机不换数据

## 何时需要迁移NAS？

- 升级硬件（从N100升级到8845HS）
- 换新NAS设备
- 系统从Unraid迁移到TrueNAS
- 从白群晖换到DIY NAS

## 迁移方案总览

| 方案 | 停机时间 | 复杂度 | 数据完整性 |
|------|----------|--------|------------|
| 硬盘直连 | 短 | 低 | 高 |
| 网络传输 | 中 | 中 | 高 |
| 备份恢复 | 长 | 中 | 高 |
| 镜像迁移 | 短 | 高 | 高 |

## 方案一：硬盘直连（推荐）

### 适用场景
- 主板坏了，只迁移数据
- 同品牌NAS换代
- 盘位数量相同

### 操作步骤

1. **记录原NAS配置**
   - 记录RAID/存储池信息
   - 记录所有服务配置
   - 导出Docker-compose文件

2. **物理连接硬盘**
   - 将旧NAS的硬盘直接连接到新NAS
   - 如果盘位不够，可以使用USB外接盒

3. **导入存储池**
   - Unraid：在Unraid UI中选择"Import Disk"
   - TrueNAS：在Storage > Import中导入
   - FNOS/GeaKos：系统会自动识别

### 注意事项
- 硬盘顺序不要改变
- 先只接系统盘，启动后再接数据盘
- 务必确认原阵列健康后再操作

## 方案二：网络传输

### 适用场景
- 两台NAS同时运行
- 不方便物理移动硬盘
- 需要增量同步

### rsync同步

```bash
# 在新NAS上执行
rsync -avz --progress \
  -e "ssh -p 22" \
  user@old-nas:/mnt/user/data/ \
  /mnt/user/data/
```

参数说明：
- `-a`：归档模式，保留权限
- `-v`：显示详细进度
- `-z`：压缩传输
- `--progress`：显示进度

### 增量同步技巧

```bash
# 首次同步后，后续使用增量同步
rsync -avz --delete \
  -e "ssh -p 22" \
  user@old-nas:/mnt/user/data/ \
  /mnt/user/data/
```

## 方案三：备份恢复

### 完整备份流程

1. **备份配置**
   ```bash
   # 导出Docker配置
   docker-compose config > docker-compose.yml
   
   # 导出NAS设置
   # 各系统有对应的导出工具
   ```

2. **备份数据**
   ```bash
   # 使用tar打包
   tar -czvf nas-backup.tar.gz /mnt/user/data/
   
   # 使用restic增量备份
   restic -r /backup/repo backup /mnt/user/data/
   ```

3. **在新NAS恢复**
   ```bash
   # 解压恢复
   tar -xzvf nas-backup.tar.gz -C /
   
   # 使用restic恢复
   restic -r /backup/repo restore latest --target /
   ```

### 推荐备份工具

| 工具 | 类型 | 特点 |
|------|------|------|
| Restic | 增量备份 | 去重、加密 |
| Borg | 增量备份 | 高效、压缩 |
| Duplicati | Web UI | 界面友好 |
| UrBackup | 镜像备份 | 完整系统备份 |

## 方案四：跨系统迁移

### Unraid → TrueNAS

1. 在TrueNAS中创建新存储池
2. 使用rsync从Unraid同步数据
3. 重新部署Docker容器
4. 验证数据完整性

### 群晖 → DIY NAS

1. 导出群晖配置
2. 使用Hyper Backup备份数据
3. 在新系统恢复
4. 重新配置服务

### PVE → FNOS

1. 导出PVE虚拟机配置
2. 将虚拟磁盘文件复制到新NAS
3. 在FNOS中创建对应虚拟机
4. 调整网络和存储配置

## 迁移检查清单

### 迁移前
- [ ] 确认原NAS数据完整
- [ ] 记录所有服务配置
- [ ] 准备备份介质
- [ ] 检查新NAS硬件

### 迁移中
- [ ] 先备份再操作
- [ ] 保持硬盘顺序
- [ ] 记录重要配置

### 迁移后
- [ ] 验证数据完整性
- [ ] 测试所有服务
- [ ] 更新内网IP/域名
- [ ] 检查健康状态

## 常见问题

### 问题1：硬盘不识别

**解决**：检查硬盘格式，Linux可能需要安装对应驱动

### 问题2：权限丢失

**解决**：使用 `-a` 参数保留权限，或迁移后重新设置

### 问题3：Docker容器无法启动

**解决**：检查网络配置，重新拉取镜像

## 总结

数据迁移的核心是**先备份再操作**。推荐硬盘直连方案，停机时间最短。如果需要跨系统迁移，rsync网络传输是最安全的选择。

**相关文章**：
- [DIY NAS配置推荐](/nas/diy-nas-config-recommend-2026)
- [NAS备份最佳实践](/nas/nas-backup-best-practice-2026)
