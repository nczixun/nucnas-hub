---
title: "Day 3: 椋炵墰OS瀹夎鏁欑▼ 鈥斺€� 澶氱鏂瑰紡浠讳綘閫�"
date: 2026-03-09
summary: "璇︾粏浠嬬粛椋炵墰OS鐨勫绉嶅畨瑁呮柟寮忥細U鐩樺惎鍔ㄣ€佺‖鐩樻寕杞姐€佽櫄鎷熸満銆�"
categories: ["nas"]
slug: "fnos-day3-install"
tags: ["椋炵墰OS", "瀹夎", "鏁欑▼", "U鐩樺惎鍔�"]
---

# Day 3: 椋炵墰OS瀹夎鏁欑▼


## 瀹夎鏂瑰紡涓€瑙�

| 鏂瑰紡 | 闅惧害 | 閫傜敤鍦烘櫙 |
|------|------|----------|
| U鐩樺惎鍔� | ? | 浣撻獙/娴嬭瘯 |
| 纭洏瀹夎 | ?? | 涓绘祦鐢ㄦ埛 |
| 铏氭嫙鏈� | ??? | 瀛︿範/娴嬭瘯 |

## 鏂瑰紡涓€锛歎鐩樺惎鍔ㄥ畨瑁�

### 姝ラ1锛氫笅杞介暅鍍�

璁块棶椋炵墰OS瀹樼綉涓嬭浇鏈€鏂伴暅鍍忥紙.img.gz鏍煎紡锛�

### 姝ラ2锛氬埗浣滃惎鍔ㄧ洏

```bash
# Windows (浣跨敤Rufus)
# 1. 鎻掑叆U鐩�
# 2. 鎵撳紑Rufus锛岄€夋嫨闀滃儚
# 3. 鐐瑰嚮寮€濮�

# Linux
sudo apt install gzip dd
sudo dd if=fnos.img of=/dev/sdX bs=4M status=progress
```

### 姝ラ3锛氳缃惎鍔�

1. 杩涘叆BIOS璁剧疆U鐩樺惎鍔�
2. 淇濆瓨骞堕噸鍚�
3. 鎸夌収灞忓箷鎻愮ず瀹屾垚瀹夎

## 鏂瑰紡浜岋細纭洏鐩磋

### 姝ラ1锛氬噯澶囩‖鐩�

寤鸿浣跨敤SSD浣滀负绯荤粺鐩橈紙鑷冲皯16GB锛�

### 姝ラ2锛氫娇鐢╒entoy

1. 鍒朵綔Ventoy鍚姩鐩�
2. 鏀惧叆椋炵墰OS闀滃儚
3. 浠嶸entoy鍚姩閫夋嫨闀滃儚

### 姝ラ3锛氬畨瑁呭埌纭洏

```
閫夋嫨鐩爣纾佺洏 鈫� 纭瀹夎 鈫� 绛夊緟瀹屾垚
```

## 鏂瑰紡涓夛細铏氭嫙鏈哄畨瑁�

### 浣跨敤Proxmox

```yaml
# 鍒涘缓铏氭嫙鏈�
qm create 100 \
  --name fnos \
  --cores 4 \
  --memory 8192 \
  --net0 virtio,bridge=vmbr0

# 瀵煎叆闀滃儚
qm importdisk 100 fnos.qcow2 vmbr0 --format qcow2
```

### 浣跨敤ESXi

绫讳技Proxmox姝ラ锛屽垱寤鸿櫄鎷熸満鍚庡鍏ラ暅鍍忓嵆鍙€�

---

<div class="page-nav">
  <a href="/guide/fnos-day2-hardware/" rel="prev">涓婁竴椤碉細Day 2锛氶鐗汷S纭欢閫夎喘鎸囧崡</a>
  <a href="/guide/fnos-day4-network/" rel="next">涓嬩竴椤碉細Day 4锛氶鐗汷S缃戠粶璁剧疆</a>
</div>

*鏈枃鐢� NUC NAS Hub 鑷姩鐢熸垚*
