锘�---
title: "Day 7锛欴ocker涓庡簲鐢ㄤ腑蹇� - 鎷撳睍鏃犻檺鍙兘"
date: 2026-03-06
categories: ["nas"]
slug: "geakos-day7-docker-apps"
summary: "GEAKOS Docker鏁欑▼锛氬簲鐢ㄤ腑蹇冧粙缁嶃€佺涓夋柟鏈嶅姟閮ㄧ讲銆丏ocker Compose浣跨敤锛屾嫇灞昇AS鐜╂硶銆�"
tags: ["GEAKOS", "Docker", "NAS", "搴旂敤涓績"]
---

# Day 7锛欴ocker涓庡簲鐢ㄤ腑蹇�



## 搴旂敤涓績

GEAKOS 鎻愪緵涓板瘜鐨勭涓夋柟搴旂敤锛岀敤鎴峰彲閫氳繃 Docker 閮ㄧ讲鑷繁闇€瑕佺殑搴旂敤鍜屾湇鍔°€�

### 甯哥敤搴旂敤

- Home Assistant锛堟櫤鑳藉灞咃級
- AdGuard锛堝箍鍛婃嫤鎴級
- Nginx Proxy Manager锛堝弽鍚戜唬鐞嗭級
- Bitwarden锛堝瘑鐮佺鐞嗭級

## Docker 閮ㄧ讲

### 鍩烘湰姝ラ

```bash
# 閫氳繃 Docker 瀹夎搴旂敤
docker run -d --name=your-app ...
```

### Docker Compose

```yaml
version: '3'
services:
  app:
    image: your-image
    volumes:
      - ./data:/data
    ports:
      - "8080:8080"
```

## 7澶╁涔犳€荤粨

| 澶╂暟 | 鍐呭 | 鎺屾彙绋嬪害 |
|------|------|----------|
| Day 1 | GEAKOS浠嬬粛/瀵规瘮 | 猸愨瓙猸愨瓙猸� |
| Day 2 | 瀹夎閮ㄧ讲 | 猸愨瓙猸愨瓙猸� |
| Day 3 | AI鏅鸿兘鐩稿唽 | 猸愨瓙猸愨瓙 |
| Day 4 | 褰辫涓績 | 猸愨瓙猸愨瓙 |
| Day 5 | 杩滅▼璁块棶 | 猸愨瓙猸愨瓙 |
| Day 6 | 鏁版嵁瀹夊叏 | 猸愨瓙猸愨瓙 |
| Day 7 | Docker搴旂敤 | 猸愨瓙猸� |

## 涓嬩竴姝�

- 馃彔 鍔ㄦ墜瀹炶返锛氬湪鐢佃剳涓婂畨瑁� GEAKOS
- 馃摎 娣卞叆瀛︿範锛氳闂畼鏂规枃妗�
- 馃挰 浜ゆ祦璁ㄨ锛氬姞鍏ョ敤鎴风ぞ缇�

---

**鎭枩瀹屾垚 GEAKOS 7澶╁涔犱箣鏃咃紒** 馃帀

---

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
