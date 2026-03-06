---
slug: "nas-power-save"
title: "24/7 运行也不心疼电费：小主机功耗优化策略"
date: 2026-02-12
summary: "调整 CPU 频率与硬盘休眠，每年省下一条内存。"
categories: ["nas"]
---

# 24/7运行也不心疼电费：小主机功耗优化策略


让<a href="/nas/" target="_blank">NAS</a> 24小时开机是很多用户的常态：PT下载需要保种、远程访问需要随时在线、照片备份需要实时同步，智能家居中枢更是不能间断。但随之而来的问题是：电费账单。一台功率50瓦的NUC一年耗电约400度，按居民电价计算就是两三百元。如果同时运行多盘位NAS或额外挂载硬盘，功耗更是成倍增长。

其实，通过合理的功耗优化策略，我们可以将<a href="/nas/" target="_blank">NAS</a>的用电量降低30%-50%，在保持服务可用性的同时，让电费不再是负担。本文将分享从硬件到软件的全方位节能方案，帮助你打造一个"省电"的<a href="/nas/" target="_blank">NAS</a>。

## 硬件层面的功耗基础

功耗优化从硬件选购阶段就已经开始。不同的硬件组合，基础功耗差异可能高达数倍。

**处理器选择**：Intel处理器后缀带"T"的为低功耗版本（TDP通常在35W以内)，而标准版功耗动辄65W以上。以i5-12400和i5-12400T为例，后者基础功耗低了将近一半。如果你的<a href="/nas/" target="_blank">NAS</a>主要用于存储和轻度<a href="/nas/docker-best-practice/" target="_blank">Docker</a>应用，选择低功耗CPU完全够用，<a href="/hardware/" target="_blank">NUC</a>系列更是专为低功耗设计，TDP通常在15W-28W之间。

**存储介质**：机械硬盘（HDD）的功耗约为5-10瓦，而固态硬盘（SSD）仅需2-5瓦。如果你的<a href="/nas/" target="_blank">NAS</a>主要用途不是大容量存储（媒体库、PT下载），使用SSD作为系统盘不仅更快，还能显著降低待机功耗。另外，不建议使用外接USB硬盘作为长期存储方案，因为USB供电不稳定且功耗管理较差。

**电源与机箱**：对于自组<a href="/nas/" target="_blank">NAS</a>，选择高效率的电源（80 PLUS Gold认证以上）可以在长期运行中节省可观电能。钛金级电源虽然更贵，但转换效率可达96%以上，长期使用的电费节省能够弥补差价。

## BIOS层面的节能设置

大多数用户忽略了BIOS中的功耗管理选项。这些设置在默认情况下可能不是最优的，手动调整可以带来明显的节能效果。

**C-States（处理器睡眠状态）**：启用C-States允许处理器在空闲时进入低功耗状态。从C0（完全工作）到C6/C7/C8（深度睡眠），功耗可以降低数瓦。建议在BIOS中启用所有C-States支持。

**Speed Shift（动态频率调节）**：这个技术允许处理器根据负载快速调整频率。与操作系统的电源管理配合，可以实现更精细的功耗控制。在BIOS中确保"Intel Speed Shift Technology"已启用。

**SATA ASPM（PCIe ASPM）**：如果你的硬盘支持ASPM（Active State Power Management），在BIOS中开启可以进一步降低硬盘空闲时的功耗。

---

*更多<a href="/nas/" target="_blank">NAS</a>教程请关注 [NAS学院](/nas/)。*

<div class="page-nav">
  <a href="/hardware/minisforum-ms-01/" rel="prev">上一页：Minisforum MS-01 评测</a>
</div>

*本文由 NUC NAS Hub 自动生成*
