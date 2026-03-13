---
slug: "docker-best-practice"
title: "NAS 鏂版墜蹇呯湅锛欴ocker 瀹瑰櫒绠＄悊鏈€浣冲疄璺�"
date: 2026-02-12
summary: "鏉滅粷鏉冮檺鎶ラ敊锛屾暀浣犲浣曚紭闆呭湴缁勭粐 Compose 鏂囦欢銆�"
categories: ["nas"]
---

# NAS 鏂版墜蹇呯湅锛欴ocker 瀹瑰櫒绠＄悊鏈€浣冲疄璺�


<a href="/guide/nas-beginner-guide-2026/" target="_blank">Docker</a>宸茬粡鎴愪负鐜颁唬<a href="/guide/" target="_blank">NAS</a>涓嶅彲鎴栫己鐨勬牳蹇冨姛鑳姐€備粠鍓嶉渶瑕佸鏉傜紪璇戞垨鎵嬪姩瀹夎鐨勫簲鐢紝濡備粖閮藉彲浠ラ€氳繃Docker瀹瑰櫒涓€閿儴缃层€傜劧鑰岋紝闅忕潃瀹瑰櫒鏁伴噺澧炲姞锛屽緢澶氱敤鎴蜂細閬囧埌鍚勭闂锛氭潈闄愪笉瓒冲鑷存棤娉曞啓鍏ユ枃浠躲€佺鍙ｅ啿绐佹棤娉曞惎鍔ㄣ€佺綉缁滈厤缃贩涔遍毦浠ヨ闂€佸崌绾у悗閰嶇疆涓㈠け鈥︹€﹁繖浜涢棶棰樺線寰€婧愪簬鍒濇湡缂轰箯鑹ソ鐨勮鍒掋€傛湰鏂囧皢浠庡疄鎴樿搴﹀嚭鍙戯紝鍒嗕韩<a href="/guide/" target="_blank">NAS</a> <a href="/guide/docker-best-practice/" target="_blank">Docker</a>绠＄悊鐨勬渶浣冲疄璺碉紝甯姪鏂版墜閬垮紑甯歌鍧戯紝璁╁鍣ㄥ寲閮ㄧ讲鏃㈤珮鏁堝張鐪佸績銆�

## 涓轰粈涔堥渶瑕佽鑼冨寲鐨勫鍣ㄧ鐞�

鍦�<a href="/guide/" target="_blank">NAS</a>涓婅繍琛�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>锛屾湰璐ㄤ笂鏄湪涓€鍙癓inux铏氭嫙鏈轰笂閮ㄧ讲澶氫釜鐩镐簰闅旂鐨勫簲鐢ㄣ€備笌浼犵粺铏氭嫙鏈虹浉姣旓紝瀹瑰櫒鍏变韩瀹夸富鏈虹殑鍐呮牳锛岃祫婧愬崰鐢ㄦ瀬浣庯紝鍚姩閫熷害鏋佸揩锛屼絾杩欎篃鎰忓懗鐫€閰嶇疆涓嶅綋浼氬甫鏉ュ畨鍏ㄩ殣鎮ｅ拰杩愮淮楹荤儲銆�

寰堝鏂版墜鐨勪娇鐢ㄤ範鎯槸杩欐牱鐨勶細鍦�<a href="/guide/docker-best-practice/" target="_blank">Docker</a> GUI閲岄殢鎵嬪垱寤轰竴涓鍣紝杩愯涓€娈垫椂闂村悗闇€瑕佷慨鏀归厤缃紝鍗村彂鐜版壘涓嶅埌鍘熸潵鐨勮缃紱鎯宠縼绉诲埌鍙︿竴鍙拌澶囨椂锛岄潰瀵瑰嚑鍗佷釜瀹瑰櫒鐨勯厤缃棤浠庝笅鎵嬶紱鏌愪釜瀹瑰櫒鍑虹幇闂闇€瑕侀噸寤猴紝鍗村彂鐜� volumes 閲岀殑鏁版嵁宸茬粡涔变綔涓€鍥€€傝繖绉�"閲庣敓闀垮紡"鐨勫鍣ㄧ鐞嗘柟寮忓湪鍒濇湡鍙兘鐪嬩笉鍑洪棶棰橈紝浣嗛殢鐫€鏃堕棿鎺ㄧЩ锛岀淮鎶ゆ垚鏈細鍛堟寚鏁扮骇澧為暱銆�

瑙勮寖鍖栫殑瀹瑰櫒绠＄悊鏍稿績鍦ㄤ簬涓夌偣锛氶厤缃唬鐮佸寲銆佹暟鎹笌绯荤粺鍒嗙銆佺幆澧冧竴鑷存€с€傞€氳繃<a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>锛屾垜浠彲浠ュ皢鏁翠釜搴旂敤鐨勯厤缃啓鎴愪竴涓猋AML鏂囦欢锛屽儚浠ｇ爜涓€鏍疯繘琛岀増鏈鐞嗭紱閫氳繃鍚堢悊瑙勫垝volumes锛屽疄鐜板簲鐢ㄦ暟鎹笌瀹瑰櫒鏈韩鐨勫垎绂伙紱閫氳繃缁熶竴缃戠粶閰嶇疆锛岃鎵€鏈夊鍣ㄥ湪鍚屼竴涓櫄鎷熺綉缁滀腑鍜岃皭鍏卞瓨銆�

## Docker Compose鏂囦欢缁撴瀯璇﹁В

<a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>鏄鍣ㄧ紪鎺掔殑浜嬪疄鏍囧噯锛岄€氳繃涓€涓猟ocker-compose.yml鏂囦欢瀹氫箟鏈嶅姟銆佺綉缁溿€佸嵎鎸傝浇绛夋墍鏈夐厤缃€備互涓嬫槸涓€涓吀鍨嬬殑<a href="/guide/" target="_blank">NAS</a>搴旂敤Compose鏂囦欢缁撴瀯锛�

```yaml
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    network_mode: host
    volumes:
      - ./config:/config
      - ./cache:/cache
      - /mnt/storage/media:/media:ro
    environment:
      - TZ=Asia/Shanghai
      - JELLYFIN_PublishedServerUrl=http://your-nas-ip:8096
    devices:
      - /dev/dri:/dev/dri
```

杩欎釜鏂囦欢瀹氫箟浜咼ellyfin鏈嶅姟鐨勫畬鏁撮厤缃細浣跨敤鏈€鏂伴暅鍍忋€佸鍣ㄥ悕銆� restart绛栫暐銆佷富鏈虹綉缁滄ā寮忋€侀厤缃洰褰曞拰濯掍綋鐩綍鐨勫嵎鎸傝浇銆佹椂鍖虹幆澧冨彉閲忥紝浠ュ強鍏抽敭鐨凣PU璁惧鐩撮€氥€傚叧閿槸鎵€鏈夐厤缃兘涓€鐩簡鐒讹紝杩佺Щ鏃跺彧闇€澶嶅埗鏁翠釜鏂囦欢澶瑰嵆鍙€�

## 鏉冮檺闂鐨勬牴鏈В鍐�

鏉冮檺鎶ラ敊鏄�<a href="/guide/" target="_blank">NAS</a> <a href="/guide/docker-best-practice/" target="_blank">Docker</a>鐢ㄦ埛閬囧埌鐨勬渶甯歌闂涔嬩竴銆傝〃鐜颁负瀹瑰櫒鍐呭簲鐢ㄦ棤娉曞垱寤烘枃浠躲€佹棤娉曡鍙栧獟浣撳簱銆佹垨鏄湪鏃ュ織涓湅鍒�"Permission Denied"閿欒銆傝繖鏄洜涓�<a href="/guide/" target="_blank">NAS</a>鐨勬枃浠剁郴缁熸潈闄愪笌瀹瑰櫒鍐呯殑鐢ㄦ埛鏉冮檺涓嶅尮閰嶃€�

闂鐨勬牴婧愬湪浜庯細缇ゆ櫀銆乀rueNAS绛�<a href="/guide/" target="_blank">NAS</a>绯荤粺閫氬父浣跨敤鐗瑰畾鐨刄ID/GID杩愯鏈嶅姟锛堝缇ゆ櫀鐨剆c-transmission鐢ㄦ埛浣跨敤911锛夛紝鑰屽鍣ㄥ唴鐨勮繘绋嬮€氬父浠oot鎴栫壒瀹氱殑瀹瑰櫒鍐呯敤鎴疯繍琛屻€傚綋瀹瑰櫒灏濊瘯璁块棶鎸傝浇鐨�<a href="/guide/" target="_blank">NAS</a>鍏变韩鏂囦欢澶规椂锛屽氨浼氶亣鍒版潈闄愪笉鍖归厤鐨勯棶棰樸€�

鏈€浣宠В鍐虫柟妗堟槸鍦–ompose鏂囦欢涓樉寮忔寚瀹氱敤鎴稩D鍜岀粍ID銆備互缇ゆ櫀涓轰緥锛屽彲浠ユ坊鍔燻user: "1000:1000"`锛堝亣璁句綘鐨勭鐞嗗憳璐︽埛UID鏄�1000锛夋潵璁╁鍣ㄤ互浣犵殑璐︽埛韬唤杩愯銆傛洿浼橀泤鐨勫仛娉曟槸鍒涘缓涓撶敤鐨勭敤鎴风粍锛屽苟鍦–ompose涓寚瀹氾細

```yaml
environment:
  - PUID=1000
  - PGID=100
  - TZ=Asia/Shanghai
```

寰堝涓绘祦瀹瑰櫒闀滃儚锛堝LinuxServer.io绯诲垪锛夐兘鏀寔杩欎簺鐜鍙橀噺鏉ヨ嚜鍔ㄨ缃繍琛岀敤鎴枫€傚浜庝笉鏀寔鐨勯暅鍍忥紝鍙互浣跨敤`user`鍙傛暟鐩存帴鎸囧畾銆�

## 缃戠粶閰嶇疆鐨勮繘闃舵妧宸�

榛樿鎯呭喌涓嬶紝<a href="/guide/docker-best-practice/" target="_blank">Docker</a>涓烘瘡涓鍣ㄥ垎閰嶇嫭绔嬬殑缃戠粶鍛藉悕绌洪棿锛屽鍣ㄤ箣闂撮€氳繃links鎴杣ser-defined缃戠粶閫氫俊銆備絾鍦�<a href="/guide/" target="_blank">NAS</a>鐜涓紝鎴戜滑閫氬父甯屾湜瀹瑰櫒鑳界洿鎺ラ€氳繃灞€鍩熺綉IP璁块棶锛屾垨鑰呴渶瑕佹毚闇插涓鍙ｃ€�

鏈€绠€鍗曠殑鏂瑰紡鏄娇鐢╜network_mode: host`锛岃瀹瑰櫒鐩存帴浣跨敤瀹夸富鏈虹殑缃戠粶鏍堛€傝繖瀵逛簬Jellyfin銆丠ome Assistant绛夐渶瑕佺洿鎺ヨ闂‖浠惰澶囷紙濡侴PU銆乁SB杞覆鍙ｏ級鐨勫簲鐢ㄧ壒鍒噸瑕併€傜己鐐规槸绔彛蹇呴』鍞竴锛屼笉鑳藉悓鏃惰繍琛屼袱涓崰鐢ㄧ浉鍚岀鍙ｇ殑瀹瑰櫒銆�

鏇存帹鑽愮殑鍋氭硶鏄垱寤鸿嚜瀹氫箟bridge缃戠粶锛�

```yaml
networks:
  default:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24
```

鐒跺悗涓烘瘡涓湇鍔℃寚瀹氬浐瀹欼P锛�

```yaml
services:
  homeassistant:
    networks:
      default:
        ipv4_address: 172.20.0.10
```

杩欐牱鍙互瀹炵幇绫讳技"鍐呯綉IP"鐨勮闂柟寮忥紝姣忎釜瀹瑰櫒閮芥湁鐙珛鐨処P鍦板潃锛屼究浜庤蹇嗗拰绠＄悊銆傚悓鏃讹紝鑷畾涔夌綉缁滆繕鎻愪緵浜咲NS鑷姩鍙戠幇锛屽鍣ㄥ彲浠ラ€氳繃鏈嶅姟鍚嶇浉浜掕闂€�

## 鏁版嵁鍗风殑瑙勫垝鍘熷垯

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鐨勬暟鎹瓨鍌ㄥ垎涓轰笁绫伙細鍖垮悕鍗枫€佸懡鍚嶅嵎鍜宐ind鎸傝浇銆傚湪<a href="/guide/" target="_blank">NAS</a>鐜涓紝鎴戜滑鍑犱箮鍙敤bind鎸傝浇锛堝皢瀹夸富鏈虹殑鏂囦欢澶圭洿鎺ユ寕杩涘鍣級锛屽洜涓鸿繖鏍峰彲浠ユ柟渚垮湴鍦ㄦ枃浠剁鐞嗗櫒涓洿鎺ヨ闂暟鎹€�

瑙勫垝鏁版嵁鐩綍鏃讹紝寤鸿閲囩敤浠ヤ笅缁撴瀯锛�

```
/docker/
鈹溾攢鈹€ jellyfin/
鈹�   鈹溾攢鈹€ config/
鈹�   鈹溾攢鈹€ cache/
鈹�   鈹斺攢鈹€ transcode/
鈹溾攢鈹€ homeassistant/
鈹�   鈹斺攢鈹€ config/
鈹溾攢鈹€ immich/
鈹�   鈹溾攢鈹€ uploads/
鈹�   鈹溾攢鈹€ library/
鈹�   鈹斺攢鈹€ postgres/
鈹斺攢鈹€ compose/
    鈹溾攢鈹€ jellyfin.yml
    鈹溾攢鈹€ homeassistant.yml
    鈹斺攢鈹€ immich.yml
```

姣忎釜搴旂敤浣跨敤鐙珛鐨勬枃浠跺す锛岄厤缃洰褰曚笌鏁版嵁鐩綍鍒嗙锛孋ompose鏂囦欢缁熶竴鏀惧湪compose鐩綍涓嬨€傝繖绉嶇粨鏋勬竻鏅版槑浜嗭紝澶囦唤鏃跺彧闇€鎵撳寘鏁翠釜docker鐩綍鍗冲彲銆�

## 鑷姩鍖栦笌鐩戞帶

涓€鏃﹀鍣ㄦ暟閲忚秴杩�10涓紝鎵嬪姩绠＄悊灏变細鍙樺緱闈炲父鍚冨姏銆傚缓璁娇鐢�<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>鎴朩atchtower鏉ュ寮虹鐞嗕綋楠屻€�<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>鎻愪緵浜嗗浘褰㈠寲鐨勫鍣ㄧ鐞嗙晫闈紝鍙互鐩磋鍦版煡鐪嬪鍣ㄧ姸鎬併€佹棩蹇椼€佽祫婧愪娇鐢紝骞舵敮鎸佷竴閿噸鍚€佽繘鍏ョ粓绔瓑鎿嶄綔銆俉atchtower鍒欎細鑷姩妫€娴嬪鍣ㄦ洿鏂帮紝褰撻暅鍍忔湁鏂扮増鏈椂鑷姩鎷夊彇骞堕噸寤哄鍣紝瀹炵幇"鏃犳劅鍗囩骇"銆�

瀵逛簬鏇磋繘闃剁殑鐢ㄦ埛锛屽彲浠ヤ娇鐢�<a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>鐨別xtends鍔熻兘鎴栦笓闂ㄧ殑宸ュ叿濡侱uppy鏉ュ疄鐜伴厤缃殑妯″潡鍖栧拰澶嶇敤銆備緥濡傦紝鍒涘缓涓€涓熀纭€閰嶇疆鏂囦欢瀹氫箟閫氱敤鐨勭幆澧冨彉閲忓拰缃戠粶璁剧疆锛屽叾浠栨湇鍔＄殑Compose鏂囦欢鍙互缁ф壙瀹冿紝閬垮厤閲嶅閰嶇疆銆�

## 缁撹

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>瀹瑰櫒绠＄悊鐪嬩技澶嶆潅锛屼絾鍙鎺屾彙浜嗘纭殑鏂规硶锛屽氨鑳戒簨鍗婂姛鍊嶃€傞厤缃唬鐮佸寲銆佹潈闄愭槑纭寲銆佺綉缁滄竻鏅板寲銆佹暟鎹垎绂诲寲鈥斺€旇繖鍥涘ぇ鍘熷垯鏄�<a href="/guide/" target="_blank">NAS</a> <a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏈€浣冲疄璺电殑鏍稿績銆傚紑濮嬫椂澶氳姳涓€鐐规椂闂磋鍒掓灦鏋勶紝鏃ュ悗鐨勮繍缁村皢浼氳交鏉惧緢澶氥€傚綋浣犺兘澶熺敤鍑犺鍛戒护灏遍噸寤烘暣涓簲鐢ㄧ幆澧冿紝褰撲綘鎯冲崌绾ф煇涓湇鍔″彧闇€淇敼涓€涓増鏈彿锛屽綋浣犲彲浠ヨ交鏉惧皢鎵€鏈夐厤缃縼绉诲埌鏂拌澶団€斺€斾綘浼氬彂鐜帮紝杩欐墠鏄湡姝ｇ殑"鐪佸績"銆�

---

*鎯充簡瑙ｆ洿澶�<a href="/guide/" target="_blank">NAS</a>鎶€宸э紵鏌ョ湅 [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/guide/nas-beginner-guide-2026/" rel="next">涓嬩竴椤碉細NAS鏂版墜瀹屽叏鎸囧崡锛�2026骞翠粠闆跺紑濮嬫瀯寤轰綘鐨勭鏈変簯</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
