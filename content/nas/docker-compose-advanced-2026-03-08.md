---
title: "Docker Compose 闂佸搫顦弲婊堟儎椤栨鐔哥瑹閳ь剟寮鍜佹僵妞ゆ帒顦伴埢濂告煟鎼粹剝璐￠柟铏尭閳诲秹骞掗弮鍌滐紳闂佸搫绉查崝宀€绮幘缁樺€甸柛锔诲幖娴狅箓鏌涢…鎴濆⒋妤犵偞鍔欏畷鎯邦槻缁绢厸鍋�"
date: 2026-03-08T15:03:00+08:00
category: ["NAS 闂佽瀛╅崘鑽ょ不閹炬枼鏋嶉柨鐕傛嫹"]
tags: ["Docker", "Docker Compose", "NAS", "闂佽楠稿﹢閬嶅箠閹炬枼鏋嶉柟鐑樻⒒绾句粙鏌″鍐ㄥ缂佹鎷�", "闂備胶鍘ч〃搴㈢濠婂嫭鍙忛柍鍝勬噹缁€宀勬煥閻曞倹瀚�", "闂備浇妗ㄩ悞锕傛偡瑜旈崺銏ゆ晸閿燂拷"]
draft: false
---

濠电偞娼欓崥瀣潩閵娾晛鏋侀柨鐕傛嫹 Docker 濠电偠鎻徊钘壩涢弮鍌滅當濠㈣埖鍔栭崑鍕煟閺冨伋褰掑焵椤掑﹥瀚� Compose闂備焦瀵х粙鎾诲窗閺囩姵宕查柡宥庡亜婵剟鏌涢妷鎴濇噺閺嗘梹绻涙潏鍓ф偧濠殿喖澧介幑銏狀潨閳ь剙顫忔總鍝ュ彆婵炴潙顑呮禍楣冩煕鐏炴儳鍤柛鏂挎噹闇夌痪顓㈡敱鐎氾拷 docker-compose闂備焦瀵х粙鎴炵附閺冨倻鍗氶柟缁㈠枟閻撱儲銇勯弮鍌濇闁告埃鍋撻梻浣藉吹閸嬫稑螞濞嗘劖娅犵€广儱顦€氬顭跨捄琛＄湅闁哥喎娲弻娑㈡晲閸愩劌惟闂侀€炲苯澧鹃柟鍑ゆ嫹

## 濠电偞鍨堕幑浣割浖閵娧冨灊闁割偆鍠撻埢鏇㈡煕椤愮姴鐏柡鍡嫹 Docker Compose闂備焦瀵ч崘濠氬箯閿燂拷

闂備礁缍婂ḿ褔顢栭崨顔藉弿闁跨噦鎷� docker run 婵犳鍣徊鐣屾崲閹达富鏁冨┑鍌氭啞閻掗箖鏌涙繝鍕珡婵炶缍侀弻鈩冩媴閽樺澶勭紓浣规⒐閹稿啿鐣锋總绋垮耿婵°倐鍋撴俊顐ｏ耿閺屸剝鎷呯粙璺ㄧ泿缂備浇椴哥换鍕焵椤掆偓濠€閬嶅箠閹炬枼鏋嶉柟鐑樻尭缁剁偞鎱ㄥ鍡椾簽闁哥喎锕弻鈥愁吋閸偅缍堝┑鐘亾闁规鍠楁刊鐓幬涙０浣藉厡闁荤喐绻傞湁闁挎繂鎳愮粻鐐烘煃瑜滈崗娑㈠疾閻ョ斂pose 闂備焦妞垮渚€骞忛敓锟� YAML 闂備礁鎼崐绋棵洪敐鍛瀻闁靛繆鎳囬崑鎾舵喆閸曨厾鍙濈紓浣哄Х閸犳牕顕ｉ棃娑卞悑闁告侗鍙庡ḿ鎶芥⒑閹稿海鈽夐柣顒€鍚嬮弲璺何旈崨顓炵彉濡炪倖甯婄粈浣圭濮椻偓閺屾盯骞掗弴鐘茬墯闂侀€炲苯鍘告繛鏉戞川缂傛捇鎳栭埡鍐厠濠殿喚鎳撳ú鐘诲磻閹惧瓨濯撮柛鎾冲级鏍″┑鐐差嚟婵磭鍒掑▎鎾崇婵せ鍋撶€殿噮鍓熼弻鍛槈濮橈絾鏅欓梻渚€娼уΛ鎾箯閿燂拷

## 闂備胶纭堕弲鐐测枍閿濆鈧線宕ㄩ婊咃紲闂佽鍎抽顓㈠焵椤掑﹥瀚�

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

## 闂佸搫顦弲婊堟儎椤栨鐔哥瑹閳ь剟鐛惔銊ョ劦妞ゆ巻鍋撴い鏂跨箻閺佹捇鏁撻敓锟�

### 1. 闂備胶绮划鐘诲垂娴兼番鈧倿濡搁埡浣虹厬濠殿喗銇涢崑鎾绘煕閿濆牊顏犵紒顔碱煼閺佸秹宕熼鈧埀顒婃嫹

闂備礁鎲＄敮妤冪矙閹寸姷纾介柨鐕傛嫹 `.env` 闂備礁鎼崐绋棵洪敐鍛瀻闁靛繈鍊栭弲顒勬煥閻曞倹瀚�

```bash
# .env
POSTGRES_PASSWORD=your_secure_password
DATA_PATH=/mnt/storage
```

Compose 闂備胶鍘ч〃搴㈢濠婂嫭鍙忛柍鍝勫暞鐎氭岸鎮归崶銊ョ祷缂佹彃娼￠弻銊モ槈閾忣偄顏�

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ${DATA_PATH}/postgres:/var/lib/postgresql/data
```

### 2. 缂傚倸鍊搁崯顖炲垂閸︻厼鍨濋柛顐ｆ礃閳锋洟鏌￠崘銊ヤ簽闁诲函鎷�

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
    internal: true  # 闂佽娴烽幊鎾绘嚐椤栫偛鐭楅煫鍥ㄧ⊕閳锋洟鏌￠崘銊ヤ簽闁诲函鎷�
```

### 3. 闂備胶枪椤戝啴宕曢柆宥呯畺鐎广儱鎲樺☉銏犵劦妞ゆ帒瀚拑鐔兼煥閻曞倹瀚�

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

### 4. 濠电偞鎸荤喊宥囨崲閸℃瑧鐭夐柛鈩冪☉缁€鍌溾偓瑙勬礀濞差參宕楅敓锟�

```yaml
services:
  web:
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

## 闂佹眹鍩勯崹浼村箺濠婂牆鏋侀柕鍫濐槸瀹告繈鏌熺€涙ê绗氬┑顕嗘嫹

```bash
# 闂備礁鎲￠崙褰掑垂閻楀牊鍙忛柍鍝勬噹缁犮儵鏌嶈閸撶喎顕ｉ崹顐㈢窞閻庯綆鍋嗛悿鈧梻浣告啞濡垿骞忛敓锟�
docker-compose up -d

# 闂備礁鎼悮顐﹀磿閸愯鑰块柛娑欐綑缁秹鏌曟径鍫濆姢缂佺媴鎷�
docker-compose logs -f

# 闂備礁鎼ú銈夋偤閵娾晛钃熷┑鐘叉处閳锋劖绻濇繝鍌氭殭闁告搫鎷�
docker-compose pull
docker-compose up -d

# 闂備胶枪椤戝棛鍒掑澶樻晢婵炴垯鍨圭粻銉╂煃瑜滈崜鐔奉嚕閸偄绶為悗锝庡亞閻も偓闂備礁鎲″Λ鎴﹀箯閿燂拷
docker-compose down
```

## 闂備胶鎳撻悺銊╁垂閻熸壋鏋旈柨鐕傛嫹 NAS 闂傚倷鐒﹀妯肩矓閸洘鍋柛鈩冪☉缁€鍡涙煕閳╁啯绀嬮柣鎿勬嫹

闂佸搫顦弲婊堟偡閿曗偓鍗遍柟闂寸缁狅綁鏌熺€电ǹ校缂佹劖顨婇弻娑㈠箻瀹曞泦銏＄節閳ь剟顢旈崼鐔蜂缓闂侀潧臎閸曨厽娈搁梻鍌欑贰閸犳捇宕濆畝鍕瀭閹兼番鍔嶉悡鈧悗骞垮劚濞层劑寮搁崒鐐寸叆婵炴垼娅曠€氾拷

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

## 闂備浇顕栭崜婵嗙暦閻㈤潧鍨濋柨鐕傛嫹

Docker Compose 闂備焦妞挎禍鐐哄窗閹炬枼鏋旈柟杈剧畱閸欏﹥銇勯弽銊х煁闁哄棗绻愰湁婵犲﹤鍟ˉ婊勬叏濡ǹ濮傜€规洖鐖奸幃娆撳箥椤旂偓鍠掗梻浣告啞钃遍柣顏勭秺閸┾偓妞ゆ巻鍋撻柛濠傛健瀹曘垽濡堕崶鈺冿紴濡炪倖妫佸畷鐢割敂鏉堛劎绠鹃柛鈥崇箲椤绱掓潏銊х畺缂佸顦遍埀顒婄秵閸嬫帡宕戣閳ь剚顔栭崰鎺楀磻閹剧粯鐓涢柛顐稻閵嗗啰绱掗弮鈧幐鎶藉蓟閵娾晩鏁婇柛蹇曞帶閸撳姊洪崨濠冪厽闁告柨绉甸弲璺侯吋婢跺﹤鐝樻繝銏ｆ硾椤戝棛绮诲☉銏＄厱闁哄倸鎳忔竟瀣磻閹捐纾兼慨妯夸含婢跺嫰鏌ｉ悩杈╄窗闁哥姵鐗犳俊鐢稿炊閳规儳浜鹃柣鐔稿閸╋綁鏌涜箛鏃撹€块柟宕囧仦濞煎繘濡搁敂缁樞濋梻鍌氬€搁崐鐟搬缚濞嗘搩鏁嗛柣鏂挎憸閳绘棃鏌嶈閸撴氨绮欐径灞稿亾閿濆懎顣崇紒鈧径鎰厽妞ゅ繐妫楅弸鏃€绻涢崼鐔风伌闁硅櫕顨婇幃鍓т沪妤ｅ啯袙闁诲骸鐏氬姗€鎮ч崱娴板洭宕稿Δ鈧粈澶愭煟閺冣偓閻忔碍绂嶉柆宥嗙厪闁糕槅鍘界€氾拷

---
*婵犵數鍋炲ḿ娆擃敄閸儲鍎婃い鏍仦閸嬫繃銇勯弽銊ュ毈闁哄棙妫冮弻銊モ槈濞嗘劗娈ら梺绋跨箞閸ㄨ棄顕ｉ弻銉︽櫢闁跨噦鎷� DS920+ Docker 24.0*
