---
title: "Docker 閺夆晜鐩Ο渚€鏁嶅顐⑩枏闁活澁鎷� Docker Compose 缂傚倹鐗楃敮鎾村緞濮橆偊鍤嬮悗鍦嚀濞咃拷"
date: 2026-03-07
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
slug: "docker-compose-advanced-guide-2026"
---

# Docker 閺夆晜鐩Ο渚€鏁嶅顐⑩枏闁活澁鎷� Docker Compose 缂傚倹鐗楃敮鎾村緞濮橆偊鍤嬮悗鍦嚀濞咃拷

闁告娲滅€氼厽娼婚幇顖ｆ斀閻庡湱鎳撳▍鎺撱偣閼姐倕鍔滈柨娑氬枔閺侊拷 **Docker Compose** 濞戞挴鍋撴繛鍡磿椤撴悂鎮堕崱妯侯暡闁哄牆顦板﹢鍥礉鎺抽埀顒婃嫹

**閻庣懓顦抽ˉ锟� Docker Compose闁挎冻鎷�**

```bash
# 缂傚洢鍊栧▍鈧�/濡炲鍋熸晶鐧楽
sudo apt update
sudo apt install docker-compose
```

**缂傚倹鐗曢崯锟� docker-compose.yml闁挎冻鎷�**

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

**閻㈩垰鎽滈弫銈夊川閹存帗濮㈤柨娑虫嫹**

- `docker-compose up -d`闁挎稒鑹鹃幆搴ㄥ礉閵婏箑顣查柡鍫濐槹濠€鍥礉閿燂拷
- `docker-compose down`闁挎稒鑹炬禒鐘差潰閵忊€愁暡闁哄牆顦板﹢鍥礉閿燂拷
- `docker-compose restart`闁挎稒宀搁崳鎼佸触椤栨稑顣查柡鍫濐槹濠€鍥礉閿燂拷
- `docker-compose logs -f`闁挎稒纰嶉悡锟犳儑鐎ｎ偅锛夐煫鍥锋嫹

閺夆晜鐟ч～鎺楀棘閻熸壆纭€闂侇喓鍔庣拋锟� **Jellyfin闁靛棔鍌匓ittorrent闁靛棔鑵恊xtcloud** 缂備礁瀚幃搴ㄦ偋閻熸澘鐒奸柡鍌炩偓娑氣敀闁挎稑濂旂粩瀛樼▔椤忓嫭鍤掑ù鐘€曢崣蹇涘箹閻愯尙鏆伴柕鍡嫹
