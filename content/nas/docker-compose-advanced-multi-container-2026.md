---
title: "Docker Compose 閺夆晜鐩Ο渚€鏁嶅顒夋▼閻庡湱鎳撳▍鎺旂磽閺嶃劌绗撻悗鍦仦閸剟骞愰崶褍纭€"
date: 2026-03-08
categories: ["nas"]
brand: "闂侇偅姘ㄩ弫锟�"
model: "Docker"
platform: "nas"
slug: "docker-compose-advanced-multi-container-2026"
tags: ["Docker Compose", "NAS", "閻庡湱鎳撳▍鎺旂磽閺嶃劌绗�", "Docker 闁轰焦鐟ч埢锟�", "閻庣娉涘☉浣冦亹闁秵鐝�"]
---

# Docker Compose 閺夆晜鐩Ο渚€鏁嶅顒夋▼閻庡湱鎳撳▍鎺旂磽閺嶃劌绗撻悗鍦仦閸剟骞愰崶褍纭€

鐎垫澘鐗嗛ˇ鍧楁偝閳轰緡鍟€闁革讣鎷� NAS 濞戞挸锕崕瀵哥磾閹绘帒绀嬪☉鎿冧簻椤旀劙宕抽妸銉у彂缂佺姭鍋撻柛妤佹穿缁辨繃鎷呴崱娑欐〃閻庣數鎳撻ˇ璺ㄢ偓鍦嚀濞呮帡鎳曢弬鍨楅悘蹇氫含婵鲸绂嶉崱娑欘嚊闁靛棗鍊风划鏍ㄥ緞閳哄嫷鍞归悹渚婃嫹 Docker Compose 閺夆晜鐩Ο渚€鎮抽埡鍌溿€婇柨娑樼焷椤斺偓濞达絿濮炬禍銈夊级閹呮澖闁绘粍婢橀ˇ鏌ュ级閸屾稒绠涢柛鏂哄墲閻忥箓寮搁崟鈹惧亾閿燂拷

## 濞戞捁妗ㄧ划鍫熺▕閸綆娲ｉ柣顫嫹 Docker Compose

闁归潧顑呮慨鈺冪不閿涘嫭鍊炲鑸电煯闁叉粎鈧湱鎳撳▍鎺楀籍鐠佸湱绀夊ù锝囧Т瑜版煡鎳楁禒瀣╂捣闁告帗濯界换鏍ㄧ濞戙垺锛栧Λ鐗堬公缁憋拷
- 閻庡湱鎳撳▍鎺楀触椤栨艾袟濡炪倕鎼花顓炃庨摎鍌濈闁挎稑鑻閬嶆嚊鐎涙ɑ绠涢柛鏂衡偓鑼憹闁告瑯鍨抽弫锟�
- 闁绘粠鍨伴。銊╁矗濮椻偓閸ｈ櫣鈧顫夊Σ妤冩媼妤ｅ啯鏅�
- 闁哄洤鐡ㄩ弻濠囨偋閸喐鎷遍悷鏇氭缁斿瓨绋夐鍐殝闁衡偓閿燂拷
- 缂佹棏鍨拌ぐ娑㈠礃閼碱剛宕愰柟闈涘綖缁楀宕氶弶鍨枾闁搞儻鎷�

Docker Compose 闂侇偅淇虹换锟� YAML 闁哄倸娲ｅ▎銏㈢磼閻斿墎顏辩紒鐙呯磿閹﹪鏁嶇仦鑲╊伇婵炲棌鈧櫕鍎欓柛鏂诲妼閸欏繘鏌堥妸锔藉仩閻庤鍝庨埀顒婃嫹

## 缂備礁绻愰崥鈧柛锔惧劋濞呮瑩鏁嶅顒夊晙閹兼惌鍘兼總鏍⒔閵忕姴寮块悗纭呭煐閵嗭拷

閺夆晜鐟﹀Σ鍛婄▔閳ь剚绋夐鍕倎闁搞劌顑囧▓鎴炲緞濮橆剦鍟囬柛锝冨妽閻忥箓寮搁崟鍓佺獥

```yaml
version: '3.8'

services:
  # 閻熸瑥妫濋。鍓佺不閿涘嫭鍊�
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    network_mode: host
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/media:/media:ro
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped

  # 鐟滄媽浜晶鏍礆椤旂厧顤€
  jellyseerr:
    image: fallenbagel/jellyseerr:latest
    container_name: jellyseerr
    ports:
      - "5055:5055"
    environment:
      - LOG_LEVEL=debug
      - TZ=Asia/Shanghai
    volumes:
      - ./jellyseerr:/app
    depends_on:
      - jellyfin
    restart: unless-stopped

  # 濞戞挸顑堝ù鍥ь啅閵夈儱寰�
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    ports:
      - "6881:6881"
      - "6881:6881/udp"
    volumes:
      - ./qbittorrent:/config
      - /mnt/downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
    restart: unless-stopped

  # 濠殿垱甯婄紞瀣极鐎靛憡鍊�
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: radarr
    ports:
      - "7878:7878"
    volumes:
      - ./radarr:/config
      - /mnt/media:/media
      - /mnt/downloads:/downloads
    environment:
      - PUID=1000
      - PGID=1000
    restart: unless-stopped

networks:
  default:
    name: media_network
```

## 闁稿繑濞婇弫顓㈡煀瀹ュ洨鏋傞悷娆欑稻閻庯拷

### depends_on闁挎稒纰嶇敮鍫曞礆鐠虹儤鍎欓柛鏂诲姂閵嗗孩鎯旈敓锟�
Jellyseerr 濞撴碍绻嗙粋锟� Jellyfin闁挎稑鑻幃妤呮嚀閸涱厽韬柛鎾崇Ч濞间即宕楅崼婵囧剻闁告柣鍔婇埀顒€鍊风粭澶嬫交閸ヮ亶娲ｆ繛澶堝妽閸撲即鏁嶅畝鍐闁告瑯浜濆Σ锟�"闁告凹鍨版慨鈺傘亜閸濆嫮纰�"闁挎稑濂旂粭澶愬及閿燂拷"閻忓繗浜崡搴€亜閸濆嫮纰�"闁靛棗鍊婚弫鎾寸瑜忛獮鍡樻櫠閸愩劎绱﹂悹渚囧枤閺併倝宕戦妷銉﹀€ｆ俊顐熷亾闁哄被鍎埀顒婃嫹

### network_mode: host vs bridge
Jellyfin 闁活澁鎷� host 婵☆垪鈧磭纭€闁哄嫷鍨拹鐔哥閸℃艾绠柛娆愮墪閸ｎ垳娑甸鐐暠婵炴挳鏀辨慨銈嗘櫠濞嗗秮鍋撴穱绯眎ttorrent 闁告粣鎷� radarr 闁活澁鎷� bridge 婵☆垪鈧磭纭€闁挎稑鐬奸顒勫矗閿濆顓剧紒鍌滅帛濞茶法鈧懓顦崣蹇涘Υ閿燂拷

### PUID/PGID闁挎稒纰嶅ḿ鍫ユ⒔閹扮増锛栧Λ甯嫹
NAS 濞戞挸锕﹀▓鎴犫偓鍦嚀濞呮帞绱掕箛鎾跺煑闂侇剙娲ら崺宀勫级閸愵喗顎欓梻鍌ゅ櫍椤ｄ粙濡撮崒鐐╁亾濮樺磭绠� PUID=1000闁挎稑鐗呯紞姗€鎯冮崟顓熸殢闁瑰墨D闁挎稑顦幏锟� PGID=1000 缁绢収鍠曠换姘跺棘閸ワ附顐介悹鍥嚙閸熸挸顫㈤敐鍛煑闁靛棴鎷�

## 閺夆晜鐩Ο渚€骞庨埀顒€顔忛敓锟�

### 1. 濞达綀娉曢弫锟� .env 闁哄倸娲ｅ▎銏㈢不閿涘嫭鍊為柛娆愶耿閸ｏ拷
闁告帗绋戠紓锟� .env 闁哄倸娲ｅ▎銏ゆ晬閿燂拷
```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

闁绘帟娉涢幃妤呭捶閿燂拷 compose 濞戞搩鍘肩槐鈺呮偨椤帞绐梎${PUID}`

### 2. 闁稿鍎遍幃宥呂涢埀顒勫蓟閵夆晛甯崇紓鍐挎嫹
```yaml
services:
  jellyfin:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8097/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### 3. 闂佹彃绉撮幆搴ｇ驳閺嶎偅娈�
- `no`闁挎稒鐭粭澶愭嚊椤忓嫬袟闂佹彃绉撮幆锟�
- `on-failure`闁挎稒鑹鹃妵鎴犳嫻閵夛附顦ч梺鎻掔Т閹拷
- `unless-stopped`闁挎稒宀稿▍搴ㄦ閻愭潙顤侀柛鏂诲妼娴犵姴顫㈤～顔剧闁告熬绠戦崹顖涚▔閳ь剟鎯勯幘顔兼闁告熬鎷�
- `always`闁挎稒纰嶉埀顒傜帛濡叉悂鏌屽鍛剻闁挎稑鐗婄敮褰掓嚒閹邦喗鏆忓ù婊愭嫹 NAS闁挎冻鎷�

## 濞戞挴鍋撻梺娆惧枛閹酣宕濋妸銉﹀殥濞寸媴鎷�

```bash
# 闁告凹鍨版慨鈺呭箥閳ь剟寮垫径瀣疀闁告棑鎷�
docker compose up -d

# 闁哄被鍎冲﹢鍛村籍閵夈儳绠�
docker compose logs -f jellyfin

# 闁哄洤鐡ㄩ弻濠囧箥閳ь剟寮垫径鎰當闁稿稄鎷�
docker compose pull && docker compose up -d

# 闁稿绮嶉娑㈠箥閳ь剟寮垫径瀣疀闁告棑鎷�
docker compose down
```

闁瑰搫鏈ぐ锟� Docker Compose 闁告艾鍑界槐婵囨媴閻樻彃璁插ù鐘劥娴溿倝寮堕悙顒佸剹鐎点倧鎷� PLEX + Sonarr + Radarr + QBittorrent 闁汇劌瀚粭鍛姜閽樺鐒块柛鎾筹梗缁旀挳寮堕敓鐘电儲闁挎稑鏈崹銊╂嚀閿燂拷 Home Assistant + Node-RED + InfluxDB 闁汇劌瀚▍銈夋嚄閽樺鍟€閻忕偛鎳庨柦鈺呭矗閼割兘鍋撻崒姘兼Щ闁哄鍊瑰﹢鍥礉閳藉懐绀夊☉鎾亾婵炲棴绻濋崕瀵哥磾鐠囇呯闂傗偓閹稿孩鍩傞柛娆愵殘濞夘參濡撮敓锟�