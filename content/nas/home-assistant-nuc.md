---
title: "Home Assistant 安装教程：智能家居中枢"
date: 2026-01-01
categories: ["nas"]
summary: "Home Assistant 安装教程，打造智能家居中枢"
tags: ["Home Assistant", "智能家居", "NAS", "Docker"]
slug: "home-assistant-nuc"
---

# Home Assistant 安装教程

## 什么是 Home Assistant？

Home Assistant 是开源的智能家居平台，支持数千种智能设备。

## 安装方式

### Docker 安装（推荐）

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

### 启动

```bash
docker compose up -d
```

## 首次配置

1. 访问 `http://localhost:8123`
2. 创建账户
3. 自动发现设备

## 常用集成

| 集成 | 用途 |
|------|------|
| 米家 | 小米设备 |
| HomeKit | 苹果设备 |
| Tuya | 涂鸦设备 |
| MQTT | 自定义设备 |

##自动化

### 创建自动化

```yaml
automation:
  - alias: "离家模式"
    trigger:
      - platform: state
        entity_id: binary_sensor.door
        to: 'off'
    action:
      - service: light.turn_off
        entity_id: all
```

## 推荐插件

- HACS：第三方插件市场
- ESPHome：DIY 设备
- Node-RED：可视化流程

## 总结

Home Assistant 是智能家居的核心，值得投入时间配置。

**推荐指数**：⭐⭐⭐⭐⭐
