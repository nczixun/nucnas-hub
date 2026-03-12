---
title: "GEAKOS 7 天入门教程：第 5 天 - 文件管理与 SMB 共享"
date: 2026-03-12
categories: ["NAS"]
summary: "GEAKOS 7天教程第5天：文件管理、SMB共享、网盘挂载，避坑必看！"
image: "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800"
tags: ["NAS", "GEAKOS", "私有云", "教程", "7天入门"]
series: ["GEAKOS 7天教程"]
---

# GEAKOS 7 天入门教程：第 5 天 - 文件管理与 SMB 共享

![文件管理](https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=800)

## 回顾

第 4 天我们完成了客户端安装和远程访问配置。今天将学习**文件管理**和**SMB 共享**。

---

## 第 5 天：文件管理

### 1. 基础文件操作

在 GEAKOS 管理界面可以：
- 创建文件夹
- 上传/下载文件
- 复制/移动/删除
- 预览图片/视频

### 2. SMB 共享设置

**步骤：**

1. 打开 GEAKOS 管理界面
2. 进入「文件共享」或「SMB」
3. 创建共享文件夹
4. 设置访问权限

**SMB 地址：**

```
\\192.168.x.x\共享名称
```

### 3. 挂载网盘

支持挂载：
- SMB
- WebDAV
- NFS
- 阿里云盘
- Google Drive

---

## ⚠️ 避坑指南

> **坑 1**：SMB 访问建议使用固定的静态 IP
> 
> **坑 2**：不要给所有人都开放读写权限
> 
> **坑 3**：网盘挂载会占用NAS带宽，注意网络环境

---

## 第 5 天任务清单

- [ ] 创建共享文件夹
- [ ] 配置 SMB 访问
- [ ] 在电脑上测试访问
- [ ] 挂载网盘（可选）

---

## 明天预告

第 6 天我们将学习**影视中心**配置，打造家庭影院！

---

*本文是 GEAKOS 7 天教程系列第 5 篇*
*作者：NUC NAS Hub*
