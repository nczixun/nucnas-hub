---
title: "NAS 存储方案：SHR、RAID5、RAID10 怎么选？"
date: 2026-03-07
categories: ["nas"]
brand: "存储方案"
model: "RAID 配置"
slug: "nas-storage-solution-raid-comparison-2026"
---

# NAS 存储方案：SHR、RAID5、RAID10 怎么选？

硬盘都买好了，存储模式选错了会后悔。

**各模式对比：**

| 模式 | 可用容量 | 安全性 | 写入性能 | 适用场景 |
| :--- | :--- | :--- | :--- | :--- |
| SHR | N-1 盘 | 允许 1 盘故障 | 中 | 群晖用户首选 |
| RAID 5 | N-1 盘 | 允许 1 盘故障 | 中 | 追求性价比 |
| RAID 10 | N/2 盘 | 允许 2 盘故障 | 高 | 追求性能 |
| JBOD | 全部 | 无保护 | 高 | 临时存储 |

**实测数据：**

- 4 块 8TB 硬盘：
  - SHR 可用：约 21TB
  - RAID 5 可用：约 21TB
  - RAID 10 可用：约 14TB

**建议：**
- 家用 NAS：优先选 **SHR**（群晖）或 **RAID 5**
- 重要数据：加一块 **冷备硬盘** 比 RAID 更靠谱
