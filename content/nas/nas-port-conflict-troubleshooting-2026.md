---
title: "NAS甯哥敤鏈嶅姟绔彛鍐茬獊锛熸墜鎶婃墜鏁欎綘鎺掓煡涓庤В鍐�"
date: 2026-03-06
categories: ["nas"]
summary: "NAS绔彛鍐茬獊瀵艰嚧鏈嶅姟鏃犳硶鍚姩锛熸暀浣犲揩閫熷畾浣嶉棶棰樼鍙ｅ苟瑙ｅ喅"
tags: ["NAS", "绔彛鍐茬獊", "鏁呴殰鎺掓煡", "Docker", "缃戠粶"]
slug: "nas-port-conflict-troubleshooting-2026"
---

# NAS甯哥敤鏈嶅姟绔彛鍐茬獊锛熸墜鎶婃墜鏁欎綘鎺掓煡涓庤В鍐�


<a href="/guide/" target="_blank">NAS</a>涓婃湇鍔¤秺鏉ヨ秺澶氾紝绔彛鍐茬獊鎴愪负甯歌闂銆備粖澶╂暀浣犲湪缇ゆ櫀/鏋佺┖闂�/濞佽仈閫氫笂蹇€熷畾浣嶅苟瑙ｅ喅绔彛鍐茬獊銆�

## 甯歌鍐茬獊绔彛涓€瑙�

浠ヤ笅绔彛鏈€瀹规槗鍐茬獊锛屼娇鐢ㄥ墠鍔″繀妫€鏌ワ細

| 绔彛 | 甯歌鏈嶅姟 |
|------|----------|
| 80 | HTTP榛樿绔彛 |
| 443 | HTTPS榛樿绔彛 |
| 8080 | 浠ｇ悊/澶囩敤HTTP |
| 8443 | 澶囩敤HTTPS |
| 22 | SSH杩滅▼ |
| 21 | FTP |
| 9000 | <a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a> |
| 9090 | Prometheus |
| 3000 | Grafana/<a href="/guide/jellyfin-hw-transcode/" target="_blank">Jellyfin</a> |
| 32400 | Plex |
| 8920 | Sonarr |
| 8989 | Sonarr |
| 7878 | Radarr |
| 51413 | Deluge |

## 鎺掓煡鏂规硶

### 鏂规硶涓€锛氭煡鐪�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>鏃ュ織

褰撳鍣ㄥ惎鍔ㄥけ璐ユ椂锛屾煡鐪嬫棩蹇楁槸鏈€鐩存帴鐨勬柟寮忥細

---

*鏇村<a href="/guide/" target="_blank">NAS</a>鏁欑▼璇峰叧娉� [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/ai/llm-performance-optimization-2026/" rel="prev">涓婁竴椤碉細鏈湴澶фā鍨嬫€ц兘浼樺寲</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
