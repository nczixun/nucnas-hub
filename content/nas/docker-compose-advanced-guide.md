---
title: "Docker Compose 鏉╂盯妯侀敍姘洤娴ｆ洜鏁ら柊宥囩枂閺傚洣娆㈢粻锛勬倞婢跺秵娼呯€圭懓娅掗悳顖氼暔"
date: 2026-03-08
categories: ["nas"]
summary: "Docker Compose闁板秶鐤嗛弬鍥︽閹簼绠為崘娆欑礉娴犲骸鐔€绾偓閸掓媽绻橀梼璁圭礉閹靛濡搁幍瀣殌娴ｇ姷鏁ocker-compose.yml缁狅紕鎮婃径姘啇閸ｏ拷"
tags: ["Docker Compose", "Docker", "鐎圭懓娅掔粻锛勬倞", "NAS", "鏉╂盯妯侀弫娆戔柤"]
slug: "docker-compose-advanced-guide"
---

# Docker Compose 鏉╂盯妯侀敍姘洤娴ｆ洜鏁ら柊宥囩枂閺傚洣娆㈢粻锛勬倞婢跺秵娼呯€圭懓娅掗悳顖氼暔

瀵板牆顦挎禍铏规暏Docker閸欘亙绱癭docker run`娑撯偓娑擃亙閲滈崥顖氬З鐎圭懓娅掗敍灞肩矕婢垛晜鏆€娴ｇ姵鈧簼绠為悽鈥昽cker Compose闁板秶鐤嗛弬鍥︽閺夈儳顓搁悶鍡曠閺佹潙顨滈張宥呭閵嗭拷

## 娑撹桨绮堟稊鍫ｎ洣閻⑩€搊mpose

閹疇钖勬稉鈧稉瀣╃稑鐟曚線鍎寸純韫娑擃亜顔嶆惔顓炲闂勩垻閮寸紒鐕傜窗Jellyfin閵嗕构bittorrent閵嗕讣onarr閵嗕阜adarr閳ワ腹鈧缚绔存稉顏冪娑擃亜鎯庨崝銊ョ发妤硅崵鍎查敍宀€鏁ompose閸欘亪娓剁憰浣风娑撶寯docker-compose.yml`閺傚洣娆㈤敍灞肩閺夆€虫嚒娴犮倕鍙忛崥顖氬З閵嗭拷

## 閸╄櫣顢呴柊宥囩枂閹簼绠為崘锟�

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

娣囨繂鐡ㄦ稉绡砫ocker-compose.yml`閿涘苯婀崥宀€楠囬惄顔肩秿閹笛嗩攽`docker-compose up -d`閿涘苯顔愰崳銊ユ皑閸氼垰濮╂禍鍡愨偓锟�

## 鏉╂盯妯侀幎鈧褍鍨庢禍锟�

### 1. 閻滎垰顣ㄩ崣姗€鍣虹粻锛勬倞
閻⑩暅.env`閺傚洣娆㈢€涙ê鍋嶉弫蹇斿妳娣団剝浼呴敍宀勫帳缂冾噣鍣烽悽鈺�${閸欐﹢鍣洪崥宄縛鐠嬪啰鏁ら敍宀勪缉閸忓秵濡哥€靛棛鐖滈崘娆掔箻闁板秶鐤嗛弬鍥︽閵嗭拷

### 2. 缂冩垹绮堕梾鏃傤瀲
娑撳秴鎮撴い鍦窗閻€劋绗夐崥宀€缍夌紒婊勵唽閿涘矂浼╅崗宀籔閸愯尙鐛婇敍锟�

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### 3. 閸嬨儱鎮嶅Λ鈧弻锟�
缂佹瑥鍙ч柨顔芥箛閸斺€冲閸嬨儱鎮嶅Λ鈧弻銉礉鐎圭懓娅掗幐鍌欑啊娴兼俺鍤滈崝銊╁櫢閸氼垽绱�

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8096"]
  interval: 30s
  timeout: 10s
  retries: 3
```

## 鐢瓕顫嗛崸鎴犲仯

- 缁旑垰褰涢崘鑼崐閿涙艾鍘沗docker ps`濡偓閺屻儱鎽㈡稉顏嗩伂閸欙綀顫﹂崡鐘垫暏娴滐拷
- 鐠侯垰绶為崘娆撴晩閿涙艾缂撶拋顔炬暏缂佹繂顕捄顖氱窞閹存牞鈧懐鏁${PWD}`绾喕绻氱捄顖氱窞濮濓絿鈥�
- 閺夊啴妾洪梻顕€顣介敍姘箒娴滄稑顔愰崳銊╂付鐟曚胶澹掔€规氨鏁ら幋閿嬫綀闂勬劧绱濈拋鏉跨繁閸旂嚮user: "1000:1000"`

閺囨潙顦緿ocker閸滃AS閺佹瑧鈻奸敍灞藉讲娴犮儱骞搉ucnas.top閻婀呴敍宀勫櫡闂堛垺婀佺拠锔剧矎閻ㄥ嫭顒炴銈嗗焻閸ヤ勘鈧拷

---

*閺堝妫舵０妯跨槑鐠佸搫灏憴浣碘偓锟�*
