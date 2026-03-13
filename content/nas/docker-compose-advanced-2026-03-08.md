---
title: "Docker Compose 閺夆晜鐩Ο渚€鏁嶅顒夋▼閻庡湱鎳撳▍鎺旂磽閺嶃劌绗撻悗鍦仦閸剟骞愰崶褍纭€"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 閻庢冻绠撳▍锟�"]
tags: ["Docker", "Docker Compose", "NAS", "閻庡湱鎳撳▍鎺旂磽閺嶃劌绗�", "闁煎浜滄慨鈺呭礌閿燂拷", "闁轰焦鐟ч埢锟�"]
draft: false
---

濞村吋姘ㄩ弫锟� Docker 濞达絽妫旂粭澶愭偄閻旂ǹ鈧拷 Compose闁挎稓鍠曠换鏍姬閸パ呮暔濞达絿濮剧换姗€姊奸煬娴嬪亾閸屾凹鍔呭ù纭锋嫹 docker-compose闁挎稑濂旂粩鎾煥椤旂虎鍚€闁荤偛妫欐晶宥夊嫉婢跺⿴鍟囬柛锝冨妸閳ь剨鎷�

## 濞戞捁妗ㄧ划鍫熺▕閸垺鏆� Docker Compose闁挎冻鎷�

闁归潧顑呮慨锟� docker run 婵絽绻戦濂告焾閸婄噥娲ｉ柡浣藉紦缁旀挳宕奸崱妤€妫橀柡浣稿簻缁辨繄鈧湱鎳撳▍鎺撳緞濮橆偆鍟婇柡宥堫潐濠€鎵媼妫颁胶鐟濆ù锝呯箞閳ь兛鏅痮mpose 闁活澁鎷� YAML 闁哄倸娲ｅ▎銏⑩偓瑙勭煯缁犵喖寮靛鍛潳闁挎稑鐬兼晶妤呭嫉椤掍礁浠橀柛鎺曠堪閳ь兛娴囩缓鑲╃矓濮瑰洠鍋撴担鍓叉У濞寸姳绮欓崗姗€寮柅娑氣敀闁靛棴鎷�

## 闁糕晞娅ｉ、鍛磼閹惧鈧拷

```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret
```

## 閺夆晜鐩Ο渚€骞庨埀顒€顔忛敓锟�

### 1. 闁绘粠鍨伴。銊╁矗濮椻偓閸ｈ櫣绮婚敍鍕€�

闁告帗绋戠紓锟� `.env` 闁哄倸娲ｅ▎銏ゆ晬閿燂拷

```bash
# .env
POSTGRES_PASSWORD=your_secure_password
DATA_PATH=/mnt/storage
```

Compose 闁煎浜滄慨鈺冩嫚鐠囨彃绲块柨娑虫嫹

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ${DATA_PATH}/postgres:/var/lib/postgresql/data
```

### 2. 缂傚啯鍨圭划鍫曟⒕閺冨偆鐎�

```yaml
services:
  web:
    networks:
      - frontend
  db:
    networks:
      - backend

networks:
  frontend:
  backend:
    internal: true  # 閻庣懓鑻崣蹇涙⒕閺冨偆鐎�
```

### 3. 闁稿鍎遍幃宥呂涢埀顒勫蓟閿燂拷

```yaml
services:
  redis:
    image: redis
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 4. 濞撴碍绻嗙粋鍡涘礂瀹曞洭鍏�

```yaml
services:
  web:
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

## 閻㈩垰鎽滈弫銈夊川閹存帗濮�

```bash
# 闁告凹鍨版慨鈺呭箥閳ь剟寮垫径瀣疀闁告棑鎷�
docker-compose up -d

# 闁哄被鍎冲﹢鍛村籍閵夈儳绠�
docker-compose logs -f

# 闁哄洤鐡ㄩ弻濠囨⒐濠婂啫鍓�
docker-compose pull
docker-compose up -d

# 闁稿绮嶉娑㈠箥閳ь剟寮垫径瀣疀闁告棑鎷�
docker-compose down
```

## 闁瑰瓨鍨瑰▓锟� NAS 闂佹澘绉堕悿鍡涘礆閸℃洟鐓�

閺夆晜鐟﹀Σ鎼佸箣閹寸姵绐楅柛鎾崇Т濠€顏堟偨閵娧勭暠闂侇喓鍔岄崹搴ㄦ煀瀹ュ洨鏋傞柨娑虫嫹

```yaml
services:
  homeassistant:
    image: homeassistant/home-assistant
    network_mode: host
    volumes:
      - ./ha:/config
    restart: unless-stopped

  portainer:
    image: portainer/portainer-ce
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./portainer:/data

  nginx:
    image: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/html:/usr/share/nginx/html
      - ./nginx/ssl:/etc/nginx/ssl:ro
```

## 闁诡剝宕电划锟�

Docker Compose 闁活亞鍠撳▓鎴﹀及椤栨粍鏆忓ù婊冩濮樸劑宕堕悙鎵憹闁告ɑ鐪归埀顒€鍊块崢銈囩磾椤旇崵顏辨繛鍡忔缁辨繃绋夌€ｎ偒鍋х€殿喒鍋撻柡鍫ｆ〃缁旀挳鏌ㄩ鍏煎剻闁告柣鍔嶆晶宥夊嫉婢跺绠涢柛鏂呮壋鍋撻崒姘辩处閻犱緡鍠栭妵鍥┾偓鐟扮埣閸忔﹢鎳炴潏銊︻槯闂傚倹娼欓鐔哥▔閳ь剚绋夌€ｅ墎绀夐柣顏嗗枔濞堟垿鎳楅悾灞鹃槣鐎垫澘鐗嗛ˇ鍧楀礉閻旀灚浜遍柕鍡嫹

---
*婵炴潙顑堥惁顖炴偝椤栨凹鏆旈柨娑欐皑閸忋垽寮查敓锟� DS920+ Docker 24.0*
