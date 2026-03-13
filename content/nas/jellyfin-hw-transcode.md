---
title: "Jellyfin 纭欢杞爜璁剧疆鎸囧崡锛�4K 鐣呬韩"
date: 2026-01-01
categories: ["nas"]
summary: "Jellyfin 纭欢杞爜璁剧疆鎸囧崡锛孖ntel QSV/NVIDIA NVENC"
tags: ["Jellyfin", "杞爜", "4K", "NAS"]
slug: "jellyfin-hw-transcode"
---

# Jellyfin 纭欢杞爜璁剧疆鎸囧崡

## 涓轰粈涔堥渶瑕佺‖浠惰浆鐮侊紵

纭欢杞爜鍙互澶у箙闄嶄綆 CPU 鍗犵敤锛屾祦鐣呮挱鏀� 4K 瑙嗛銆�

## Intel 鏍告樉璁剧疆锛堟帹鑽愶級

### 1. 瀹夎 Intel 鏄惧崱椹卞姩

纭繚绯荤粺宸插畨瑁� Intel 鏄惧崱椹卞姩銆�

### 2. 閰嶇疆 Docker

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    environment:
      - TZ=Asia/Shanghai
      - LIBVA_DRIVER_NAME=iHD
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/media:/media:ro
    devices:
      - /dev/dri:/dev/dri
    restart: unless-stopped
```

### 3. Jellyfin 鍚庡彴閰嶇疆

1. 鎺у埗闈㈡澘 鈫� 鎾斁 鈫� 杞爜
2. 纭欢鍔犻€燂細Intel QuickSync (QSV)
3. 鍚敤纭欢瑙ｇ爜

## NVIDIA 鏄惧崱璁剧疆

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## 鏀寔鐨勬牸寮�

### Intel QSV

| 鏍煎紡 | 鏀寔 |
|------|------|
| H.264 | 鉁� |
| HEVC (H.265) | 鉁� |
| VP9 | 鉁� |
| AV1 | 鉁� |

### NVIDIA NVENC

| 鏍煎紡 | 鏀寔 |
|------|------|
| H.264 | 鉁� |
| HEVC (H.265) | 鉁� |
| VP9 | 鉂� |
| AV1 | 鉁� |

## 鎬ц兘瀵规瘮

| 鏂规 | 4K 杞爜 CPU | 鍔熻€� |
|------|-------------|------|
| 杞欢杞爜 | 80% | 楂� |
| Intel QSV | 10% | 浣� |
| NVIDIA | 5% | 涓� |

## 甯歌闂

### Q: 鎵句笉鍒扮‖浠跺姞閫燂紵

A: 妫€鏌� Docker 璁惧鏄犲皠

### Q: 杞爜澶辫触锛�

A: 妫€鏌ラ┍鍔ㄦ槸鍚︽纭畨瑁�

## 鎬荤粨

Intel QSV 鏄� NAS 鏈€浣抽€夋嫨锛屽姛鑰椾綆鏁堟灉濂姐€�

**鎺ㄨ崘鎸囨暟**锛氣瓙猸愨瓙猸愨瓙
