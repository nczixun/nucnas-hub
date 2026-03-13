---
title: "Day 7: 妞嬬偟澧癘S閺佺増宓佹径鍥﹀敜娑撳骸鎮撳锟� 閳ユ柡鈧拷 鐎瑰牊濮㈡担鐘垫畱閺佺増宓佺€瑰鍙�"
date: 2026-03-13
summary: "鐎涳缚绡勬鐐靛OS閻ㄥ嫭鏆熼幑顔碱槵娴犵晫鐡ラ悾銉礉娣囨繃濮㈤柌宥堫洣閺佺増宓佹稉宥勬丢婢朵究鈧拷"
categories: ["nas"]
slug: "fnos-day7-backup"
tags: ["妞嬬偟澧癘S", "婢跺洣鍞�", "閸氬本顒�", "閺佺増宓佺€瑰鍙�"]
---

# Day 7: 妞嬬偟澧癘S閺佺増宓佹径鍥﹀敜娑撳骸鎮撳锟�


## 娑撹桨绮堟稊鍫ユ付鐟曚礁顦禒鏂ょ吹

- ?? 绾剛娲忔导姘綎
- ?? 缁崵绮烘导姘┛
- ?? 鐠囶垰鍨归弬鍥︽
- ?? 閸曟帞鍌ㄩ惀鍛槰

## 婢跺洣鍞ょ粵鏍殣

### 3-2-1 閸樼喎鍨�
- 3娴犺姤鏆熼幑顔煎閺堬拷
- 2缁夊秳绗夐崥灞界摠閸屻劋绮欑拹锟�
- 1娴犺棄绱撻崷鏉跨摠閸岋拷

## 閺堫剙婀存径鍥﹀敜

### 娴ｈ法鏁sync

```bash
# 婢跺洣鍞ら崚鏉垮綗娑撯偓娑擃亞鈥栭惄锟�
rsync -avz /source /backup

# 婢х偤鍣烘径鍥﹀敜
rsync -avz --delete /source /backup
```

### 娴ｈ法鏁�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鐎圭懓娅�

```yaml
version: '3'
services:
  duplicati:
    image: lscr.io/linuxserver/duplicati
    container_name: duplicati
    volumes:
      - ./config:/config
      - ./backups:/backups
      - /data:/source
    ports:
      - "8200:8200"
    restart: unless-stopped
```

## 娴滄垹顏崥灞绢劄

### 1. Rclone闁板秶鐤�

```bash
# 鐎瑰顥奟clone
curl https://rclone.org/install.sh | sudo bash

# 闁板秶鐤�
rclone config
```

---

<div class="page-nav">
  <a href="/guide/fnos-day6-docker/" rel="prev">娑撳﹣绔存い纰夌窗Day 6閿涙岸顥ｉ悧姹稴 Docker鎼存梻鏁�</a>
</div>

*閺堫剚鏋冮悽锟� NUC NAS Hub 閼奉亜濮╅悽鐔稿灇*
