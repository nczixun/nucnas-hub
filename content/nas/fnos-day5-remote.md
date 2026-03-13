---
title: "Day 5: 妞嬬偟澧癘S鏉╂粎鈻肩拋鍧楁６ 閳ユ柡鈧拷 Tailscale/FRP鐎瑰瞼绶ㄩ弬瑙勵攳"
date: 2026-03-11
summary: "闁俺绻僒ailscale閹存湉RP鐎圭偟骞囨径鏍秹鐎瑰鍙忕拋鍧楁６妞嬬偟澧癘S閵嗭拷"
categories: ["nas"]
slug: "fnos-day5-remote"
tags: ["妞嬬偟澧癘S", "鏉╂粎鈻肩拋鍧楁６", "Tailscale", "FRP"]
---

# Day 5: 妞嬬偟澧癘S鏉╂粎鈻肩拋鍧楁６


## 娑撹桨绮堟稊鍫ユ付鐟曚浇绻欑粙瀣問闂傤噯绱�

娑撳秴婀€硅埖妞傛稊鐔诲厴閿涳拷
- ?? 鐠佸潡妫堕弬鍥︽
- ?? 鐟欏倻婀呰ぐ杈╁
- ?? 缁狅紕鎮婄拋鍓х枂

## 閺傝顢嶆稉鈧敍锟�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>閿涘牊甯归懡鎰剁礆

### 娴犫偓娑斿牊妲窽ailscale閿涳拷

閸╄桨绨琖ireGuard閻ㄥ嫬绱撻崷鎵矋缂冩垵浼愰崗鍑ょ礉缁犫偓閸楁洖鐣ㄩ崗銊ｂ偓锟�

### 鐎瑰顥婂銉╊€�

1. 閸︺劑顥ｉ悧姹稴娑擃厼鐣ㄧ憗锟�<a href="/guide/tailscale-remote-access/" target="_blank">Tailscale</a>
2. 閻ц缍嶇拹锕€褰块懢宄板絿鐠佹儳顦€靛棝鎸�
3. 鐠佹澘缍嶇拋鎯ь槵閼哄倻鍋�

### 闁板秶鐤�

```bash
# 閸氼垰濮㏕ailscale
tailscale up --accept-routes

# 閺屻儳婀呴悩鑸碘偓锟�
tailscale status
```

### 娴兼ḿ鍋�
- ? 閸忓秷鍨�
- ? 閸旂姴鐦戠€瑰鍙�
- ? 缁犫偓閸楁洘妲楅悽锟�
- ? 閺€顖涘瘮閹碘偓閺堝顔曟径锟�

## 閺傝顢嶆禍宀嬬窗FRP閸愬懐缍夌粚鍧椻偓锟�

### 娴犫偓娑斿牊妲窮RP閿涳拷

闁俺绻冩稉顓℃祮閺堝秴濮熼崳銊ョ杽閻滄澘鍞寸純鎴犫敍闁繈鈧拷

### 閺堝秴濮熺粩顖炲帳缂冿拷

```yaml
# frps.ini
[common]
bind_port = 7000
token = your_token
```

---

<div class="page-nav">
  <a href="/guide/fnos-day4-network/" rel="prev">娑撳﹣绔存い纰夌窗Day 4閿涙岸顥ｉ悧姹稴缂冩垹绮堕柊宥囩枂</a>
  <a href="/guide/fnos-day6-docker/" rel="next">娑撳绔存い纰夌窗Day 6閿涙岸顥ｉ悧姹稴 Docker鎼存梻鏁�</a>
</div>

*閺堫剚鏋冮悽锟� NUC NAS Hub 閼奉亜濮╅悽鐔稿灇*
