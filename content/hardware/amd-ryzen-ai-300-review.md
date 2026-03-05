---
title: "AMD Ryzen AI 300 首发测评：迷你主机进入 AI 时代"
date: 2026-03-03
categories: ["hardware"]
summary: "AMD 全新 Ryzen AI 300 系列处理器专为 AI PC 设计，集成 XDNA 2 架构 NPU，提供 50TOPS 算力。本文首发测评告诉你这款处理器在迷你主机上的实际表现。"
image: "https://images.pexels.com/photos/1181248/pexels-photo-1181248.jpeg"
imageCredit: "Pexels"
---

# AMD Ryzen AI 300 首发测评：迷你主机进入 AI 时代

AMD 这次真没开玩笑。全新 Ryzen AI 300 系列来了，50TOPS 的 NPU 算力，直接把 Intel 按在地上摩擦。

首批面向消费级迷你主机的 AI PC 处理器，Zen 5 架构 + XDNA 2 NPU + RDNA 3.5 核显，全家桶配齐。实际表现怎么样？往下看。

## 规格参数

| 型号 | 核心/线程 | 频率 | NPU | 核显 | 功耗 |
|------|-----------|------|-----|------|------|
| Ryzen AI 9 HX 370 | 12C/24T | 2.0-5.1GHz | 50TOPS | Radeon 890M | 28W |
| Ryzen AI 9 365 | 10C/20T | 2.0-5.0GHz | 50TOPS | Radeon 880M | 28W |

### Zen 5 到底强在哪？

- 单核性能比 Zen 4 提升 16%
- 4nm 制程，功耗控制更好
- L3 缓存最大 24MB

### XDNA 2 NPU

这才是重点。50TOPS 算力，什么概念？

Intel Meteor Lake 只有 11TOPS，差距快 5 倍了。Windows Studio Effects 流畅跑，Adobe AI 加速也能用。

### 核显 RDNA 3.5

Radeon 890M，16 个计算单元，频率 2.9GHz。1080p 游戏没问题，偶尔打打 3A 也行。

## 性能实测

用工程样机跑了下，分数如下：

### CPU

| 测试 | 分数 | 相比上代 |
|------|------|----------|
| Cinebench R24 单核 | 118 | +18% |
| Cinebench R24 多核 | 1056 | +22% |
| Geekbench 6 单核 | 2850 | +15% |
| Geekbench 6 多核 | 14320 | +20% |

### GPU

| 游戏 | 1080p 帧数 |
|------|-------------|
| 英雄联盟 | 180fps |
| 原神 | 35fps |
| 赛博朋克 2077 (FSR) | 28fps |

### AI

Stable Diffusion 1.5 能跑到 8.5 it/s，本地跑图基本可用。

## 功耗和散热

28W TDP，比上代还省：

- 待机：5W
- 满载：45W 左右
- 长期负载：稳定 28W

温度压得住，液金导热下满载 75℃，风扇噪音不到 35dB，安静。

## 谁该买？

### 冲

- 视频创作者，离不开硬件编解码
- 想在本地跑 AI 的，NPU 现在就能用
- 追新党，就喜欢最新硬件

### 等

- 预算紧张，上代更香
- 软件生态还没跟上，NPU 能力发挥不出来

## 首发机型

- **Minisforum UM890 Pro**：799 美元起
- **AOOSTAR GTR9**：双 2.5G 网口，适合软路由
- **Beelink SER9**：准系统 699 美元

## 总结

Ryzen AI 300 系列确实猛，CPU、GPU、NPU 三个一起升级。但说实话，现在 AI PC 软件还没完全跟上，大部分人可能用不上 NPU。

建议：等软件生态成熟，或者预算有限的话，上代产品性价比更高。

*首批机型预计本月底上市，想尝鲜的可以关注。*
