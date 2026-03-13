---
title: "Tailscale 鍐呯綉绌块€忔暀绋嬶細闅忔椂闅忓湴璁块棶 NAS"
date: 2026-01-01
categories: ["nas"]
summary: "Tailscale 鍐呯綉绌块€忔暀绋嬶紝鍏嶈垂绋冲畾"
tags: ["Tailscale", "鍐呯綉绌块€�", "杩滅▼璁块棶", "NAS"]
slug: "tailscale-remote-access"
---

# Tailscale 鍐呯綉绌块€忔暀绋�

## 浠€涔堟槸 Tailscale锛�

Tailscale 鏄熀浜� WireGuard 鐨勫唴缃戠┛閫忓伐鍏凤紝绠€鍗曟槗鐢ㄣ€�

## 涓轰粈涔堥€夋嫨 Tailscale锛�

- 鉁� 鍏嶈垂涓汉浣跨敤
- 鉁� 绠€鍗曟槗鐢�
- 鉁� 绋冲畾蹇€�
- 鉁� 鏀寔鎵€鏈夊钩鍙�

## 瀹夎姝ラ

### 1. 娉ㄥ唽璐﹀彿

璁块棶 tailscale.com 娉ㄥ唽璐﹀彿銆�

### 2. 涓嬭浇瀹㈡埛绔�

- Windows锛氬畼缃戜笅杞�
- macOS锛歚brew install tailscale`
- Linux锛歚curl -fsSL https://tailscale.com/install.sh | sh`

### 3. 鐧诲綍

```bash
tailscale up
```

浼氳嚜鍔ㄦ墦寮€娴忚鍣ㄧ櫥褰曘€�

## 浣跨敤鏂规硶

### 璁块棶 NAS

```bash
# 鏌ョ湅璁惧鍒楄〃
tailscale status

# 閫氳繃璁惧鍚嶈闂�
ssh user@nas100.tail-scale.ts.net
```

### 绔彛杞彂

```bash
# 杞彂 NAS 鐨� 8080 绔彛鍒版湰鍦�
tailscale funnel 8080
```

### 寮€鍚妭鐐�

```bash
# 灏� NAS 浣滀负鍑哄彛鑺傜偣
tailscale up --advertise-exit-node
```

## 搴旂敤鍦烘櫙

### 1. 璁块棶 NAS 鏂囦欢

```
\\nas100.tail-scale.ts.net
```

### 2. 杩滅▼妗岄潰

```
mstsc /v:nas100.tail-scale.ts.net
```

### 3. SSH 鐧诲綍

```
ssh user@nas100.tail-scale.ts.net
```

## 甯歌闂

### Q: 杩炴帴鎱紵

A: 灏濊瘯浣跨敤 DERP 涓户鏈嶅姟鍣�

### Q: 娴侀噺闄愬埗锛�

A: 鍏嶈垂鐗堟瘡鏈� 100GB锛岃冻澶熶娇鐢�

## 鎬荤粨

Tailscale 鏄闂� NAS 鐨勬渶浣虫柟妗堬紝绠€鍗曠ǔ瀹氥€�

**鎺ㄨ崘鎸囨暟**锛氣瓙猸愨瓙猸愨瓙
