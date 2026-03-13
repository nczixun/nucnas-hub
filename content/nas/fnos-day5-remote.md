---
title: "Day 5: 椋炵墰OS杩滅▼璁块棶 鈥斺€� Tailscale/FRP瀹岀編鏂规"
date: 2026-03-11
summary: "閫氳繃Tailscale鎴朏RP瀹炵幇澶栫綉瀹夊叏璁块棶椋炵墰OS銆�"
categories: ["nas"]
slug: "fnos-day5-remote"
tags: ["椋炵墰OS", "杩滅▼璁块棶", "Tailscale", "FRP"]
---

# Day 5: 椋炵墰OS杩滅▼璁块棶


## 涓轰粈涔堥渶瑕佽繙绋嬭闂紵

涓嶅湪瀹舵椂涔熻兘锛�
- ?? 璁块棶鏂囦欢
- ?? 瑙傜湅褰辩墖
- ?? 绠＄悊璁剧疆

## 鏂规涓€锛�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>锛堟帹鑽愶級

### 浠€涔堟槸Tailscale锛�

鍩轰簬WireGuard鐨勫紓鍦扮粍缃戝伐鍏凤紝绠€鍗曞畨鍏ㄣ€�

### 瀹夎姝ラ

1. 鍦ㄩ鐗汷S涓畨瑁�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>
2. 鐧诲綍璐﹀彿鑾峰彇璁惧瀵嗛挜
3. 璁板綍璁惧鑺傜偣

### 閰嶇疆

```bash
# 鍚姩Tailscale
tailscale up --accept-routes

# 鏌ョ湅鐘舵€�
tailscale status
```

### 浼樼偣
- ? 鍏嶈垂
- ? 鍔犲瘑瀹夊叏
- ? 绠€鍗曟槗鐢�
- ? 鏀寔鎵€鏈夎澶�

## 鏂规浜岋細FRP鍐呯綉绌块€�

### 浠€涔堟槸FRP锛�

閫氳繃涓浆鏈嶅姟鍣ㄥ疄鐜板唴缃戠┛閫忋€�

### 鏈嶅姟绔厤缃�

```yaml
# frps.ini
[common]
bind_port = 7000
token = your_token
```

---

<div class="page-nav">
  <a href="/guide/fnos-day4-network/" rel="prev">涓婁竴椤碉細Day 4锛氶鐗汷S缃戠粶閰嶇疆</a>
  <a href="/guide/fnos-day6-docker/" rel="next">涓嬩竴椤碉細Day 6锛氶鐗汷S Docker搴旂敤</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
