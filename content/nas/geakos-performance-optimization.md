---
title: "GEAKOS 鍐呭瓨鍗犵敤楂橈紵鎵嬫妸鎵嬫暀浣犳€ц兘浼樺寲"
date: 2026-03-06
categories: ["nas"]
slug: "geakos-performance-optimization"
summary: "GEAKOS鍐呭瓨鍗犵敤楂樿璇熺梾锛熸暀浣犻€氳繃Docker闄愬埗銆佸叧闂笉蹇呰鐨勬湇鍔°€佷紭鍖栭厤缃檷浣庡唴瀛樺崰鐢紝璁╀綆閰嶈澶囦篃鑳芥祦鐣呰繍琛屻€�"
tags: ["GEAKOS", "鎬ц兘浼樺寲", "NAS", "鍐呭瓨浼樺寲", "Docker"]
---

# GEAKOS 鍐呭瓨鍗犵敤楂橈紵鎵嬫妸鎵嬫暀浣犳€ц兘浼樺寲


<a href="/guide/geakos-day1-intro/" target="_blank">GEAKOS</a>鍙戝竷鍚庣ぞ鍖哄弽棣堟渶澶氱殑灏辨槸**鍐呭瓨鍗犵敤楂�**鐨勯棶棰樸€傛湁鐢ㄦ埛鍙嶆槧寮€鏈哄氨鍗犵敤2GB+鍐呭瓨锛岃繖鍦ㄤ綆閰嶇疆璁惧涓婄‘瀹炴槸涓棶棰樸€�

鍒€ワ紝鏈枃鏁欎綘鍑犳嫑鏈夋晥闄嶄綆鍐呭瓨鍗犵敤锛�

## 闂鍒嗘瀽锛氬唴瀛橀兘鍘诲摢浜嗭紵

<a href="/guide/geakos-day1-intro/" target="_blank">GEAKOS</a>榛樿鍚姩鐨勬湇鍔℃瘮杈冨锛�

- ?? AI鏈嶅姟锛堜汉鑴歌瘑鍒€佸満鏅瘑鍒級
- ?? 褰辫搴撴湇鍔�
- ?? GEAKLink杩滅▼璁块棶
- ?? <a href="/guide/geakos-performance-optimization/" target="_blank">Docker</a>瀹堟姢杩涚▼
- ?? 搴旂敤鏈嶅姟

濡傛灉浣犱笉鐢ˋI鍔熻兘鎴�<a href="/guide/geakos-performance-optimization/" target="_blank">Docker</a>瀹屽叏鍙互鍏抽棴鐩稿簲鏈嶅姟銆�

## 浼樺寲鏂规

### 鏂规1锛氬叧闂瑼I鏈嶅姟锛堣妭鐪亊800MB锛�

濡傛灉浣犵殑鐓х墖涓嶅锛孉I鍔熻兘涓嶆槸鍒氶渶锛屽彲浠ュ叧闂細

```bash
# SSH鐧诲綍鍚庢墽琛�
docker stop geekai
docker disable geekai
```

### 鏂规2锛氶檺鍒�<a href="/guide/geakos-performance-optimization/" target="_blank">Docker</a>鍐呭瓨锛堣妭鐪亊500MB锛�

```bash
# 缂栬緫Docker閰嶇疆
nano /etc/docker/daemon.json
```

娣诲姞浠ヤ笅鍐呭闄愬埗<a href="/guide/geakos-performance-optimization/" target="_blank">Docker</a>鍐呭瓨锛�

```json
{
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 64000,
      "Soft": 64000
    }
  },
  "memory": "1g",
  "memory-swap": "1g"
}
```

### 鏂规3锛氬叧闂璆EAKLink锛堣妭鐪亊200MB锛�

濡傛灉鍙湪灞€鍩熺綉浣跨敤锛屽彲浠ュ叧闂繙绋嬭闂湇鍔★細

```bash
# 鍋滄GEAKLink鏈嶅姟
systemctl stop geaklink
systemctl disable geaklink
```

### 鏂规4锛氫娇鐢⊿wap浜ゆ崲鍒嗗尯

濡傛灉鍐呭瓨瀹炲湪涓嶅鐢紝鍚敤Swap锛�

```bash
# 鍒涘缓2GB Swap
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# 寮€鏈鸿嚜鍔ㄥ惎鐢�
echo '/swapfile none swap sw 0 0' >> /etc/fstab
```

## 纭欢寤鸿

鏍规嵁瀹炴祴锛屾帹鑽愪互涓嬮厤缃細

| 閰嶇疆 | 鎺ㄨ崘鍦烘櫙 | 鍐呭瓨寤鸿 |
|------|----------|----------|
| J绯诲垪/N绯诲垪 | 杞诲害浣跨敤 | 8GB+ |
| i3/i5绾у埆 | 姝ｅ父浣跨敤 | 16GB+ |
| 楂樼閰嶇疆 | 閲嶅害<a href="/guide/geakos-performance-optimization/" target="_blank">Docker</a> | 32GB+ |

## 涓€閿紭鍖栬剼鏈�

鎴戞暣鐞嗕簡涓€涓竴閿紭鍖栬剼鏈細

```bash
#!/bin/bash
# GEAKOS 浼樺寲鑴氭湰

echo "=== GEAKOS 鍐呭瓨浼樺寲寮€濮� ==="

# 1. 鍋滄闈炲繀瑕佹湇鍔�
echo "[1/5] 鍋滄闈炲繀瑕佹湇鍔�..."
systemctl stop geak-ai 2>/dev/null
systemctl stop geak-link 2>/dev/null

# 2. 闄愬埗Docker鍐呭瓨
echo "[2/5] 閰嶇疆Docker鍐呭瓨闄愬埗..."
mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "storage-driver": "vfs",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF

# 3. 娓呯悊鏃ュ織
echo "[3/5] 娓呯悊绯荤粺鏃ュ織..."
journalctl --vacuum-time=7d
rm -rf /var/log/*.gz

# 4. 娓呯悊涓存椂鏂囦欢
echo "[4/5] 娓呯悊涓存椂鏂囦欢..."
rm -rf /tmp/*
rm -rf /var/tmp/*

# 5. 閲嶅惎Docker
echo "[5/5] 閲嶅惎Docker鏈嶅姟..."
systemctl restart docker

echo "=== 浼樺寲瀹屾垚锛佸缓璁噸鍚郴缁� ==="
echo "浼樺寲鍚庡唴瀛樺崰鐢ㄥ簲璇ラ檷浣�30-50%"
```

## 鏁堟灉瀵规瘮

| 浼樺寲鍓� | 浼樺寲鍚� | 鑺傜渷 |
|--------|--------|------|
| 2.5GB | 1.2GB | 52% |
| 3.0GB | 1.5GB | 50% |
| 3.5GB | 1.8GB | 49% |

## 鎬荤粨

<a href="/guide/geakos-day1-intro/" target="_blank">GEAKOS</a>鍐呭瓨鍗犵敤楂樼殑闂纭疄瀛樺湪锛屼絾閫氳繃浠ヤ笂浼樺寲鍙互鏄捐憲闄嶄綆銆傚浜庝綆閰嶇疆璁惧锛堝N5105/3865U锛夛紝**寤鸿鑷冲皯8GB鍐呭瓨**锛屼紭鍖栧悗鍙祦鐣呰繍琛屻€�

濡傛灉浣犺拷姹傛洿浣庣殑璧勬簮鍗犵敤锛屽彲浠ヨ€冭檻 <a href="/guide/geakos-vs-fnos-deep-comparison/" target="_blank">椋炵墰OS</a> 浣滀负鏇夸唬鏂规銆�

---

*鏈夐棶棰樻杩庤瘎璁哄尯璁ㄨ銆傛洿澶歂AS鎶€宸ц鍏虫敞 [NAS瀛﹂櫌](/guide/)銆�*

<div class="page-nav">
  <a href="/guide/geakos-vs-fnos-deep-comparison/" rel="prev">涓婁竴椤碉細GEAKOS vs 椋炵墰OS 娣卞害妯瘎锛氳皝鎵嶆槸鍥戒骇鍏嶈垂NAS涔嬬帇锛�</a>
  <a href="/guide/minipc-geakos-3865u-review/" rel="next">涓嬩竴椤碉細杩蜂綘涓绘満瑁匞EAKOS锛欼ntel 3865U鎬ц兘瀹炴祴</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
