---
title: "NAS鐢摜鏁ら張宥呭缁旑垰褰涢崘鑼崐閿涚喐澧滈幎濠冨閺佹瑤缍橀幒鎺撶叀娑撳氦袙閸愶拷"
date: 2026-03-06
categories: ["nas"]
summary: "NAS缁旑垰褰涢崘鑼崐鐎佃壈鍤ч張宥呭閺冪姵纭堕崥顖氬З閿涚喐鏆€娴ｇ姴鎻╅柅鐔风暰娴ｅ秹妫舵０妯碱伂閸欙絽鑻熺憴锝呭枀"
tags: ["NAS", "缁旑垰褰涢崘鑼崐", "閺佸懘娈伴幒鎺撶叀", "Docker", "缂冩垹绮�"]
slug: "nas-port-conflict-troubleshooting-2026"
---

# NAS鐢摜鏁ら張宥呭缁旑垰褰涢崘鑼崐閿涚喐澧滈幎濠冨閺佹瑤缍橀幒鎺撶叀娑撳氦袙閸愶拷


<a href="/guide/" target="_blank">NAS</a>娑撳﹥婀囬崝陇绉洪弶銉ㄧШ婢舵熬绱濈粩顖氬經閸愯尙鐛婇幋鎰礋鐢瓕顫嗛梻顕€顣介妴鍌欑矕婢垛晜鏆€娴ｇ姴婀紘銈嗘珋/閺嬩胶鈹栭梻锟�/婵炰浇浠堥柅姘瑐韫囶偊鈧喎鐣炬担宥呰嫙鐟欙絽鍠呯粩顖氬經閸愯尙鐛婇妴锟�

## 鐢瓕顫嗛崘鑼崐缁旑垰褰涙稉鈧憴锟�

娴犮儰绗呯粩顖氬經閺堚偓鐎硅妲楅崘鑼崐閿涘奔濞囬悽銊ュ閸斺€崇箑濡偓閺屻儻绱�

| 缁旑垰褰� | 鐢瓕顫嗛張宥呭 |
|------|----------|
| 80 | HTTP姒涙ǹ顓荤粩顖氬經 |
| 443 | HTTPS姒涙ǹ顓荤粩顖氬經 |
| 8080 | 娴狅絿鎮�/婢跺洨鏁TTP |
| 8443 | 婢跺洨鏁TTPS |
| 22 | SSH鏉╂粎鈻� |
| 21 | FTP |
| 9000 | <a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a> |
| 9090 | Prometheus |
| 3000 | Grafana/<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> |
| 32400 | Plex |
| 8920 | Sonarr |
| 8989 | Sonarr |
| 7878 | Radarr |
| 51413 | Deluge |

## 閹烘帗鐓￠弬瑙勭《

### 閺傝纭舵稉鈧敍姘叀閻拷<a href="/guide/docker-best-practice/" target="_blank">Docker</a>閺冦儱绻�

瑜版挸顔愰崳銊ユ儙閸斻劌銇戠拹銉︽閿涘本鐓￠惇瀣）韫囨妲搁張鈧惄瀛樺复閻ㄥ嫭鏌熷蹇ョ窗

---

*閺囨潙顦�<a href="/guide/" target="_blank">NAS</a>閺佹瑧鈻肩拠宄板彠濞夛拷 [NAS鐎涳箓娅宂(/guide/)閵嗭拷*

<div class="page-nav">
  <a href="/ai/llm-performance-optimization-2026/" rel="prev">娑撳﹣绔存い纰夌窗閺堫剙婀存径褎膩閸ㄥ鈧嗗厴娴兼ê瀵�</a>
</div>

*閺堫剚鏋冮悽锟� NUC NAS Hub 閼奉亜濮╅悽鐔稿灇*
