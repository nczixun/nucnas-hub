---
title: "Docker Compose 鏉╂盯妯侀弫娆戔柤閿涙瓊AS 娑撳﹥澧� docker-compose.yml 閸愭瑦纭�"
date: 2026-03-08
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
platform: "docker"
slug: "docker-compose-advanced-guide-2026"
tags: ["Docker Compose", "NAS", "Docker", "鐎圭懓娅�", "鏉╂盯妯侀弫娆戔柤"]
---

# Docker Compose 鏉╂盯妯侀弫娆戔柤閿涙瓊AS 娑撳﹥澧� docker-compose.yml 閸愭瑦纭�

娴兼氨鏁� Docker 娴ｅ棔绗夋禍鍡毿� Docker Compose閿涚喕绻栫弧鍥ㄦ瀮缁旂姵澧滈幎濠冨閺佹瑤缍橀悽锟� docker-compose 缁狅紕鎮� NAS 娑撳﹦娈戦張宥呭閵嗭拷

## 娴犫偓娑斿牊妲� Docker Compose閿涳拷

Docker Compose 閺勶拷 Docker 鐎规ɑ鏌熼幓鎰返閻ㄥ嫬顔愰崳銊х椽閹烘帒浼愰崗鍑ょ礉闁俺绻冩稉鈧稉锟� `docker-compose.yml` 閺傚洣娆㈢€规矮绠熸径姘嚋鐎圭懓娅掗敍灞肩闁款喖鎯庨崝銊ｂ偓浣镐粻濮濃偓鈧礁顦禒濮愨偓锟�

**鐎佃鐦导鐘电埠 Docker 閸涙垝鎶ら敍锟�**
- 娴肩姷绮洪敍姘娑擃亜顔愰崳銊ょ閺夆€虫嚒娴犮倧绱濇径宥嗘絽
- Compose閿涙矮绔存稉顏呮瀮娴犲墎顓搁幍鈧張澶涚礉缁犫偓閸楋拷

## 韫囶偊鈧喎绱戞慨锟�

### 1. 鐎瑰顥� Docker Compose

```bash
# Docker Desktop 閼奉亜鐢�
# 缂囥倖娅€閿涙艾顨滄禒鏈佃厬韫囧啫鐣ㄧ憗锟� Docker
# 缂佽儻浠�/閺嬩胶鈹栭梻杈剧窗鎼存梻鏁ゆ稉顓炵妇娑撯偓闁款喖鐣ㄧ憗锟�
# 妤犲矁鐦夌€瑰顥�
docker compose version
```

### 2. 閸掓稑缂� docker-compose.yml

閸︼拷 NAS 娑撳﹥鏌婂鐑樻瀮娴犺泛銇欓敍灞肩伐婵★拷 `/docker/jellyfin`閿涘本鏌婂锟� `docker-compose.yml`閿涳拷

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    ports:
      - "8096:8096"
      - "8920:8920"
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /volume1/media:/media:ro
    environment:
      - TZ=Asia/Shanghai
      - JELLYFIN_PublishedServerUrl=http://your-nas-ip:8096
```

### 3. 閸氼垰濮╅張宥呭

```bash
# 鏉╂稑鍙嗛惄顔肩秿
cd /docker/jellyfin

# 閸氼垰濮╅幍鈧張澶嬫箛閸旓拷
docker compose up -d

# 閺屻儳婀呴悩鑸碘偓锟�
docker compose ps

# 閺屻儳婀呴弮銉ョ箶
docker compose logs -f
```

## 鏉╂盯妯侀柊宥囩枂

### 婢舵艾顔愰崳銊х椽閹猴拷

娑撯偓娑擃亝鏋冩禒鍓侇吀閻炲棗顦挎稉顏呮箛閸斺槄绱�

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    ports:
      - "8096:8096"
    volumes:
      - ./jellyfin/config:/config
      - /volume1/media:/media:ro

  alist:
    image: xhofe/alist:latest
    container_name: alist
    restart: unless-stopped
    ports:
      - "5244:5244"
    volumes:
      - ./alist:/opt/alist/data
    environment:
      - TZ=Asia/Shanghai
```

### 閻滎垰顣ㄩ崣姗€鍣洪弬鍥︽

閺傛澘缂� `.env` 閺傚洣娆㈤敍锟�

```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

閸︼拷 compose 娑擃厼绱╅悽顭掔窗

```yaml
environment:
  - TZ=${TZ}
  - PUID=${PUID}
```

### 缂冩垹绮堕柊宥囩枂

```yaml
networks:
  nas_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24

services:
  app:
    networks:
      - nas_network
```

### 閸嬨儱鎮嶅Λ鈧弻锟�

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
```

### 鐠у嫭绨梽鎰煑

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 4G
        reservations:
          cpus: '0.5'
          memory: 512M
```

## 鐢摜鏁ら崨鎴掓姢

| 閸涙垝鎶� | 鐠囧瓨妲� |
| :--- | :--- |
| `docker compose up -d` | 閸氬骸褰撮崥顖氬З |
| `docker compose down` | 閸嬫粍顒涢獮璺哄灩闂勶拷 |
| `docker compose restart` | 闁插秴鎯� |
| `docker compose logs -f` | 閺屻儳婀呴弮銉ョ箶 |
| `docker compose pull` | 閺囧瓨鏌婇梹婊冨剼 |
| `docker compose up -d --force-recreate` | 瀵搫鍩楅柌宥呯紦 |
| `docker compose config` | 妤犲矁鐦夐柊宥囩枂 |

## 婢跺洣鍞ゆ稉搴ょ讣缁夛拷

### 婢跺洣鍞�

```bash
# 婢跺洣鍞ら柊宥囩枂閺傚洣娆�
tar -czvf backup.tar.gz ./config .env docker-compose.yml
```

### 鏉╀胶些

```bash
# 婢跺秴鍩楅弫缈犻嚋閺傚洣娆㈡径鐟板煂閺傛媽顔曟径锟�
# 闁插秵鏌婇崥顖氬З
docker compose up -d
```

## 鐢瓕顫嗛梻顕€顣�

**Q閿涙氨顏崣锝呭暱缁愪焦鈧簼绠為崝鐑囩吹**
A閿涙矮鎱ㄩ弨锟� ports 闁劌鍨庨惃鍕瑝閸氬瞼顏崣锝嗘Ё鐏忓嫨鈧拷

**Q閿涙艾顩ф担鏇熸纯閺傛澘顔愰崳顭掔吹**
A閿涙瓪docker compose pull` 閻掕泛鎮� `docker compose up -d`閵嗭拷

**Q閿涙碍鏆熼幑顔碱洤娴ｆ洘瀵旀稊鍛閿涳拷**
A閿涙矮濞囬悽锟� volumes 閹稿倽娴囩€瑰じ瀵岄張铏规窗瑜版洏鈧拷

**Q閿涙艾顔愰崳銊ユ儙閸斻劌銇戠拹銉吹**
A閿涙瓪docker compose logs` 閺屻儳婀呴柨娆掝嚖娣団剝浼呴妴锟�

## 閹恒劏宕樼紒鍕値

- **瑜伴亶鐓舵稉顓炵妇**閿涙ellyfin + QBittorrent + Alist
- **娑撳娴囬張锟�**閿涙瓐Bittorrent + Transmission + Alist
- **HomeLab**閿涙dGuard + Nginx Proxy Manager + Portainer

## 閹崵绮�

Docker Compose 閺勵垳顓搁悶锟� NAS 鐎圭懓娅掗惃鍕殻閸ｃ劊鈧倷绔存稉顏呮瀮娴犲墎顓搁幍鈧張澶涚礉閸愬秳绡冩稉宥嗏偓鏇烆啇閸ｃ劋璐＄捄鎴欌偓鍌涘笁閹宦ょ箹娴滄稒濡у褝绱濇担鐘垫畱 NAS 鏉╂劗娣懗钘夊娴兼碍褰侀崡鍥︾娑擃亝銆傚▎掳鈧拷