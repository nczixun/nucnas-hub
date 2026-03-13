---
title: "Home Assistant 瀹夎鏁欑▼锛氭櫤鑳藉灞呬腑鏋�"
date: 2026-01-01
categories: ["nas"]
summary: "Home Assistant 瀹夎鏁欑▼锛屾墦閫犳櫤鑳藉灞呬腑鏋�"
tags: ["Home Assistant", "鏅鸿兘瀹跺眳", "NAS", "Docker"]
slug: "home-assistant-nuc"
---

# Home Assistant 瀹夎鏁欑▼

## 浠€涔堟槸 Home Assistant锛�

Home Assistant 鏄紑婧愮殑鏅鸿兘瀹跺眳骞冲彴锛屾敮鎸佹暟鍗冪鏅鸿兘璁惧銆�

## 瀹夎鏂瑰紡

### Docker 瀹夎锛堟帹鑽愶級

```yaml
version: '3.8'

services:
  homeassistant:
    image: homeassistant/home-assistant
    container_name: homeassistant
    volumes:
      - ./config:/config
      - /etc/localtime:/etc/localtime:ro
    environment:
      - TZ=Asia/Shanghai
    network_mode: host
    restart: unless-stopped
    privileged: true
```

### 鍚姩

```bash
docker compose up -d
```

## 棣栨閰嶇疆

1. 璁块棶 `http://localhost:8123`
2. 鍒涘缓璐︽埛
3. 鑷姩鍙戠幇璁惧

## 甯哥敤闆嗘垚

| 闆嗘垚 | 鐢ㄩ€� |
|------|------|
| 绫冲 | 灏忕背璁惧 |
| HomeKit | 鑻规灉璁惧 |
| Tuya | 娑傞甫璁惧 |
| MQTT | 鑷畾涔夎澶� |

##鑷姩鍖�

### 鍒涘缓鑷姩鍖�

```yaml
automation:
  - alias: "绂诲妯″紡"
    trigger:
      - platform: state
        entity_id: binary_sensor.door
        to: 'off'
    action:
      - service: light.turn_off
        entity_id: all
```

## 鎺ㄨ崘鎻掍欢

- HACS锛氱涓夋柟鎻掍欢甯傚満
- ESPHome锛欴IY 璁惧
- Node-RED锛氬彲瑙嗗寲娴佺▼

## 鎬荤粨

Home Assistant 鏄櫤鑳藉灞呯殑鏍稿績锛屽€煎緱鎶曞叆鏃堕棿閰嶇疆銆�

**鎺ㄨ崘鎸囨暟**锛氣瓙猸愨瓙猸愨瓙
