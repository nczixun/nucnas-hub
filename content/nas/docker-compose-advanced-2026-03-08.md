---
title: "Docker Compose 鏉╂盯妯侀敍姘樋鐎圭懓娅掔紓鏍ㄥ笓鐎圭偞鍨幐鍥у础"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 鐎涳箓娅�"]
tags: ["Docker", "Docker Compose", "NAS", "鐎圭懓娅掔紓鏍ㄥ笓", "閼奉亜濮╅崠锟�", "閺佹瑧鈻�"]
draft: false
---

娴兼氨鏁� Docker 娴ｅ棔绗夐悢鐔稿€� Compose閿涚喕绻栫弧鍥х敨娴ｇ姾绻橀梼韬测偓鍌氼劅娴硷拷 docker-compose閿涘奔绔撮柨顔绢吀閻炲棙澧嶉張澶婎啇閸ｃ劊鈧拷

## 娑撹桨绮堟稊鍫㈡暏 Docker Compose閿涳拷

閹靛濮� docker run 濮ｅ繑顐奸柈鍊燁洣閺佽弓绔撮崼鍡楀棘閺佸府绱濈€圭懓娅掓径姘啊閺嶈婀扮拋棰佺瑝娴ｅ繈鈧景ompose 閻拷 YAML 閺傚洣娆㈢€规矮绠熼張宥呭閿涘瞼澧楅張顒佸付閸掕翰鈧浇绺肩粔姹団偓浣割槵娴犱粙鍏橀弬閫涚┒閵嗭拷

## 閸╄櫣顢呯紒鎾寸€�

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

## 鏉╂盯妯侀幎鈧锟�

### 1. 閻滎垰顣ㄩ崣姗€鍣虹粻锛勬倞

閸掓稑缂� `.env` 閺傚洣娆㈤敍锟�

```bash
# .env
POSTGRES_PASSWORD=your_secure_password
DATA_PATH=/mnt/storage
```

Compose 閼奉亜濮╃拠璇插絿閿涳拷

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ${DATA_PATH}/postgres:/var/lib/postgresql/data
```

### 2. 缂冩垹绮堕梾鏃傤瀲

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
    internal: true  # 鐎瑰苯鍙忛梾鏃傤瀲
```

### 3. 閸嬨儱鎮嶅Λ鈧弻锟�

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

### 4. 娓氭繆绂嗛崗宕囬兇

```yaml
services:
  web:
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

## 鐢摜鏁ら崨鎴掓姢

```bash
# 閸氼垰濮╅幍鈧張澶嬫箛閸旓拷
docker-compose up -d

# 閺屻儳婀呴弮銉ョ箶
docker-compose logs -f

# 閺囧瓨鏌婇梹婊冨剼
docker-compose pull
docker-compose up -d

# 閸嬫粍顒涢幍鈧張澶嬫箛閸旓拷
docker-compose down
```

## 閹存垹娈� NAS 闁板秶鐤嗛崚鍡曢煩

鏉╂瑦妲搁幋鎴犳窗閸撳秴婀悽銊ф畱闁劌鍨庨柊宥囩枂閿涳拷

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

## 閹崵绮�

Docker Compose 閻喓娈戦弰顖滄暏娴滃棗姘ㄩ崶鐐扮瑝閸樻眹鈧倿鍘ょ純顔荤濞嗏槄绱濇稉瀣偧瀵偓閺堣桨绔撮柨顔兼儙閸斻劍澧嶉張澶嬫箛閸斅扳偓鍌氱紦鐠侇喖銇囩€瑰爼鍏橀懞杈ㄦ闂傛潙顒熸稉鈧稉瀣剁礉閻喓娈戦懗鐣屾阜瀵板牆顦块崝鐔枫亱閵嗭拷

---
*濞村鐦悳顖氼暔閿涙氨鍏㈤弲锟� DS920+ Docker 24.0*
