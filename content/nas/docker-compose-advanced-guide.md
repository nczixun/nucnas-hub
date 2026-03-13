---
title: "Docker Compose 杩涢樁锛氬浣曠敤閰嶇疆鏂囦欢绠＄悊澶嶆潅瀹瑰櫒鐜"
date: 2026-03-08
categories: ["nas"]
summary: "Docker Compose閰嶇疆鏂囦欢鎬庝箞鍐欙紝浠庡熀纭€鍒拌繘闃讹紝鎵嬫妸鎵嬫暀浣犵敤docker-compose.yml绠＄悊澶氬鍣�"
tags: ["Docker Compose", "Docker", "瀹瑰櫒绠＄悊", "NAS", "杩涢樁鏁欑▼"]
slug: "docker-compose-advanced-guide"
---

# Docker Compose 杩涢樁锛氬浣曠敤閰嶇疆鏂囦欢绠＄悊澶嶆潅瀹瑰櫒鐜

寰堝浜虹敤Docker鍙細`docker run`涓€涓釜鍚姩瀹瑰櫒锛屼粖澶╂暀浣犳€庝箞鐢―ocker Compose閰嶇疆鏂囦欢鏉ョ鐞嗕竴鏁村鏈嶅姟銆�

## 涓轰粈涔堣鐢–ompose

鎯宠薄涓€涓嬩綘瑕侀儴缃蹭竴涓搴奖闄㈢郴缁燂細Jellyfin銆乹bittorrent銆丼onarr銆丷adarr鈥︹€︿竴涓竴涓惎鍔ㄥ緢楹荤儲锛岀敤Compose鍙渶瑕佷竴涓猔docker-compose.yml`鏂囦欢锛屼竴鏉″懡浠ゅ叏鍚姩銆�

## 鍩虹閰嶇疆鎬庝箞鍐�

```yaml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    volumes:
      - ./config:/config
      - /mnt/media:/media
    ports:
      - "8096:8096"
    restart: unless-stopped
```

淇濆瓨涓篳docker-compose.yml`锛屽湪鍚岀骇鐩綍鎵ц`docker-compose up -d`锛屽鍣ㄥ氨鍚姩浜嗐€�

## 杩涢樁鎶€宸у垎浜�

### 1. 鐜鍙橀噺绠＄悊
鐢╜.env`鏂囦欢瀛樺偍鏁忔劅淇℃伅锛岄厤缃噷鐢╜${鍙橀噺鍚峿`璋冪敤锛岄伩鍏嶆妸瀵嗙爜鍐欒繘閰嶇疆鏂囦欢銆�

### 2. 缃戠粶闅旂
涓嶅悓椤圭洰鐢ㄤ笉鍚岀綉缁滄锛岄伩鍏岻P鍐茬獊锛�

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### 3. 鍋ュ悍妫€鏌�
缁欏叧閿湇鍔″姞鍋ュ悍妫€鏌ワ紝瀹瑰櫒鎸備簡浼氳嚜鍔ㄩ噸鍚細

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8096"]
  interval: 30s
  timeout: 10s
  retries: 3
```

## 甯歌鍧戠偣

- 绔彛鍐茬獊锛氬厛`docker ps`妫€鏌ュ摢涓鍙ｈ鍗犵敤浜�
- 璺緞鍐欓敊锛氬缓璁敤缁濆璺緞鎴栬€呯敤`${PWD}`纭繚璺緞姝ｇ‘
- 鏉冮檺闂锛氭湁浜涘鍣ㄩ渶瑕佺壒瀹氱敤鎴锋潈闄愶紝璁板緱鍔燻user: "1000:1000"`

鏇村Docker鍜孨AS鏁欑▼锛屽彲浠ュ幓nucnas.top鐪嬬湅锛岄噷闈㈡湁璇︾粏鐨勬楠ゆ埅鍥俱€�

---

*鏈夐棶棰樿瘎璁哄尯瑙併€�*
