---
slug: "jellyfin-hw-transcode"
title: "Jellyfin 纭В鍏ㄦ敾鐣ワ細寮€鍚� Intel 鏍告樉 4K 鍘嬫Θ"
date: 2026-02-12
summary: "瑙ｅ喅鎾斁鍗￠】锛岃 NUC 杞绘澗鍚屾椂杞彂 5 璺� 4K 瑙嗛銆�"
categories: ["nas"]
---

# Jellyfin 纭В鍏ㄦ敾鐣ワ細寮€鍚� Intel 鏍告樉 4K 鍘嬫Θ


<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鏄紑婧愬濯掍綋棰嗗煙鐨勬槑鏄熼」鐩紝浣滀负Emby鐨勬缁熺簿绁炵户鎵胯€咃紝瀹冨畬鍏ㄥ厤璐广€佸姛鑳藉己澶с€佹敮鎸佸叏骞冲彴銆傜劧鑰岋紝寰堝鐢ㄦ埛鍦ㄩ儴缃�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鍚庡彂鐜版挱鏀�4K瑙嗛鏃禖PU鍗犵敤鐜囬鍗囥€佺敾闈㈠崱椤裤€佺敋鑷虫棤娉曟祦鐣呮挱鏀锯€斺€旇繖閫氬父鏄洜涓烘病鏈夋纭惎鐢ㄧ‖浠惰В鐮侊紙纭В锛夈€傚浜庝娇鐢↖ntel NUC鐨勭敤鎴锋潵璇达紝鍒╃敤鏍告樉杩涜纭В鏄В鍐宠繖涓棶棰樼殑鏈€浣虫柟妗堛€傛湰鏂囧皢甯︽潵瀹屾暣鐨�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>纭В閰嶇疆鏁欑▼锛岃浣犲厖鍒嗗帇姒∟UC鐨勬€ц兘锛屽疄鐜板璺�4K瑙嗛鍚屾椂鎾斁銆�

## 涓轰粈涔堣鐢ㄧ‖浠惰В鐮�

鍦ㄧ悊瑙ｇ‖瑙ｄ箣鍓嶏紝鎴戜滑鍏堟潵浜嗚В涓€涓嬭蒋瑙ｃ€傝蒋瑙ｏ紙Software Decoding锛夋槸鎸囧畬鍏ㄤ緷闈燙PU鏉ヨВ鐮佽棰戙€�4K瑙嗛鐨勮В鐮佽绠楅噺闈炲父澶э紝鍗充娇鏄€ц兘杈冨己鐨勬闈PU锛屽湪澶勭悊HEVC锛圚.265锛夋垨AV1缂栫爜鐨�4K瑙嗛鏃朵篃浼氬姏涓嶄粠蹇冦€傜粨鏋滃氨鏄挱鏀惧崱椤裤€佸彂鐑弗閲嶃€�<a href="/guide/" target="_blank">NAS</a>鍏朵粬鏈嶅姟涔熻鎷栫疮銆�

纭欢瑙ｇ爜锛圚ardware Decoding锛岀畝绉扮‖瑙ｏ級鍒欐槸鍒╃敤GPU锛堟樉鍗★級鐨勪笓鐢ㄨВ鐮佸崟鍏冩潵瀹屾垚浠诲姟銆傜幇浠ntel澶勭悊鍣ㄩ兘闆嗘垚浜哘uick Sync Video锛圦SV锛夌‖浠惰В鐮佸櫒锛屼笓闂ㄤ负瑙嗛缂栬В鐮佷紭鍖栵紝鏁堢巼杩滈珮浜嶤PU杞В銆備互Intel UHD 630鏍告樉涓轰緥锛屽畠鍙互鍦ㄤ粎鍗犵敤涓綅鏁癈PU鐧惧垎姣旂殑鎯呭喌涓嬭交鏉捐В鐮�4K HEVC瑙嗛锛屽璺苟鍙戜篃涓嶅湪璇濅笅銆�

杩欏氨鏄负浠€涔堟帹鑽愪娇鐢↖ntel NUC浣滀负瀹跺涵褰遍櫌鏈嶅姟鍣ㄧ殑鍘熷洜鈥斺€擭UC鐨勬牳鏄炬鏄负杩欑被鍦烘櫙璁捐鐨勩€�

## 纭欢瑕佹眰涓庣幆澧冪‘璁�

鍦ㄥ紑濮嬮厤缃箣鍓嶏紝鍏堢‘璁や綘鐨勭‖浠剁幆澧冦€傜悊璁轰笂锛屼粠绗�6浠ntel閰风澘锛圫kylake锛夊紑濮嬬殑澶勭悊鍣ㄩ兘鏀寔Quick Sync Video锛屾兜鐩栦簡澶у鏁拌繎骞磋喘涔扮殑NUC銆傚叿浣撴潵璇达細

- **NUC 6-7浠�**锛圫kylake/Kaby Lake锛夛細Intel HD 500绯诲垪鏍告樉锛屾敮鎸�4K H.264/HEVC纭В
- **NUC 8-10浠�**锛圕offee Lake/Comet Lake锛夛細Intel UHD 600绯诲垪鏍告樉锛屽鍔犱簡VP9纭В鏀寔
- **NUC 11浠ｅ強浠ヤ笂**锛圱iger Lake/Rocket Lake/Alder Lake锛夛細Intel Xe鏍告樉锛屾柊澧濧V1纭В瑙ｇ爜

纭NUC鍨嬪彿鍚庯紝杩橀渶瑕佺‘淇濈郴缁熷凡缁忔纭瘑鍒牳鏄俱€傚湪缇ゆ櫀鎴朤rueNAS涓紝鍙互閫氳繃SSH鎵ц`lspci | grep -i vga`鏉ユ煡鐪嬫樉鍗℃槸鍚﹁璇嗗埆銆傚鏋滆緭鍑烘樉绀篒ntel UHD Graphics鎴栫被浼间俊鎭紝璇存槑绯荤粺宸茬粡鍔犺浇浜嗘牳鏄鹃┍鍔ㄣ€�

## <a href="/guide/docker-best-practice/" target="_blank">Docker</a>鐜涓嬬殑纭В閰嶇疆

澶у鏁扮敤鎴烽€氳繃<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏉ヨ繍琛�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>锛岃繖涔熸槸鏈€鎺ㄨ崘鐨勯儴缃叉柟寮忋€備互涓嬫槸閰嶇疆纭В鐨勫畬鏁存楠わ細

绗竴姝ワ紝鍒涘缓涓€涓敮鎸丟PU鐨�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>缃戠粶銆傚湪docker-compose.yml涓坊鍔犱互涓嬮厤缃細

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

鍏抽敭鏄痐devices`瀛楁锛屽畠灏嗗涓绘満鐨凞irect Rendering Infrastructure锛圖RI锛夎澶囨槧灏勮繘瀹瑰櫒銆傝繖浜涜澶囧寘鎷琡/dev/dri/card0`锛堢涓€涓狦PU锛夊拰`/dev/dri/renderD128`锛堟覆鏌撹妭鐐癸級銆傚鏋滀綘鐨�<a href="/guide/" target="_blank">NAS</a>鏈夊涓牳鏄炬垨鏄惧崱锛屽彲鑳介渶瑕佹槧灏勫涓澶囥€�

濡傛灉浣跨敤缇ゆ櫀鐨凜ontainer Manager锛�<a href="/guide/docker-best-practice/" target="_blank">Docker</a> GUI锛夛紝鎿嶄綔鏇村姞绠€鍗曪細鍒涘缓瀹瑰櫒鏃讹紝鍦�"楂樼骇璁剧疆"鐨�"鐜鍙橀噺"涓坊鍔燻TZ=Asia/Shanghai`锛涘湪"璁惧"閫夐」鍗′腑娣诲姞`/dev/dri`璺緞骞跺嬀閫�"鍏佽瀹瑰櫒璁块棶"銆�

绗簩姝ワ紝閰嶇疆<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鐨勮В鐮佸櫒璁剧疆銆傚鍣ㄥ惎鍔ㄥ悗锛岃闂�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> Web鐣岄潰锛岃繘鍏�"鎺у埗鍙�" > "鎾斁" > "杞爜"锛岃繘琛屼互涓嬭缃細

- **纭欢鍔犻€�**锛氶€夋嫨"Intel QuickSync (QSV)"
- **纭欢瑙ｇ爜閫夐」**锛氬嬀閫塇EVC锛圚.265锛夈€乂P9銆丄V1绛夐渶瑕佺‖瑙ｇ殑缂栫爜鏍煎紡
- **缂栫爜璐ㄩ噺棰勮**锛氶€夋嫨"蹇€�"鎴�"鎱㈤€�"锛�"very fast"浼氫娇鐢ㄦ洿澶欸PU璧勬簮鎹㈠彇鏇翠綆鐨凜PU鍗犵敤锛�

濡傛灉"纭欢鍔犻€�"涓嬫媺鑿滃崟涓病鏈塓SV閫夐」锛岃鏄嶥RI璁惧娌℃湁姝ｇ‘鏄犲皠杩涘鍣ㄣ€傞渶瑕佹鏌�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閰嶇疆鎴栧涓绘満椹卞姩鏄惁姝ｇ‘鍔犺浇銆�

## 缇ゆ櫀DSM鍘熺敓鐨勭‖瑙ｉ厤缃�

濡傛灉浣犱娇鐢ㄧ兢鏅朌SM锛堣€岄潪<a href="/guide/docker-best-practice/" target="_blank">Docker</a>锛夛紝閰嶇疆纭В鐨勬柟寮忕暐鏈変笉鍚屻€傜兢鏅栫殑Video Station鍘熺敓鏀寔Intel鏍告樉纭В锛屼絾闇€瑕佺‘淇濈郴缁熸纭姞杞戒簡椹卞姩銆�

棣栧厛锛屽湪DSM鐨�"鎺у埗闈㈡澘" > "缁堢鏈哄拰SNMP"涓紑鍚疭SH鍔熻兘銆傜劧鍚庨€氳繃SSH杩炴帴鍒扮兢鏅栵紝鎵ц浠ヤ笅鍛戒护妫€鏌ユ牳鏄炬槸鍚﹁璇嗗埆锛�

```bash
ls -la /dev/dri/
```

濡傛灉鐪嬪埌`card0`鍜宍renderD128`璁惧锛岃鏄庨┍鍔ㄥ凡鍔犺浇銆傛帴涓嬫潵瀹夎Video Station锛堝鏋滃皻鏈畨瑁咃級锛屽畠浼氳嚜鍔ㄨ皟鐢ㄦ牳鏄捐繘琛岃浆鐮併€�

瀵逛簬<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>锛岀兢鏅栧畼鏂规彁渚涗簡"鍏冩暟鎹�"鍖咃紝浣嗗鏋滀綘鎯宠幏寰楁洿濂界殑鎬ц兘鍜屾洿澶氬姛鑳斤紝鎺ㄨ崘浣跨敤<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏂瑰紡杩愯銆傜兢鏅栫殑<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鐜鍙互瀹屾暣鏀寔鏍告樉鐩撮€氥€�

## TrueNAS Scale涓殑纭В閰嶇疆

TrueNAS Scale鍩轰簬Debian Linux锛岄厤缃�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>纭В闇€瑕佷竴浜涢澶栨楠ゃ€傞鍏堢‘淇濈郴缁熷凡缁忓姞杞絀ntel GPU椹卞姩锛�

```bash
sudo modprobe i915
```

鐒跺悗鍦═rueNAS鐨�"Apps"涓畨瑁�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鏃讹紝闇€瑕侀€氳繃"Extra Args"娣诲姞璁惧鏄犲皠锛�

```yaml
extraArgs:
  - --device=/dev/dri:/dev/dri
```

瀹夎瀹屾垚鍚庯紝鍦�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鎺у埗鍙颁腑鍚敤QSV鍔犻€熷嵆鍙€�

## 楠岃瘉纭В鏄惁鐢熸晥

閰嶇疆瀹屾垚鍚庯紝鍙互閫氳繃澶氱鏂瑰紡楠岃瘉纭В鏄惁鐢熸晥锛�

**鏂规硶涓€锛氭挱鏀炬祴璇�**锛氭挱鏀句竴涓�4K HEVC瑙嗛锛屾墦寮€<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鐨勪华琛ㄦ澘锛屾煡鐪�"纭欢鍔犻€�"鐘舵€併€傚鏋滄樉绀�"QSV"锛岃鏄庣‖瑙ｅ凡鍚敤銆�

**鏂规硶浜岋細htop鐩戞帶**锛氶€氳繃SSH鎵цhtop锛岃瀵熸挱鏀捐棰戞椂CPU鍗犵敤銆傚鏋淐PU鍗犵敤寰堜綆锛堜綆浜�20%锛夛紝璇存槑瑙嗛瑙ｇ爜娌℃湁璧癈PU锛岃€屾槸鐢盙PU澶勭悊銆�

**鏂规硶涓夛細鏃ュ織妫€鏌�**锛氭煡鐪�<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>鏃ュ織锛屽鏋滅湅鍒�"Using Intel QuickSync"鎴栫被浼肩殑鏃ュ織锛岃鏄庣‖瑙ｅ凡鐢熸晥銆�

## 鎬ц兘鎻愬崌鏁堟灉

閰嶇疆纭В鍚庯紝鎬ц兘鎻愬崌闈炲父鏄庢樉銆備互涓€鍙癐ntel NUC 11浠ｏ紙N5105锛変负渚嬶細

| 娴嬭瘯鍦烘櫙 | 杞В | 纭В |
|----------|------|------|
| 鍗曡矾4K HEVC | 鍗￠】 | 娴佺晠 |
| 鍙岃矾4K HEVC | 鏃犳硶鎾斁 | 娴佺晠 |
| 涓夎矾4K HEVC | - | 娴佺晠 |
| CPU鍗犵敤 | 80%+ | 10%浠ュ唴 |

鍙互璇达紝鍚敤纭В鍚庯紝NUC鐨勮棰戣В鐮佽兘鍔涙彁鍗囦簡鏁板€嶏紝鐪熸鍙戞尌鍑轰簡"瀹跺涵褰遍櫌鏈嶅姟鍣�"鐨勬綔鍔涖€�

## 甯歌闂姹囨€�

**Q锛氭牳鏄鹃┍鍔ㄥ姞杞戒簡浣咼ellyfin涓湅涓嶅埌QSV閫夐」锛�**
A锛氭鏌�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>瀹瑰櫒鏄惁浠ョ壒鏉冩ā寮忚繍琛岋紝鎴栬€卄--device`鍙傛暟鏄惁姝ｇ‘鏄犲皠浜哷/dev/dri`銆�

**Q锛氬紑鍚‖瑙ｅ悗鎾斁浠嶇劧鍗￠】锛�**
A锛氱‘璁�"纭欢瑙ｇ爜閫夐」"涓嬀閫変簡瀵瑰簲鐨勭紪鐮佹牸寮忥紙濡侶EVC锛夛紝鍚屾椂妫€鏌ョ綉缁滃甫瀹芥槸鍚﹁冻澶燂紙濡傛灉鏄繙绋嬫挱鏀撅級銆�

**Q锛氱兢鏅朌ocker鍜屽師鐢烿ideo Station鍙互鍚屾椂浣跨敤鏍告樉鍚楋紵**
A锛氬彲浠ワ紝绯荤粺灞傞潰鐨勬牳鏄炬槸鍏变韩鐨勩€備絾寤鸿鍙湪涓€涓簲鐢ㄤ腑鍚敤纭В锛岄伩鍏嶈祫婧愮珵浜夈€�

## 鎬荤粨

<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a>纭В閰嶇疆鏄墦閫犲搴奖闄㈢殑鍏抽敭涓€姝ャ€傞€氳繃鍒╃敤Intel鏍告樉鐨凲uick Sync Video鑳藉姏锛屽嵆浣挎槸鍏ラ棬绾х殑NUC涔熻兘杞绘澗瀹炵幇澶氳矾4K瑙嗛鎾斁銆傚笇鏈涙湰鏁欑▼鑳藉府鍔╀綘鍏呭垎姒ㄥ共NUC鐨勬綔鍔涳紝浜彈娴佺晠鐨�4K瑙傚奖浣撻獙锛�

---

*鏇村<a href="/guide/" target="_blank">NAS</a>鏁欑▼璇峰叧娉� [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/guide/nas-system-comparison-2026/" rel="prev">涓婁竴椤碉細TrueNAS vs Unraid vs DSM锛�2026骞翠笁澶AS绯荤粺鍏ㄩ潰瀵规瘮</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
