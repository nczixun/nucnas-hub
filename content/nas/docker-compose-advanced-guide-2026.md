---
title: "Docker 鏉╂盯妯侀敍姘▏閻拷 Docker Compose 缂傛牗甯撴径姘嚋鐎圭懓娅�"
date: 2026-03-07
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
slug: "docker-compose-advanced-guide-2026"
---

# Docker 鏉╂盯妯侀敍姘▏閻拷 Docker Compose 缂傛牗甯撴径姘嚋鐎圭懓娅�

閸楁洜瀚潻鎰攽鐎圭懓娅掓ス鑽ゅ劜閿涚喓鏁� **Docker Compose** 娑撯偓濞嗭紕顓搁悶鍡樺閺堝婀囬崝掳鈧拷

**鐎瑰顥� Docker Compose閿涳拷**

```bash
# 缂囥倖娅€/妞嬬偟澧癘S
sudo apt update
sudo apt install docker-compose
```

**缂傛牕鍟� docker-compose.yml閿涳拷**

```yaml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    ports:
      - "8096:8096"
    volumes:
      - /mnt/storage/jellyfin:/config
    environment:
      - TZ=Asia/Shanghai
```

**鐢摜鏁ら崨鎴掓姢閿涳拷**

- `docker-compose up -d`閿涙艾鎯庨崝銊﹀閺堝婀囬崝锟�
- `docker-compose down`閿涙艾浠犲銏″閺堝婀囬崝锟�
- `docker-compose restart`閿涙岸鍣搁崥顖涘閺堝婀囬崝锟�
- `docker-compose logs -f`閿涙碍鐓￠惇瀣）韫囷拷

鏉╂瑧顫掗弬鐟扮础闁劎璁� **Jellyfin閵嗕傅Bittorrent閵嗕腐extcloud** 缂佸嫬鎮庨悧鐟板焼閺傞€涚┒閿涘奔绔存稉顏勬嚒娴犮倕鍙忛幖鐐茬暰閵嗭拷
