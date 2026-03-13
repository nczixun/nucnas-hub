---
title: "NAS 蹇呰 Docker 搴旂敤鎺ㄨ崘锛�2026骞�"
date: 2026-01-01
categories: ["nas"]
summary: "NAS 蹇呰 Docker 搴旂敤鎺ㄨ崘锛屾墦閫犲搴暟鎹腑蹇�"
tags: ["NAS", "Docker", "搴旂敤鎺ㄨ崘", "Home Lab"]
slug: "nas-docker-apps-recommend-2026"
---

# NAS 蹇呰 Docker 搴旂敤鎺ㄨ崘锛�2026骞�

## 褰遍煶濞变箰

### Jellyfin / Plex

| 搴旂敤 | 鐗圭偣 | 鎺ㄨ崘搴� |
|------|------|--------|
| Jellyfin | 鍏嶈垂寮€婧� | 猸愨瓙猸愨瓙猸� |
| Plex | 鍔熻兘寮哄ぇ | 猸愨瓙猸愨瓙 |

### Emby

浠樿垂浣嗙ǔ瀹氾紝閫傚悎杩涢樁鐢ㄦ埛銆�

## 涓嬭浇宸ュ叿

| 搴旂敤 | 鐢ㄩ€� |
|------|------|
| qBittorrent | BT 涓嬭浇 |
| Aria2 | 鍏ㄨ兘涓嬭浇 |
| Transmission | PT 涓嬭浇 |

## Home Assistant

鏅鸿兘瀹跺眳涓灑锛屽己鐑堟帹鑽愬畨瑁呫€�

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    volumes:
      - ./config:/config
    network_mode: host
    restart: unless-stopped
```

## 骞垮憡鎷︽埅

### AdGuard Home

```yaml
services:
  adguard:
    image: adguard/adguardhome
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000"
```

## 瀵艰埅棣栭〉

### Homepage

鑷畾涔変华琛ㄧ洏锛岃仛鍚堟墍鏈夋湇鍔°€�

## 瀹瑰櫒绠＄悊

### Portainer

鍥惧舰鍖� Docker 绠＄悊宸ュ叿銆�

## 鍐呯綉绌块€�

| 鏂规 | 鐗圭偣 |
|------|------|
| Cloudflare Tunnel | 鍏嶈垂绋冲畾 |
| Tailscale | 绠€鍗曟槗鐢� |
| NPM | 鍩熷悕鍙嶅悜浠ｇ悊 |

## 鐩戞帶鍛婅

### Uptime Kuma

鑷墭绠＄洃鎺у伐鍏枫€�

## 瀵嗙爜绠＄悊

### Vaultwarden

鑷墭绠″瘑鐮佺鐞嗗櫒銆�

## 鎬荤粨

| 浼樺厛绾� | 搴旂敤 |
|--------|------|
| 蹇呭 | Portainer, Jellyfin, AdGuard |
| 鎺ㄨ崘 | Home Assistant, qBittorrent |
| 鍙€� | Vaultwarden, Uptime Kuma |
