---
title: '2.5L的All in One神教圣体——铭凡 Minisforum MS-01 开箱测评：当迷你工作站塞进万兆和PCIe'
date: 2026-02-20
categories: ["hardware"]
brand: "Minisforum"
model: "MS-01"
platform: "intel"
official_url: "https://search.jd.com/Search?keyword=Minisforum+MS-01"
bilibili_url: "https://search.bilibili.com/all?keyword=Minisforum+MS-01+测评"
youtube_url: "https://www.youtube.com/results?search_query=Minisforum+MS-01+review"
pros: "做工精良, 性能稳定, 接口丰富"
cons: "负载较高时有风扇声, 扩展位有限"
slug: "minisforum-ms-01"
---

# 2.5L的“All in One”神教圣体——铭凡 Minisforum MS-01 开箱测评：当迷你工作站塞进万兆和PCIe

**测评日期：** 2026年2月20日  
**测评型号：** 铭凡 Minisforum MS-01（i9-13900H / 32GB+1TB版 / 准系统版）


## 一、 前言

在迷你主机的江湖里，铭凡（Minisforum）一直以“敢想敢做”著称。如果说之前的UM系列是为了满足桌面娱乐，那么今天这台**MS-01**，则是冲着**技术极客、Homelab玩家和企业级用户**的命门去的。

它不再仅仅追求体积的极致小巧，而是在约**2.5升**的机身内，集成了**双10G SFP+光口、双2.5G电口、两个USB4，以及一条物理PCIe x16插槽**（实际速率x8）。这种配置在迷你主机领域堪称“异类”，甚至被玩家戏称为“先天All in One圣体”。

这台机器究竟是怎样的存在？让我们一探究竟。


## 二、 外观与接口：接口狂魔，扩展拉满

**体积与设计**
MS-01的机身尺寸为196×189×48mm，体积约**2.5升**，重量**1.5公斤**，比我们常见的0.8L迷你主机大了一圈，但依然远小于传统ITX机箱。外壳以金属为主，辅以塑料面板，整体风格硬朗，更像一台专业工作站而非家用小可爱。

**接口配置：史无前例**

| 位置 | 接口类型 | 规格与用途 |
| :--- | :--- | :--- |
| **前置** | 电源键、3.5mm音频、USB3.2 Gen1、2×USB2.0 | 方便接入键鼠、U盘 |
| **后置** | **2×10G SFP+** (Intel X710)、**2×2.5G RJ45** (Intel I226-V/LM)、**2×USB4** (40Gbps)、HDMI 2.0、2×USB3.2 Gen2、DC 19V输入、**PCIe插槽挡板** | 网络怪兽，支持四屏输出，USB4可接显卡坞 |

它的背部一眼看去全是网口，对于需要搭建软路由、虚拟化服务器或高速NAS的用户来说，这简直是梦中的配置。


## 三、 内部构造：可玩性极高的“小钢炮”

**拆机体验**：按下背部卡扣即可抽出整个主板托架，无需工具。

- **内存**：2个SO-DIMM插槽，支持最高**96GB DDR5-5200/5600MHz**双通道内存。实测13900H支持96GB，12900H部分用户反馈也能支持。
- **存储**：**3个M.2插槽**。其中一个支持PCIe 4.0，可通过附赠转接卡安装**U.2 SSD**（需拨动底部开关）。
- **散热**：CPU采用涡轮风扇+热管散热，底部另有一个小风扇专门为SSD散热。
- **PCIe插槽**：物理x16插槽，实际支持PCIe 4.0 x8速率。可安装**半高单槽显卡**（如RTX A2000）或各种扩展卡（万兆电口卡、阵列卡等）。


## 四、 核心硬件：移动端i9，够用但需注意

**处理器：Intel Core i9-13900H**
- **14核心20线程**（6性能核+8能效核）
- 最高睿频**5.4GHz**
- 24MB三级缓存
- 厂商设定PL1 **60W**，PL2 **80W**（默认温度墙90℃）

这是英特尔13代移动端旗舰，性能足以应对绝大多数生产力场景。

**核显：Iris Xe（96EU）**
- 支持AV1、HEVC、VP9硬件解码，8K视频播放流畅
- 3DMark Time Spy显卡分约**1876**，可轻度网游，但3A大作需降低画质或外接显卡

⚠️ **特别提醒**：Notebookcheck在测试i9-13900H版本时曾遇到长时间高负载崩溃的问题，将功耗降至35W后有所缓解，推测与处理器个体有关。Creative Bloq在测试中未复现此问题。建议关注最新批次情况。


## 五、 性能实测：60W下的稳定输出

**CPU理论性能**（PL1=60W，PL2=80W）

| 测试项目 | 得分 | 备注 |
| :--- | :--- | :--- |
| **Cinebench R23多核** | 15211 | 解锁后可达16660 |
| **Cinebench R23单核** | 1719 |  |
| **Geekbench 6多核** | 12499 |  |
| **Geekbench 6单核** | 2388 |  |
| **CPU-Z多核** | 7040 |  |
| **7-Zip** | 表现优异 | 压缩解压性能强 |
| **x264编码** | 70.2 fps |  |

**核显性能**

| 测试项目 | 得分 | 备注 |
| :--- | :--- | :--- |
| **3DMark Time Spy** | 2139（显卡1876） |  |
| **3DMark Fire Strike** | 6136 |  |
| **Geekbench 6 OpenCL** | 17482 |  |

**PCIe扩展实测（搭载RTX A2000）**
- **3DMark Time Spy**：总分6223（显卡5721），游戏性能飙升


## 六、 散热与噪音：全速模式解封印

**烤机测试**（默认90℃温度墙）

| 场景 | CPU功耗 | 温度 | 频率 |
| :--- | :--- | :--- | :--- |
| **默认风扇** | PL2阶段2秒后触发温度墙，降至64W | 90℃ | 3.02GHz |
| **默认风扇** | PL1阶段稳定**53W** | 90℃ | 2.77GHz |

**解锁100℃ + 全速风扇**

| 场景 | CPU功耗 | 温度 | 频率 | R23多核 |
| :--- | :--- | :--- | :--- | :--- |
| **PL2阶段** | 80W（满血） | 100℃ | 3.27GHz | - |
| **PL1阶段** | 60W | 90℃ | 2.92GHz | **16141**（+6%） |

**噪音表现**
- **环境噪音**：35.8dB
- **Stress FPU**：平均**42.6dB**，进入PL1后稳定在**47.4dB**

可感知但不吵人，比游戏本安静。


## 七、 总结：技术极客的终极玩具

**优点：**
- **网络怪兽**：双10G SFP+ + 双2.5G电口，业界罕见，虚拟化/软路由神器
- **扩展无敌**：PCIe x16插槽 + 双USB4 + 三M.2，玩法无限
- **性能够用**：i9-13900H + 60W释放，办公渲染通吃
- **可玩性高**：支持U.2硬盘、半高显卡、vPro远程管理
- **做工扎实**：全金属框架，免工具拆装

**缺点：**
- **散热瓶颈**：默认90℃温度墙限制性能，需手动解锁
- **i9稳定性疑云**：部分评测遇到高负载崩溃，建议关注
- **体积较大**：2.5L比普通迷你主机胖一圈
- **核显偏弱**：无独显时游戏性能有限

**购买建议：**
**铭凡 MS-01**不是一台给普通办公用户的电脑。它是为**Homelab玩家、虚拟化狂热者、软路由发烧友、需要万兆内网的内容创作者**准备的。

- **如果你**需要一台All in One主机，跑ESXi/Proxmox，同时当软路由、NAS、服务器，MS-01是梦中情机。
- **如果你**需要移动工作站，且有外接显卡或半高显卡需求，它也能胜任。
- **如果你**只是日常办公影音，UM系列更轻巧便宜。

ServeTheHome评价：“用这台系统，感觉就像某个看评论的人设计了它”。


**配置速览**：

| 配置项 | 规格 |
| :--- | :--- |
| **处理器** | Intel Core i9-13900H（14C/20T，最高5.4GHz）/ i5/i7可选 |
| **核显** | Intel Iris Xe Graphics（96EU） |
| **内存** | 双SO-DIMM DDR5-5200（最高96GB） |
| **存储** | 3×M.2 PCIe 4.0（支持U.2转接） |
| **网络** | 2×10G SFP+（Intel X710）+ 2×2.5G RJ45（Intel I226） |
| **接口** | 双USB4 + HDMI + 多USB-A + PCIe x16插槽（x8速率） |
| **体积** | 196×189×48mm，约2.5L |
| **电源** | 180W DC适配器 |
| **特色** | Intel vPro远程管理、支持半高显卡/扩展卡 |

### ✅ 优点
双 10G SFP+ 万兆口, 扩展性无敌, 支持 U.2 硬盘, 做工扎实

### ❌ 遗憾
风扇噪音较大, 价格较贵, 内部结构复杂

---
## 📺 视频评测推荐
<div style='display: flex; gap: 15px; flex-wrap: wrap; margin-top: 20px;'>
    <a href='https://search.bilibili.com/all?keyword=Minisforum+MS-01+测评' target='_blank' class='glass-card' style='flex: 1; padding: 20px; display: flex; align-items: center; gap: 15px; text-decoration: none; color: inherit;'>
        <div style='width: 40px; height: 40px; background: #FB7299; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;'>B</div>
        <div><div style='font-weight: 700;'>Bilibili 测评</div><div style='font-size: 12px; color: #86868B;'>国内实测</div></div>
    </a>
    <a href='https://www.youtube.com/results?search_query=Minisforum+MS-01+review' target='_blank' class='glass-card' style='flex: 1; padding: 20px; display: flex; align-items: center; gap: 15px; text-decoration: none; color: inherit;'>
        <div style='width: 40px; height: 40px; background: #FF0000; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;'>Y</div>
        <div><div style='font-weight: 700;'>YouTube</div><div style='font-size: 12px; color: #86868B;'>全球视角</div></div>
    </a>
</div>
<div style='margin-top: 30px; text-align: center;'>
    <a href='https://search.jd.com/Search?keyword=Minisforum+MS-01' target='_blank' class='btn-apple' style='background: #E1251B; color:white; border-radius: 99px; padding: 10px 25px; display: inline-block; text-decoration:none;'>去京东查看价格 &rarr;</a>
</div>
