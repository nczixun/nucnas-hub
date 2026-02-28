---
slug: "tailscale-remote-access"
title: "Tailscale：无需公网 IP，实现内网穿透"
date: 2026-02-12
summary: "全球范围内安全访问你家里的 NUC NAS。"
categories: ["nas"]
---

# Tailscale：无需公网IP，实现内网穿透

"我在公司想访问家里的NAS文件"、"我在出差时想看看监控摄像头的实时画面"、"我想在外网控制家里的智能家居设备"——这些场景的核心需求只有一个：**远程访问内网设备**。然而，国内大多数家庭宽带都没有公网IPv4地址，运营商提供的NAT使得直接从外部访问成为奢望。花生壳、frp等内网穿透工具要么收费昂贵，要么配置复杂，要么速度堪忧。

Tailscale的出现改变了这个局面。它基于WireGuard协议，利用TURN服务器实现NAT穿透，让你可以在任何有网络的地方，像在局域网内一样访问家中的NAS。更重要的是，它是免费的、个人使用完全足够、配置简单到令人发指。本文将详细介绍Tailscale的工作原理、在NAS上的部署方法以及实际应用场景。

## Tailscale是什么

Tailscale是一款基于WireGuard的VPN（虚拟专用网络）工具。与传统VPN不同，Tailscale的设计目标是让普通用户也能轻松实现设备之间的点对点连接，而无需复杂的配置和服务器搭建。

工作原理可以简单理解为：你在每台需要远程访问的设备上安装Tailscale客户端（NAS、手机、电脑、路由器），这些设备会组成一个虚拟的局域网。在这个虚拟网络中，每个设备都有一个唯一的"tailnet IP"地址，无论这些设备物理上在哪里，你都可以直接通过这个IP地址访问它们，就像在同一个WiFi下一样。

Tailscale的核心优势包括：无需公网IP、无需配置路由器、无需购买服务器、中文界面、支持全平台（Windows、macOS、Linux、iOS、Android）、免费个人版足够使用。

## 基础部署：NAS上的Tailscale

Tailscale官方提供了多种安装方式，对于NAS用户来说，最推荐的是通过Docker运行。

第一步，安装Docker。如果你使用群晖、TrueNAS或飞牛OS，Docker通常已经预装或可以在应用商店一键安装。

第二步，获取Tailscale认证密钥。访问Tailscale官网（tailscale.com）注册账号，在控制台的"Settings" > "Personal keys"中生成一个新的认证密钥。注意设置合适的过期时间，建议设置为1年。

第三步，创建Docker容器。在docker-compose.yml中添加以下内容：

```yaml
version: '3.8'

services:
  tailscale:
    image: tailscale/tailscale:latest
    container_name: tailscale
    network_mode: host
    cap_add:
      - net_admin
      - sys_module
    volumes:
      - ./state:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    environment:
      - TS_AUTH_ONCE=true
      - TS_KUBE_SECRET=
      - TS_USERSPACE=false
      - TS_STATE_DIR=/var/lib/tailscale
      - TS_AUTH_KEY=你的Tailscale认证密钥
    restart: unless-stopped
```

这个配置的关键点包括：`network_mode: host`让容器使用宿主机网络栈；`cap_add`提供必要的内核权限；`/dev/net/tun`设备映射是WireGuard运行所必需的；`TS_AUTH_KEY`填写你生成的认证密钥。

容器启动后，首次运行会自动完成设备注册。可以通过日志确认连接状态：

```bash
docker logs tailscale
```

如果看到"Tailscale is running"的日志，说明连接成功。

## 路由与子网路由器的用

默认妙情况下，Tailscale只允许访问安装了Tailscale客户端的设备。如果你想让Tailscale客户端能够访问NAS所在局域网的全部设备（如打印机、摄像头、智能家居网关），需要配置"子网路由器"（Subnet Router）。

第一步，在NAS上开启IP转发。执行：

```bash
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
```

第二步，在Tailscale容器中添加advertise routes参数。修改docker-compose.yml：

```yaml
environment:
  - TS_AUTH_KEY=你的认证密钥
  - TS_ROUTES=192.168.1.0/24  # 你的局域网网段
```

第三步，在Tailscale控制台启用子网路由。登录Tailscale管理后台，找到你的NAS设备，在"Edit route settings"中启用刚才发布的路由。

配置完成后，你的手机或笔记本连接到Tailscale后，可以直接通过局域网IP访问NAS下的所有设备。比如，你可以用手机上的VNC Viewer直接访问家中局域网里的Windows电脑，而不需要在那个电脑上额外安装Tailscale。

## 进阶玩法：出口节点与安全访问

Tailscale还有两个进阶功能值得了解：

**出口节点（Exit Node）**：开启后，你的Tailscale设备可以通过NAS的公网出口访问互联网。这意味着当你出差到国外时，可以通过Tailscale"回家"，获得和在家里一样的网络环境。这对于需要访问国内资源（音乐、视频、支付App）的海外华人非常实用。

配置方法：在NAS的Tailscale容器环境变量中添加`TS_ALLOW_ACCESS_CONTROL=true`，然后在Tailscale客户端开启"Use as exit node"即可。

**ACL访问控制**：Tailscale支持细粒度的访问控制策略，可以指定哪些设备可以访问哪些服务。例如，你可以设置只有工作电脑可以访问NAS的文件服务，而手机只能访问媒体服务。ACL配置在Tailscale控制台的"Access Control"页面编辑。

## 常见问题与解决方案

**Q：Tailscale连接成功但无法访问NAS？**
A：检查防火墙设置。群晖用户需要在"控制面板" > "安全性"中允许Tailscale网段的访问。也可以尝试在NAS上执行`sudo iptables -L`查看是否有规则阻止。

**Q：连接速度很慢？**
A：Tailscale会自动选择最优的传输路径，默认情况下使用UDP直连。如果网络环境复杂（如企业防火墙），可以尝试在客户端设置中启用"Use HTTPS"强制TCP模式。

**Q：如何查看Tailscale分配的IP地址？**
A：在NAS上执行`docker exec tailscale tailscale ip -4`，或在Tailscale控制台查看设备详情。

**Q：NAS重启后Tailscale需要重新登录？**
A：这是因为使用了`TS_AUTH_ONCE=true`。首次认证后，状态文件会保存在`./state`目录中。只要这个目录存在，重启后无需重新认证。

## 替代方案对比

除了Tailscale，市面上还有几款类似的工具：

**WireGuard**：Tailscale的底层协议，比Tailscale更轻量但需要自己搭建控制服务器，不适合普通用户。

**Cloudflare Tunnel**：免费但配置相对复杂，适合有一定技术背景的用户。

**ZeroTier**：与Tailscale类似，但国内访问速度较慢，近年服务不太稳定。

综合来看，Tailscale是目前最推荐的方案：速度快、免费版够用、配置简单、跨平台支持好。

## 实际应用场景

部署好Tailscale后，你可以实现以下场景：

**远程文件访问**：在公司或出差时，通过SMB/AFP协议直接挂载NAS文件目录，像本地磁盘一样使用。

**监控远程观看**：通过VNC或RDP远程访问家中电脑查看监控摄像头画面。

**智能家居控制**：在手机上通过Home Assistant客户端远程控制家中的智能设备。

**PT下载挂种**：远程登录NAS管理下载任务，查看做种状态。

**开发测试**：将开发中的网站或服务发布到Tailscale网络，远程演示给客户或同事。

## 总结

Tailscale彻底简化了内网穿透的复杂度。它不需要公网IP、不需要复杂配置、甚至不需要任何费用，就能让你在全球任何一个角落安全访问家中的NAS和服务。对于NAS用户来说，Tailscale几乎是必装的应用——它让"随时随地访问自己的数据"成为可能，而这一切都是免费的。

当你第一次在出差途中成功打开NAS上的照片备份、当你在海外用Tailscale"回家"流畅观看国内视频、当你不在家却能远程调试智能家居设备——你会意识到，这才是私有云真正应该有的样子。
