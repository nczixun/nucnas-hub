---
title: "极空间/绿联NAS Docker应用推荐：这10个容器让你的NAS更好用"
date: 2026-03-02
categories: ["nas"]
brand: "极空间/绿联"
model: "Docker应用"
platform: "docker"
official_url: "https://search.jd.com/Search?keyword=%E6%A5%B5%E7%A9%BA%E9%97%B4+NAS+Docker"
bilibili_url: "https://search.bilibili.com/all?keyword=%E6%A5%B5%E7%A9%BA%E9%97%B4+NAS+Docker+%E5%BA%94%E7%94%A8"
youtube_url: "https://www.youtube.com/results?search_query=nas+docker+apps+2024"
pros: "开源免费, 丰富生态, 持续更新"
cons: "需要一定技术基础, 部分应用配置复杂"
slug: "nas-docker-apps-recommend-2026"
---

# 极空间/绿联NAS Docker应用推荐：这10个容器让你的NAS更好用

**更新日期：** 2026年3月2日

## 一、 前言

买回NAS后，很多用户会发现系统自带的应用虽然够用，但总缺少那么一点"自由度"。这就是Docker的魅力所在——它让你能够安装来自全球开发者的开源应用，让NAS真正成为家庭数据中心。

今天给大家推荐10个在极空间和绿联NAS上**亲测好用**的Docker应用，让你 的NAS物超所值。

## 二、 必装基础应用

### 1. Portainer（容器管理器）

```
镜像：portainer/portainer-ce:latest
端口：9000
```

**作用**：图形化Docker管理工具，告别命令行
**推荐理由**：
- 界面直观，查看容器状态一目了然
- 支持容器重启、停止、删除等操作
- 可以查看容器日志，快速定位问题
- **新手必装**，降低Docker使用门槛

### 2. Nginx Proxy Manager（反向代理）

```
镜像：jc21/nginx-proxy-manager:latest
端口：81（管理界面）
```

**作用**：轻松配置域名访问和SSL证书
**推荐理由**：
- 支持Let's Encrypt自动续期SSL证书
- 图形化配置，无需手写nginx配置
- 可以为每个服务配置独立域名
- 远程访问NAS服务的最佳方案

## 三、 下载工具

### 3. QBittorrent（ BT下载）

```
镜像：lscr.io/linuxserver/qbittorrent:latest
端口：8083
```

**作用**：最强开源BT下载工具
**推荐理由**：
- 比自带下载工具更强
- 支持RSS订阅自动下载
- 种子搜索功能强大
- 配合NASpt/Alist，下载后自动整理

### 4. Alist（网盘聚合）

```
镜像：xhofe/alist:latest
端口：5244
```

**作用**：统一管理阿里云盘、百度网盘、115等
**推荐理由**：
- 一次登录，访问所有网盘
- 支持WebDAV，间接扩展NAS存储
- 界面美观，支持视频直链播放
- **强烈推荐**，网盘党的救星

## 四、 影音娱乐

### 5. Jellyfin（媒体服务器）

```
镜像：lscr.io/linuxserver/jellyfin:latest
端口：8096
```

**作用**：自建家庭影院
**推荐理由**：
- 免费开源，无需会员
- 硬件解码，支持4K HDR
- 自动刮削电影海报和简介
- 跨设备同步观看记录
- 配合Jellyfin-Seerr可以自动追剧

### 6. Kavita（电子书/漫画阅读）

```
镜像：kavitareader/kavita:latest
端口：5000
```

**作用**：自建电子书/漫画服务器
**推荐理由**：
- 支持PDF、EPUB、MOBI、AZW3
- 支持漫画文件夹阅读
- 自动整理书库
- 有阅读进度同步
- 书虫必备

## 五、 系统工具

### 7. Home Assistant（智能家居）

```
镜像：homeassistant/home-assistant:stable
端口：8123
```

**作用**：全平台智能家居中控
**推荐理由**：
- 支持米家、HomeKit、涂鸦等平台
- 本地运行，不依赖外网
- 自动化场景配置
- 接入NAS实现更多玩法
- **智能家居玩家必装**

### 8. AdGuard Home（DNS广告拦截）

```
镜像：adguard/adguardhome:latest
端口：53（DNS）、3000（管理界面）
```

**作用**：全屋广告拦截
**推荐理由**：
- 路由器级别广告拦截
- 保护家人免受恶意网站侵害
- 统计上网记录
- 配合Surge/Clash使用效果更佳

## 六、 AI与效率

### 9. Ollama（本地大模型）

```
镜像：ollama/ollama:latest
端口：11434
```

**作用**：本地运行Llama、DeepSeek等大模型
**推荐理由**：
- 隐私安全，数据不出本地
- 支持多模型切换
- 可配合Open WebUI使用
- **2026年最火NAS应用**
- 搭配NAS的强大算力，体验AI本地化

### 10. CodeServer（在线IDE）

```
镜像：lscr.io/linuxserver/code-server:latest
端口：8443
```

**作用**：浏览器里的VSCode
**推荐理由**：
- 随时随地写代码
- 不需要携带电脑
- 配合NAS高性能，随时开发
- 支持插件扩展

## 七、 安装注意事项

### 极空间NAS
1. 打开Docker管理器
2. 选择"镜像"→"仓库"
3. 搜索上述镜像名称
4. 配置端口映射（建议改为不常用端口避免冲突）
5. 建议创建单独的网络，避免容器间相互影响

### 绿联NAS
1. 打开Docker应用
2. 点击"镜像"→"拉取镜像"
3. 使用Docker Compose配置更高效
4. 记得设置开机自启

## 八、 总结

这10个Docker应用覆盖了**下载、影音、智能家居、AI、效率**等常见场景，让你的NAS不再是"大号U盘"。

**入门建议**：先安装Portainer了解Docker基本概念，然后按需安装上述应用。建议每个应用使用独立的存储卷，确保数据持久化。

最后提醒：Docker虽好，但不要贪多。运行太多容器会占用系统资源，NAS可能会变卡哦！

---

**相关阅读**：
- [NAS Docker最佳实践](/guide/docker-best-practice/)
- [如何用NAS搭建家庭影院](/guide/jellyfin-hw-transcode/)
