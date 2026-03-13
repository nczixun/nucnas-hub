---
slug: "tailscale-remote-access"
title: "Tailscale锛氭棤闇€鍏綉 IP锛屽疄鐜板唴缃戠┛閫�"
date: 2026-02-12
summary: "鍏ㄧ悆鑼冨洿鍐呭畨鍏ㄨ闂綘瀹堕噷鐨� NUC NAS銆�"
categories: ["nas"]
---

# Tailscale锛氭棤闇€鍏綉IP锛屽疄鐜板唴缃戠┛閫�


"鎴戝湪鍏徃鎯宠闂閲岀殑NAS鏂囦欢"銆�"鎴戝湪鍑哄樊鏃舵兂鐪嬬湅鐩戞帶鎽勫儚澶寸殑瀹炴椂鐢婚潰"銆�"鎴戞兂鍦ㄥ缃戞帶鍒跺閲岀殑鏅鸿兘瀹跺眳璁惧"鈥斺€旇繖浜涘満鏅殑鏍稿績闇€姹傚彧鏈変竴涓細**杩滅▼璁块棶鍐呯綉璁惧**銆傜劧鑰岋紝鍥藉唴澶у鏁板搴甯﹂兘娌℃湁鍏綉IPv4鍦板潃锛岃繍钀ュ晢鎻愪緵鐨凬AT浣垮緱鐩存帴浠庡閮ㄨ闂垚涓哄ア鏈涖€傝姳鐢熷３銆乫rp绛夊唴缃戠┛閫忓伐鍏疯涔堟敹璐规槀璐碉紝瑕佷箞閰嶇疆澶嶆潅锛岃涔堥€熷害鍫咖銆�

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鐨勫嚭鐜版敼鍙樹簡杩欎釜灞€闈€€傚畠鍩轰簬WireGuard鍗忚锛屽埄鐢═URN鏈嶅姟鍣ㄥ疄鐜癗AT绌块€忥紝璁╀綘鍙互鍦ㄤ换浣曟湁缃戠粶鐨勫湴鏂癸紝鍍忓湪灞€鍩熺綉鍐呬竴鏍疯闂涓殑<a href="/guide/" target="_blank">NAS</a>銆傛洿閲嶈鐨勬槸锛屽畠鏄厤璐圭殑銆佷釜浜轰娇鐢ㄥ畬鍏ㄨ冻澶熴€侀厤缃畝鍗曞埌浠や汉鍙戞寚銆傛湰鏂囧皢璇︾粏浠嬬粛<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鐨勫伐浣滃師鐞嗐€佸湪<a href="/guide/" target="_blank">NAS</a>涓婄殑閮ㄧ讲鏂规硶浠ュ強瀹為檯搴旂敤鍦烘櫙銆�

## <a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鏄粈涔�

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鏄竴娆惧熀浜嶹ireGuard鐨刅PN锛堣櫄鎷熶笓鐢ㄧ綉缁滐級宸ュ叿銆備笌浼犵粺VPN涓嶅悓锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鐨勮璁＄洰鏍囨槸璁╂櫘閫氱敤鎴蜂篃鑳借交鏉惧疄鐜拌澶囦箣闂寸殑鐐瑰鐐硅繛鎺ワ紝鑰屾棤闇€澶嶆潅鐨勯厤缃拰鏈嶅姟鍣ㄦ惌寤恒€�

宸ヤ綔鍘熺悊鍙互绠€鍗曠悊瑙ｄ负锛氫綘鍦ㄦ瘡鍙伴渶瑕佽繙绋嬭闂殑璁惧涓婂畨瑁�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹㈡埛绔紙<a href="/guide/" target="_blank">NAS</a>銆佹墜鏈恒€佺數鑴戙€佽矾鐢卞櫒锛夛紝杩欎簺璁惧浼氱粍鎴愪竴涓櫄鎷熺殑灞€鍩熺綉銆傚湪杩欎釜铏氭嫙缃戠粶涓紝姣忎釜璁惧閮芥湁涓€涓敮涓€鐨�"tailnet IP"鍦板潃锛屾棤璁鸿繖浜涜澶囩墿鐞嗕笂鍦ㄥ摢閲岋紝浣犻兘鍙互鐩存帴閫氳繃杩欎釜IP鍦板潃璁块棶瀹冧滑锛屽氨鍍忓湪鍚屼竴涓猈iFi涓嬩竴鏍枫€�

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鐨勬牳蹇冧紭鍔垮寘鎷細鏃犻渶鍏綉IP銆佹棤闇€閰嶇疆璺敱鍣ㄣ€佹棤闇€璐拱鏈嶅姟鍣ㄣ€佷腑鏂囩晫闈€€佹敮鎸佸叏骞冲彴锛圵indows銆乵acOS銆丩inux銆乮OS銆丄ndroid锛夈€佸厤璐逛釜浜虹増瓒冲浣跨敤銆�

## 鍩虹閮ㄧ讲锛�<a href="/guide/" target="_blank">NAS</a>涓婄殑<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹樻柟鎻愪緵浜嗗绉嶅畨瑁呮柟寮忥紝瀵逛簬<a href="/guide/" target="_blank">NAS</a>鐢ㄦ埛鏉ヨ锛屾渶鎺ㄨ崘鐨勬槸閫氳繃<a href="/guide/docker-best-practice/" target="_blank">Docker</a>杩愯銆�

绗竴姝ワ紝瀹夎<a href="/guide/docker-best-practice/" target="_blank">Docker</a>銆傚鏋滀綘浣跨敤缇ゆ櫀銆乀rueNAS鎴栭鐗汷S锛�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閫氬父宸茬粡棰勮鎴栧彲浠ュ湪搴旂敤鍟嗗簵涓€閿畨瑁呫€�

绗簩姝ワ紝鑾峰彇<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>璁よ瘉瀵嗛挜銆傝闂�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹樼綉锛坱ailscale.com锛夋敞鍐岃处鍙凤紝鍦ㄦ帶鍒跺彴鐨�"Settings" > "Personal keys"涓敓鎴愪竴涓柊鐨勮璇佸瘑閽ャ€傛敞鎰忚缃悎閫傜殑杩囨湡鏃堕棿锛屽缓璁缃负1骞淬€�

绗笁姝ワ紝鍒涘缓<a href="/guide/docker-best-practice/" target="_blank">Docker</a>瀹瑰櫒銆傚湪docker-compose.yml涓坊鍔犱互涓嬪唴瀹癸細

```yaml
version: '3.8'

services:
  tailscale:
    image: tailscale/tailscale:latest
    container_name: tailscale
    network_mode: host
    cap_add:
      - net_admin
      - sys_module
    volumes:
      - ./state:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    environment:
      - TS_AUTH_ONCE=true
      - TS_KUBE_SECRET=
      - TS_USERSPACE=false
      - TS_STATE_DIR=/var/lib/tailscale
      - TS_AUTH_KEY=浣犵殑Tailscale璁よ瘉瀵嗛挜
    restart: unless-stopped
```

杩欎釜閰嶇疆鐨勫叧閿偣鍖呮嫭锛歚network_mode: host`璁╁鍣ㄤ娇鐢ㄥ涓绘満缃戠粶鏍堬紱`cap_add`鎻愪緵蹇呰鐨勫唴鏍告潈闄愶紱`/dev/net/tun`璁惧鏄犲皠鏄疻ireGuard杩愯鎵€蹇呴渶鐨勶紱`TS_AUTH_KEY`濉啓浣犵敓鎴愮殑璁よ瘉瀵嗛挜銆�

瀹瑰櫒鍚姩鍚庯紝棣栨杩愯浼氳嚜鍔ㄥ畬鎴愯澶囨敞鍐屻€傚彲浠ラ€氳繃鏃ュ織纭杩炴帴鐘舵€侊細

```bash
docker logs tailscale
```

濡傛灉鐪嬪埌"Tailscale is running"鐨勬棩蹇楋紝璇存槑杩炴帴鎴愬姛銆�

## 璺敱涓庡瓙缃戣矾鐢卞櫒鐨勭敤

榛樿濡欐儏鍐典笅锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鍙厑璁歌闂畨瑁呬簡<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹㈡埛绔殑璁惧銆傚鏋滀綘鎯宠<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹㈡埛绔兘澶熻闂�<a href="/guide/" target="_blank">NAS</a>鎵€鍦ㄥ眬鍩熺綉鐨勫叏閮ㄨ澶囷紙濡傛墦鍗版満銆佹憚鍍忓ご銆佹櫤鑳藉灞呯綉鍏筹級锛岄渶瑕侀厤缃�"瀛愮綉璺敱鍣�"锛圫ubnet Router锛夈€�

绗竴姝ワ紝鍦�<a href="/guide/" target="_blank">NAS</a>涓婂紑鍚疘P杞彂銆傛墽琛岋細

```bash
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
```

绗簩姝ワ紝鍦�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹瑰櫒涓坊鍔燼dvertise routes鍙傛暟銆備慨鏀筪ocker-compose.yml锛�

```yaml
environment:
  - TS_AUTH_KEY=浣犵殑璁よ瘉瀵嗛挜
  - TS_ROUTES=192.168.1.0/24  # 浣犵殑灞€鍩熺綉缃戞
```

绗笁姝ワ紝鍦�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鎺у埗鍙板惎鐢ㄥ瓙缃戣矾鐢便€傜櫥褰�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>绠＄悊鍚庡彴锛屾壘鍒颁綘鐨�<a href="/guide/" target="_blank">NAS</a>璁惧锛屽湪"Edit route settings"涓惎鐢ㄥ垰鎵嶅彂甯冪殑璺敱銆�

閰嶇疆瀹屾垚鍚庯紝浣犵殑鎵嬫満鎴栫瑪璁版湰杩炴帴鍒�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鍚庯紝鍙互鐩存帴閫氳繃灞€鍩熺綉IP璁块棶<a href="/guide/" target="_blank">NAS</a>涓嬬殑鎵€鏈夎澶囥€傛瘮濡傦紝浣犲彲浠ョ敤鎵嬫満涓婄殑VNC Viewer鐩存帴璁块棶瀹朵腑灞€鍩熺綉閲岀殑Windows鐢佃剳锛岃€屼笉闇€瑕佸湪閭ｄ釜鐢佃剳涓婇澶栧畨瑁�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>銆�

## 杩涢樁鐜╂硶锛氬嚭鍙ｈ妭鐐逛笌瀹夊叏璁块棶

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>杩樻湁涓や釜杩涢樁鍔熻兘鍊煎緱浜嗚В锛�

**鍑哄彛鑺傜偣锛圗xit Node锛�**锛氬紑鍚悗锛屼綘鐨�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>璁惧鍙互閫氳繃<a href="/guide/" target="_blank">NAS</a>鐨勫叕缃戝嚭鍙ｈ闂簰鑱旂綉銆傝繖鎰忓懗鐫€褰撲綘鍑哄樊鍒板浗澶栨椂锛屽彲浠ラ€氳繃<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>"鍥炲"锛岃幏寰楀拰鍦ㄥ閲屼竴鏍风殑缃戠粶鐜銆傝繖瀵逛簬闇€瑕佽闂浗鍐呰祫婧愶紙闊充箰銆佽棰戙€佹敮浠楢pp锛夌殑娴峰鍗庝汉闈炲父瀹炵敤銆�

閰嶇疆鏂规硶锛氬湪<a href="/guide/" target="_blank">NAS</a>鐨�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹瑰櫒鐜鍙橀噺涓坊鍔燻TS_ALLOW_ACCESS_CONTROL=true`锛岀劧鍚庡湪<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>瀹㈡埛绔紑鍚�"Use as exit node"鍗冲彲銆�

**ACL璁块棶鎺у埗**锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鏀寔缁嗙矑搴︾殑璁块棶鎺у埗绛栫暐锛屽彲浠ユ寚瀹氬摢浜涜澶囧彲浠ヨ闂摢浜涙湇鍔°€備緥濡傦紝浣犲彲浠ヨ缃彧鏈夊伐浣滅數鑴戝彲浠ヨ闂�<a href="/guide/" target="_blank">NAS</a>鐨勬枃浠舵湇鍔★紝鑰屾墜鏈哄彧鑳借闂獟浣撴湇鍔°€侫CL閰嶇疆鍦�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鎺у埗鍙扮殑"Access Control"椤甸潰缂栬緫銆�

## 甯歌闂涓庤В鍐虫柟妗�

**Q锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>杩炴帴鎴愬姛浣嗘棤娉曡闂�<a href="/guide/" target="_blank">NAS</a>锛�**
A锛氭鏌ラ槻鐏璁剧疆銆傜兢鏅栫敤鎴烽渶瑕佸湪"鎺у埗闈㈡澘" > "瀹夊叏鎬�"涓厑璁�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>缃戞鐨勮闂€備篃鍙互灏濊瘯鍦�<a href="/guide/" target="_blank">NAS</a>涓婃墽琛宍sudo iptables -L`鏌ョ湅鏄惁鏈夎鍒欓樆姝€€�

**Q锛氳繛鎺ラ€熷害寰堟參锛�**
A锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>浼氳嚜鍔ㄩ€夋嫨鏈€浼樼殑浼犺緭璺緞锛岄粯璁ゆ儏鍐典笅浣跨敤UDP鐩磋繛銆傚鏋滅綉缁滅幆澧冨鏉傦紙濡備紒涓氶槻鐏锛夛紝鍙互灏濊瘯鍦ㄥ鎴风璁剧疆涓惎鐢�"Use HTTPS"寮哄埗TCP妯″紡銆�

**Q锛氬浣曟煡鐪�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鍒嗛厤鐨処P鍦板潃锛�**
A锛氬湪<a href="/guide/" target="_blank">NAS</a>涓婃墽琛宍docker exec tailscale tailscale ip -4`锛屾垨鍦�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鎺у埗鍙版煡鐪嬭澶囪鎯呫€�

**Q锛�<a href="/guide/" target="_blank">NAS</a>閲嶅惎鍚�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>闇€瑕侀噸鏂扮櫥褰曪紵**
A锛氳繖鏄洜涓轰娇鐢ㄤ簡`TS_AUTH_ONCE=true`銆傞娆¤璇佸悗锛岀姸鎬佹枃浠朵細淇濆瓨鍦╜./state`鐩綍涓€傚彧瑕佽繖涓洰褰曞瓨鍦紝閲嶅惎鍚庢棤闇€閲嶆柊璁よ瘉銆�

## 鏇夸唬鏂规瀵规瘮

闄や簡<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>锛屽競闈笂杩樻湁鍑犳绫讳技鐨勫伐鍏凤細

**WireGuard**锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鐨勫簳灞傚崗璁紝姣�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鏇磋交閲忎絾闇€瑕佽嚜宸辨惌寤烘帶鍒舵湇鍔″櫒锛屼笉閫傚悎鏅€氱敤鎴枫€�

**Cloudflare Tunnel**锛氬厤璐逛絾閰嶇疆鐩稿澶嶆潅锛岄€傚悎鏈変竴瀹氭妧鏈儗鏅殑鐢ㄦ埛銆�

**ZeroTier**锛氫笌<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>绫讳技锛屼絾鍥藉唴璁块棶閫熷害杈冩參锛岃繎骞存湇鍔′笉澶ǔ瀹氥€�

缁煎悎鏉ョ湅锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鏄洰鍓嶆渶鎺ㄨ崘鐨勬柟妗堬細閫熷害蹇€佸厤璐圭増澶熺敤銆侀厤缃畝鍗曘€佽法骞冲彴鏀寔濂姐€�

## 瀹為檯搴旂敤鍦烘櫙

閮ㄧ讲濂�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鍚庯紝浣犲彲浠ュ疄鐜颁互涓嬪満鏅細

**杩滅▼鏂囦欢璁块棶**锛氬湪鍏徃鎴栧嚭宸椂锛岄€氳繃SMB/AFP鍗忚鐩存帴鎸傝浇<a href="/guide/" target="_blank">NAS</a>鏂囦欢鐩綍锛屽儚鏈湴纾佺洏涓€鏍蜂娇鐢ㄣ€�

**鐩戞帶杩滅▼瑙傜湅**锛氶€氳繃VNC鎴朢DP杩滅▼璁块棶瀹朵腑鐢佃剳鏌ョ湅鐩戞帶鎽勫儚澶寸敾闈€€�

**鏅鸿兘瀹跺眳鎺у埗**锛氬湪鎵嬫満涓婇€氳繃<a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant</a>瀹㈡埛绔繙绋嬫帶鍒跺涓殑鏅鸿兘璁惧銆�

**PT涓嬭浇鎸傜**锛氳繙绋嬬櫥褰�<a href="/guide/" target="_blank">NAS</a>绠＄悊涓嬭浇浠诲姟锛屾煡鐪嬪仛绉嶇姸鎬併€�

**寮€鍙戞祴璇�**锛氬皢寮€鍙戜腑鐨勭綉绔欐垨鏈嶅姟鍙戝竷鍒�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>缃戠粶锛岃繙绋嬫紨绀虹粰瀹㈡埛鎴栧悓浜嬨€�

## 鎬荤粨

<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>褰诲簳绠€鍖栦簡鍐呯綉绌块€忕殑澶嶆潅搴︺€傚畠涓嶉渶瑕佸叕缃慖P銆佷笉闇€瑕佸鏉傞厤缃€佺敋鑷充笉闇€瑕佷换浣曡垂鐢紝灏辫兘璁╀綘鍦ㄥ叏鐞冧换浣曚竴涓钀藉畨鍏ㄨ闂涓殑<a href="/guide/" target="_blank">NAS</a>鍜屾湇鍔°€傚浜�<a href="/guide/" target="_blank">NAS</a>鐢ㄦ埛鏉ヨ锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>鍑犱箮鏄繀瑁呯殑搴旂敤鈥斺€斿畠璁�"闅忔椂闅忓湴璁块棶鑷繁鐨勬暟鎹�"鎴愪负鍙兘锛岃€岃繖涓€鍒囬兘鏄厤璐圭殑銆�

---

*鏇村<a href="/guide/" target="_blank">NAS</a>鏁欑▼璇峰叧娉� [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/guide/alist-network-aggregation-2026/" rel="prev">涓婁竴椤碉細Alist缃戠洏鑱氬悎绁炲櫒锛氫竴閿寕杞�20+缃戠洏</a>
  <a href="/guide/immich-photo-cloud/" rel="next">涓嬩竴椤碉細Immich锛氭浛浠oogle Photos鐨勭鏈夌収鐗囨柟妗�</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
