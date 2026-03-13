---
title: "2026骞碞AS蹇呰Docker搴旂敤鎺ㄨ崘锛氭彁鍗囩鏈変簯鐢熶骇鍔�"
date: 2026-03-05
categories: ["nas"]
tags: ["NAS", "Docker", "绉佹湁浜�", "搴旂敤鎺ㄨ崘", "Docker Compose"]
platform: "nas"
slug: "nas-docker-apps-recommend-2026-v3"
---

# 2026骞碞AS蹇呰Docker搴旂敤锛氳繖20涓簲鐢ㄨ浣犵殑绉佹湁浜戞洿寮哄ぇ


**鏇存柊鏃ユ湡锛�** 2026骞�3鏈�5鏃�

## 涓€銆佸墠瑷€

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏄�<a href="/guide/" target="_blank">NAS</a>杩涢樁鐜╂硶鐨勬牳蹇冦€傚€熷姪<a href="/guide/docker-best-practice/" target="_blank">Docker</a>锛屼綘鍙互鍦�<a href="/guide/" target="_blank">NAS</a>涓婅繍琛屽悇绉嶆湇鍔★紝浠庢枃浠剁鐞嗗埌鏅鸿兘瀹跺眳锛屼粠褰遍煶濞变箰鍒癆I搴旂敤銆傛湰鏂囩簿閫�20涓繀澶�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>搴旂敤锛岃浣犵殑<a href="/guide/" target="_blank">NAS</a>鐗╄秴鎵€鍊笺€�

## 浜屻€佸繀澶囧伐鍏风被

### 2.1 <a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>锛堝鍣ㄧ鐞嗭級

```yaml
version: '3'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
```

**鍔熻兘**锛氬浘褰㈠寲<a href="/guide/docker-best-practice/" target="_blank">Docker</a>绠＄悊闈㈡澘锛屽彲瑙嗗寲瀹瑰櫒銆侀暅鍍忋€佺綉缁滅鐞�

**鎺ㄨ崘鐞嗙敱**锛氬繀瑁咃紒绠＄悊<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏇寸洿瑙�

### 2.2 FileBrowser锛堟枃浠剁鐞嗭級

**鍔熻兘**锛氱綉椤电増鏂囦欢绠＄悊鍣紝鏀寔鎷栨嫿涓婁紶銆佸湪绾块瑙堛€佹潈闄愮鐞�

**鏇夸唬鏂规**锛�<a href="/guide/alist-network-aggregation-2026/" target="_blank">Alist</a>锛堢綉鐩樿仛鍚堬級

### 2.3 Nginx Proxy Manager锛堝弽鍚戜唬鐞嗭級

**鍔熻兘**锛氬浘褰㈠寲閰嶇疆鍙嶅悜浠ｇ悊锛屾敮鎸丩et's Encrypt鑷姩SSL璇佷功

**鎺ㄨ崘鐞嗙敱**锛氬唴缃戠┛閫忋€佸煙鍚嶈闂繀澶�

## 涓夈€佸奖闊冲ū涔愮被

### 3.1 Jellyfin锛堝獟浣撴湇鍔″櫒锛�

**鍔熻兘**锛氳嚜寤哄奖瑙嗗簱锛屾敮鎸佹捣鎶ュ銆佺‖浠惰浆鐮併€佽繙绋嬭闂�

**鎺ㄨ崘閰嶇疆**锛�
```yaml
jellyfin:
  image: jellyfin/jellyfin:latest
  container_name: jellyfin
  restart: unless-stopped
  environment:
    - TZ=Asia/Shanghai
  volumes:
    - ./config:/config
    - ./cache:/cache
    - /path/to/media:/media
  ports:
    - "8096:8096"
    - "8920:8920"
```

### 3.2 Bazarr锛堝瓧骞曚笅杞斤級

**鍔熻兘**锛氳嚜鍔ㄤ笅杞界數褰�/鍓ч泦瀛楀箷锛屾敮鎸佸璇█

**閰嶅悎**锛欽ellyfin/Plex

### 3.3 qBittorrent锛堜笅杞斤級

**鍔熻兘**锛欱T/PT涓嬭浇锛屾敮鎸佽嚜鍔≧SS璁㈤槄

**鎺ㄨ崘鎼厤**锛欽ackett锛堢储寮曪級

## 鍥涖€佺収鐗囩鐞嗙被

### 4.1 <a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>锛圓I鐩稿唽锛�

**鍔熻兘**锛欸oogle Photos寮€婧愭浛浠ｏ紝AI浜鸿劯璇嗗埆銆佸湴鍥捐鍥俱€佸浠藉悓姝�

**浜偣**锛�
- 绉诲姩绔疉pp鏀寔
- AI浜鸿劯璇嗗埆
- 鍦扮悊浣嶇疆灞曠ず
- 鑷姩澶囦唤鎵嬫満鐓х墖

### 4.2 PhotoPrism锛圓I鐩稿唽锛�

**鍔熻兘**锛氬彟涓€娆惧己澶х殑AI鐩稿唽锛屾敮鎸佺墿浣撹瘑鍒€佸湴鍚嶈瘑鍒�

**瀵规瘮**锛�<a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>鏇存敞閲嶇Щ鍔ㄧ浣撻獙锛孭hotoPrism缃戦〉鍔熻兘鏇翠赴瀵�

## 浜斻€佹櫤鑳藉灞呯被

### 5.1 <a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant</a>

**鍔熻兘**锛氬紑婧愭櫤鑳藉灞呭钩鍙帮紝鏀寔鏁板崈绉嶈澶�

**鎺ㄨ崘閰嶇疆**锛氫娇鐢∣S鐗堟湰閫氳繃KVM/Proxmox杩愯锛屾€ц兘鏇村ソ

**蹇呰鎻掍欢**锛�
- HACS锛堢ぞ鍖烘彃浠跺晢搴楋級
- ESPHome锛圖IY璁惧锛�
- Node-RED锛堣嚜鍔ㄥ寲锛�

### 5.2 AdGuard Home锛堝箍鍛婅繃婊わ級

**鍔熻兘**锛氬叏缃戝箍鍛婃嫤鎴紝DNS杩囨护锛屼繚鎶ゅ浜轰笂缃�

**鎺ㄨ崘鐞嗙敱**锛氭瘮璺敱鍣ㄥ箍鍛婅繃婊ゆ洿寮哄ぇ

## 鍏€佹晥鐜囧伐鍏风被

### 6.1 Syncthing锛堟枃浠跺悓姝ワ級

**鍔熻兘**锛氬璁惧鏂囦欢鍚屾锛屾浛浠ｇ櫨搴︾綉鐩�/OneDrive

**浼樺娍**锛氱偣瀵圭偣鍔犲瘑浼犺緭锛屼笉璧扮涓夋柟鏈嶅姟鍣�

### 6.2 Wallabag锛堢◢鍚庨槄璇伙級

**鍔熻兘**锛氬紑婧愮◢鍚庨槄璇伙紝鏀惰棌鏂囩珷绂荤嚎鏌ョ湅

### 6.3 LinkStack锛堜釜浜哄鑸〉锛�

**鍔熻兘**锛氳嚜寤虹綉鍧€瀵艰埅锛岀被浼糒inktree

### 6.4 Uptime Kuma锛堢洃鎺э級

**鍔熻兘**锛氳嚜寤虹綉绔�/鏈嶅姟鐩戞帶锛屾敮鎸佸憡璀﹂€氱煡

## 涓冦€丄I/寮€鍙戠被

### 7.1 <a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>锛堟湰鍦板ぇ妯″瀷锛�

**鍔熻兘**锛氬湪<a href="/guide/" target="_blank">NAS</a>涓婅繍琛孡lama 2銆丏eepSeek绛夊ぇ璇█妯″瀷

**鎺ㄨ崘閰嶇疆**锛氶渶瑕�16GB+鍐呭瓨锛屽缓璁甆5105浠ヤ笂CPU

### 7.2 OpenWebUI锛堝璇濈晫闈級

**鍔熻兘**锛欳hatGPT椋庢牸鐣岄潰锛岃繛鎺�<a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>鎴栧叾浠朅PI

### 7.3 Stable Diffusion WebUI锛圓I缁樼敾锛�

**鍔熻兘**锛氭湰鍦癆I缁樺浘锛岄渶鏄惧崱鏀寔

**鎺ㄨ崘閰嶇疆**锛歊TX 3060浠ヤ笂鏄惧崱

## 鍏€佸涔�/宸ュ叿绫�

### 8.1 CodeServer锛堜簯绔疘DE锛�

**鍔熻兘**锛氭祻瑙堝櫒涓紪绋嬶紝鏀寔VS Code

### 8.2 PiKVM锛圛PKVM鏇夸唬锛�

**鍔熻兘**锛氳繙绋婯VM over IP锛岀‖浠剁淮鎶ゅ埄鍣�

### 8.3 WikiJS锛堢煡璇嗗簱锛�

**鍔熻兘**锛氳嚜寤轰釜浜�/鍥㈤槦鐭ヨ瘑搴�

## 涔濄€佸畨瑁呭缓璁�

### 9.1 <a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>妯℃澘

鎺ㄨ崘浣跨敤<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>鐨�"Stacks"鍔熻兘鎴�<a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>绠＄悊

### 9.2 璧勬簮鍒嗛厤

| 搴旂敤 | CPU | 鍐呭瓨 |
| :--- | :--- | :--- |
| Jellyfin | 2鏍�+ | 4GB+ |
| Home Assistant | 1鏍� | 2GB |
| <a href="/guide/immich-photo-cloud/" target="_blank">Immich</a> | 2鏍� | 4GB+ |
| <a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a> | 4鏍� | 16GB+ |

### 9.3 鏁版嵁鎸佷箙鍖�

閲嶈鏁版嵁浣跨敤volume鏄犲皠锛屽鍣ㄩ噸瑁呬笉涓㈠け锛�
```yaml
volumes:
  - ./data:/app/data
  - /mnt/storage:/storage
```

## 鍗併€佹€荤粨

杩�20娆�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>搴旂敤娑电洊浜�<a href="/guide/" target="_blank">NAS</a>鐨勬柟鏂归潰闈細

- **宸ュ叿绫�**锛�<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>銆丯ginx PM銆丗ileBrowser
- **褰遍煶绫�**锛欽ellyfin銆丅azarr銆乹Bittorrent
- **鐩稿唽绫�**锛�<a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>銆丳hotoPrism
- **瀹跺眳绫�**锛�<a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant</a>銆丄dGuard
- **鏁堢巼绫�**锛歋yncthing銆乄allabag
- **AI绫�**锛�<a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>銆丱penWebUI

**瀹夎寤鸿**锛氫粠绠€鍗曞簲鐢ㄥ紑濮嬶紝閫愭娣卞叆銆�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>璁�<a href="/guide/" target="_blank">NAS</a>鐪熸鎴愪负鐢熶骇鍔涘伐鍏凤紒

**鐩稿叧鏁欑▼**锛�
- [<a href="/guide/docker-best-practice/" target="_blank">NAS Docker鍏ラ棬鎸囧崡</a>](/guide/docker-best-practice/)
- [<a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant瀹夎閰嶇疆</a>](/guide/home-assistant-nuc/)

---

*鏇村鍐呭璇峰叧娉� [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/guide/nas-beginner-guide-2026/" rel="prev">涓婁竴椤碉細NAS鏂版墜瀹屽叏鎸囧崡锛�2026骞翠粠闆跺紑濮嬫瀯寤轰綘鐨勭鏈変簯</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
