---
title: "Docker Compose 閺夆晜鐩Ο渚€寮▎鎴旀煠闁挎稒鐡夾S 濞戞挸锕ユ晶锟� docker-compose.yml 闁告劖鐟︾涵锟�"
date: 2026-03-08
categories: ["nas"]
brand: "Docker"
model: "Docker Compose"
platform: "docker"
slug: "docker-compose-advanced-guide-2026"
tags: ["Docker Compose", "NAS", "Docker", "閻庡湱鎳撳▍锟�", "閺夆晜鐩Ο渚€寮▎鎴旀煠"]
---

# Docker Compose 閺夆晜鐩Ο渚€寮▎鎴旀煠闁挎稒鐡夾S 濞戞挸锕ユ晶锟� docker-compose.yml 闁告劖鐟︾涵锟�

濞村吋姘ㄩ弫锟� Docker 濞达絽妫旂粭澶嬬閸℃锟� Docker Compose闁挎稓鍠曠换鏍姬閸ャ劍鐎紒鏃傚У婢ф粓骞庢繝鍐杹闁轰焦鐟ょ紞姗€鎮介敓锟� docker-compose 缂佺媴绱曢幃锟� NAS 濞戞挸锕﹀▓鎴﹀嫉瀹ュ懎顫ら柕鍡嫹

## 濞寸姭鍋撳☉鏂跨墛濡诧拷 Docker Compose闁挎冻鎷�

Docker Compose 闁哄嫸鎷� Docker 閻庤蓱閺岀喖骞撻幇顏嗚繑闁汇劌瀚鎰板闯閵娧呮そ闁圭儤甯掓导鎰板礂閸戙倗绀夐梺顐ｄ亢缁诲啯绋夐埀顒佺▔閿燂拷 `docker-compose.yml` 闁哄倸娲ｅ▎銏⑩偓瑙勭煯缁犵喐寰勫顐﹀殝閻庡湱鎳撳▍鎺楁晬鐏炶偐顏遍梺娆惧枛閹酣宕濋妸锝傚亾娴ｉ晲绮绘慨婵冨亾閳ь兛绀侀ˇ顒佺婵劏鍋撻敓锟�

**閻庝絻顫夐惁顔藉閻樼數鍩� Docker 闁告稒鍨濋幎銈夋晬閿燂拷**
- 濞磋偐濮风划娲晬濮橆偆顏卞☉鎿冧簻椤旀劙宕抽妸銈囶伇闁哄鈧櫕鍤掑ù鐘€х槐婵囧緞瀹ュ棙绲�
- Compose闁挎稒鐭粩瀛樼▔椤忓懏鐎ù鐘插椤撴悂骞嶉埀顒勫嫉婢舵稓绀夌紒鐘亾闁告鎷�

## 闊浂鍋婇埀顒傚枎缁辨垶鎱ㄩ敓锟�

### 1. 閻庣懓顦抽ˉ锟� Docker Compose

```bash
# Docker Desktop 闁煎浜滈悽锟�
# 缂傚洢鍊栧▍鈧柨娑欒壘椤ㄦ粍绂掗張浣冨幀闊洤鍟悾銊ф啑閿燂拷 Docker
# 缂備浇鍎绘禒锟�/闁哄鑳堕埞鏍⒒鏉堝墽绐楅幖瀛樻⒒閺併倖绋夐鐐靛濞戞挴鍋撻梺娆惧枛閻ｃ劎鎲楅敓锟�
# 濡ょ姴鐭侀惁澶屸偓鐟邦槼椤ワ拷
docker compose version
```

### 2. 闁告帗绋戠紓锟� docker-compose.yml

闁革讣鎷� NAS 濞戞挸锕ラ弻濠傤嚈閻戞ɑ鐎ù鐘烘硾閵囨瑩鏁嶇仦鑲╀紣濠碘槄鎷� `/docker/jellyfin`闁挎稑鏈弻濠傤嚈閿燂拷 `docker-compose.yml`闁挎冻鎷�

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

### 3. 闁告凹鍨版慨鈺呭嫉瀹ュ懎顫�

```bash
# 閺夆晜绋戦崣鍡涙儎椤旇偐绉�
cd /docker/jellyfin

# 闁告凹鍨版慨鈺呭箥閳ь剟寮垫径瀣疀闁告棑鎷�
docker compose up -d

# 闁哄被鍎冲﹢鍛存偐閼哥鍋撻敓锟�
docker compose ps

# 闁哄被鍎冲﹢鍛村籍閵夈儳绠�
docker compose logs -f
```

## 閺夆晜鐩Ο渚€鏌婂鍥╂瀭

### 濠㈣埖鑹鹃鎰板闯閵娧呮そ闁圭尨鎷�

濞戞挴鍋撳☉鎿冧簼閺嬪啯绂掗崜渚囧悁闁荤偛妫楅ˇ鎸庣▔椤忓懏绠涢柛鏂烘缁憋拷

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

### 闁绘粠鍨伴。銊╁矗濮椻偓閸ｆ椽寮崶锔筋偨

闁哄倹婢樼紓锟� `.env` 闁哄倸娲ｅ▎銏ゆ晬閿燂拷

```
TZ=Asia/Shanghai
PUID=1000
PGID=1000
```

闁革讣鎷� compose 濞戞搩鍘肩槐鈺呮偨椤帞绐�

```yaml
environment:
  - TZ=${TZ}
  - PUID=${PUID}
```

### 缂傚啯鍨圭划鍫曟煀瀹ュ洨鏋�

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

### 闁稿鍎遍幃宥呂涢埀顒勫蓟閿燂拷

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

### 閻犙冨缁噣姊介幇顒€鐓�

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

## 閻㈩垰鎽滈弫銈夊川閹存帗濮�

| 闁告稒鍨濋幎锟� | 閻犲洤鐡ㄥΣ锟� |
| :--- | :--- |
| `docker compose up -d` | 闁告艾楠歌ぐ鎾触椤栨艾袟 |
| `docker compose down` | 闁稿绮嶉娑㈢嵁鐠哄搫鐏╅梻鍕舵嫹 |
| `docker compose restart` | 闂佹彃绉撮幆锟� |
| `docker compose logs -f` | 闁哄被鍎冲﹢鍛村籍閵夈儳绠� |
| `docker compose pull` | 闁哄洤鐡ㄩ弻濠囨⒐濠婂啫鍓� |
| `docker compose up -d --force-recreate` | 鐎殿喖鎼崺妤呮煂瀹ュ懐绱� |
| `docker compose config` | 濡ょ姴鐭侀惁澶愭煀瀹ュ洨鏋� |

## 濠㈣泛娲ｉ崬銈嗙▔鎼淬倗璁ｇ紒澶涙嫹

### 濠㈣泛娲ｉ崬锟�

```bash
# 濠㈣泛娲ｉ崬銈夋煀瀹ュ洨鏋傞柡鍌氭矗濞嗭拷
tar -czvf backup.tar.gz ./config .env docker-compose.yml
```

### 閺夆晙鑳朵簺

```bash
# 濠㈣泛绉撮崺妤呭极缂堢娀鍤嬮柡鍌氭矗濞嗐垺寰勯悷鏉跨厒闁哄倹濯介鏇熷緞閿燂拷
# 闂佹彃绉甸弻濠囧触椤栨艾袟
docker compose up -d
```

## 閻㈩垱鐡曢～鍡涙⒒椤曗偓椤ｏ拷

**Q闁挎稒姘ㄩ顒勫矗閿濆懎鏆辩紒鎰劍閳ь剙绨肩粻鐐哄礉閻戝洨鍚�**
A闁挎稒鐭幈銊╁绩閿燂拷 ports 闂侇喓鍔岄崹搴ㄦ儍閸曨亞鐟濋柛姘灱椤忣剟宕ｉ敐鍡樞侀悘蹇撳閳ь剨鎷�

**Q闁挎稒鑹鹃々褎鎷呴弴鐔哥函闁哄倹婢橀鎰板闯椤帞鍚�**
A闁挎稒鐡猟ocker compose pull` 闁绘帟娉涢幃锟� `docker compose up -d`闁靛棴鎷�

**Q闁挎稒纰嶉弳鐔煎箲椤旂⒈娲ゅù锝嗘礃鐎垫梹绋婇崨顓烆嚙闁挎冻鎷�**
A闁挎稒鐭繛鍥偨閿燂拷 volumes 闁圭ǹ鍊藉ù鍥┾偓鐟般仒鐎靛矂寮甸搹瑙勭獥鐟滅増娲忛埀顒婃嫹

**Q闁挎稒鑹鹃鎰板闯閵娿儲鍎欓柛鏂诲妼閵囨垹鎷归妷顖滃惞**
A闁挎稒鐡猟ocker compose logs` 闁哄被鍎冲﹢鍛存煥濞嗘帩鍤栧ǎ鍥ｅ墲娴煎懘濡撮敓锟�

## 闁规亽鍔忓畷妯肩磼閸曨偅鍊�

- **鐟滀即浜堕悡鑸电▔椤撶偟濡�**闁挎稒顑榚llyfin + QBittorrent + Alist
- **濞戞挸顑堝ù鍥嫉閿燂拷**闁挎稒鐡怋ittorrent + Transmission + Alist
- **HomeLab**闁挎稒顑媎Guard + Nginx Proxy Manager + Portainer

## 闁诡剝宕电划锟�

Docker Compose 闁哄嫷鍨抽鎼佹偠閿燂拷 NAS 閻庡湱鎳撳▍鎺楁儍閸曨収娈婚柛锝冨妸閳ь剙鍊风粩瀛樼▔椤忓懏鐎ù鐘插椤撴悂骞嶉埀顒勫嫉婢舵稓绀夐柛鎰С缁″啯绋夊鍡忓亾閺囩儐鍟囬柛锝冨妺鐠愶紕鎹勯幋娆屽亾閸屾稑绗侀柟瀹︺倗绠瑰ù婊勭⊕婵⊙冾啅瑜濈槐婵囨媴閻樺灚鐣� NAS 閺夆晜鍔楀ǎ顕€鎳楅挊澶婎潝濞村吋纰嶈ぐ渚€宕￠崶锔绢伇濞戞搩浜濋妴鍌氣枎鎺抽埀顒婃嫹