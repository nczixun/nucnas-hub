---
title: "Stable Diffusion WebUI 鏈湴閮ㄧ讲鏁欑▼锛氭樉鍗￠厤缃寚鍗�"
date: 2026-03-08T15:03:00+08:00
category: ["AI"]
tags: ["Stable Diffusion", "WebUI", "鏈湴閮ㄧ讲", "AI 缁樼敾", "鏄惧崱", "鏁欑▼"]
draft: false
---

鎯崇敤 Stable Diffusion 鐢熸垚鍥剧墖锛屼絾涓嶆兂鐢ㄥ湪绾挎湇鍔★紵杩欑瘒鏁欎綘鏈湴閮ㄧ讲 WebUI锛岀敾鍥炬洿鑷敱銆�

## 纭欢瑕佹眰

鏈€浣庨厤缃細
- 鏄惧瓨 6GB锛堝媺寮鸿兘璺戯級
- 鍐呭瓨 16GB
- 纭洏 50GB+锛堟ā鍨嬪緢澶э級

鎺ㄨ崘閰嶇疆锛�
- 鏄惧瓨 8GB+
- 鍐呭瓨 32GB
- SSD 瀛樺偍

## 鐜鍑嗗

### 1. 瀹夎 Python

寤鸿浣跨敤 Anaconda 鎴栫洿鎺ュ畨瑁� Python 3.10+锛�

```bash
# 妫€鏌� Python 鐗堟湰
python --version
```

### 2. 瀹夎 Git

```bash
# Windows 涓嬪畨瑁� Git
winget install Git.Git
```

### 3. 鍏嬮殕椤圭洰

```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

## 鏄惧崱椹卞姩閰嶇疆

### NVIDIA 鏄惧崱

纭繚瀹夎浜嗘渶鏂伴┍鍔紝鐒跺悗瀹夎 CUDA锛�

```bash
# 妫€鏌ラ┍鍔�
nvidia-smi

# 瀹夎 CUDA Toolkit锛堝鏋滄病瑁咃級
winget install NVIDIA.CUDA Toolkit
```

### AMD 鏄惧崱锛圠inux锛�

闇€瑕佸畨瑁� ROCm锛�

```bash
# 娣诲姞 ROCm 浠撳簱
sudo apt update
sudo apt install rocm-libs
```

## 鍚姩 WebUI

### Windows

鐩存帴杩愯锛�

```bash
./webui-user.bat
```

棣栨鍚姩浼氫笅杞藉熀纭€妯″瀷锛岄渶瑕佷竴浜涙椂闂淬€�

### 鑷畾涔夊弬鏁�

淇敼 `webui-user.bat`锛�

```bat
set COMMANDLINE_ARGS=--xformers --medvram --opt-split-attention
```

鍙傛暟璇存槑锛�
- `--xformers`锛氫娇鐢� xformers 浼樺寲锛屾樉瀛樻洿鐪�
- `--medvram`锛氫腑绛夋樉瀛樹紭鍖�
- `--opt-split-attention`锛氫紭鍖栨敞鎰忓姏鏈哄埗

## 鏄惧瓨浼樺寲鎶€宸�

### 1. 鍚敤 xformers

```bash
pip install xformers
```

### 2. 闄嶄綆鐢熸垚鍒嗚鲸鐜�

棣栨鐢熸垚寤鸿鐢� 512x512锛岀啛鎮夊悗鍐嶈皟楂樸€�

### 3. 浣跨敤妯″瀷閲忓寲

閫夋嫨閲忓寲鍚庣殑妯″瀷锛堝 SD 1.5 4bit 閲忓寲鐗堬級銆�

## 甯歌闂

**Q: 鏄惧瓨涓嶅鎬庝箞鍔烇紵**
A: 浣跨敤 --lowvram 妯″紡锛屾垨鑰呭崌绾ф樉鍗°€�

**Q: 鐢熸垚寰堟參鎬庝箞鍔烇紵**
A: 纭鏄惧崱椹卞姩鍜� CUDA 姝ｇ‘瀹夎锛屽惎鐢� xformers銆�

**Q: 妯″瀷涓嬭浇鍒板摢閲岋紵**
A: `models/Stable-diffusion/` 鐩綍銆�

## 鎺ㄨ崘妯″瀷

鍏ラ棬鎺ㄨ崘锛�
- Stable Diffusion 1.5锛堟渶鎴愮啛锛岀敓鎬佹渶濂斤級
- DreamShaper锛堜汉鐗╂晥鏋滃ソ锛�
- Realistic Vision锛堝啓瀹為鏍硷級

## 鎴戠殑閰嶇疆鍒嗕韩

杩欐槸鎴戠殑鍚姩鍙傛暟锛�

```bat
set COMMANDLINE_ARGS=--xformers --medvram --api --listen
```

閰嶅悎 RTX 3060 12GB锛屽熀鏈兘璺� 1024x1024 鍒嗚鲸鐜囥€�

---
*娴嬭瘯鏄惧崱锛歊TX 3060 12GB锛岄┍鍔� 535.154锛孭ython 3.10.11*
