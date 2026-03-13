---
title: "Stable Diffusion WebUI 鏈湴閮ㄧ讲鏁欑▼锛氬厤璐圭敓鎴� AI 鐢讳綔"
date: 2026-03-08
category: "AI"
tags: ["Stable Diffusion", "鏈湴閮ㄧ讲", "AI 缁樺浘", "Docker"]
description: "璇﹁В Stable Diffusion WebUI 鏈湴閮ㄧ讲鏂规硶锛岄浂鎴愭湰杩愯 AI 缁樺浘"
---

# Stable Diffusion WebUI 鏈湴閮ㄧ讲鏁欑▼锛氬厤璐圭敓鎴� AI 鐢讳綔

## 涓轰粈涔堟湰鍦伴儴缃诧紵

 Stable Diffusion锛堢畝绉� SD锛夋槸寮€婧� AI 缁樺浘妯″瀷锛屽畬鍏ㄥ厤璐瑰彲鐢ㄣ€傞儴缃插湪鏈湴鎰忓懗鐫€锛�
- 鏃犻檺鐢熸垚锛屼笉鍙� API 璐圭敤闄愬埗
- 闅愮瀹夊叏锛屽浘鐗囦笉澶栦紶
- 鍙嚜瀹氫箟妯″瀷銆佹彃浠�

## 纭欢瑕佹眰

| 閰嶇疆 | 鏈€浣� | 鎺ㄨ崘 |
|------|------|------|
| 鏄惧崱 | GTX 1060 6GB | RTX 3060 12GB+ |
| 鍐呭瓨 | 16GB | 32GB |
| 瀛樺偍 | 50GB | 100GB+ |

鏍告樉鎴栦綆绔樉鍗′篃鑳借繍琛岋紝浣嗙敓鎴愰€熷害杈冩參銆�

## 鏂规硶涓€锛歐indows 涓€閿畨瑁咃紙鎺ㄨ崘鏂版墜锛�

### 绗竴姝ワ細瀹夎 Python 涓� Git

1. 涓嬭浇 [Python 3.10.6](https://www.python.org/)锛�**鍔″繀鍕鹃€� Add to PATH**锛�
2. 涓嬭浇 [Git for Windows](https://git-scm.com/)

### 绗簩姝ワ細鍏嬮殕椤圭洰

```powershell
# 鍒涘缓宸ヤ綔鐩綍
mkdir C:\SD-WebUI
cd C:\SD-WebUI

# 鍏嬮殕瀹樻柟浠撳簱
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
```

### 绗笁姝ワ細涓嬭浇妯″瀷

1. 璁块棶 [Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0) 涓嬭浇 `sd_xl_base_1.0.safetensors`
2. 鏀惧叆 `models\Stable-diffusion` 鐩綍

### 绗洓姝ワ細鍚姩杩愯

```powershell
cd C:\SD-WebUI
webui-user.bat
```

棣栨鍚姩浼氫笅杞戒緷璧栵紝绾� 10-15 鍒嗛挓銆傚惎鍔ㄦ垚鍔熷悗锛屾祻瑙堝櫒璁块棶 `http://127.0.0.1:7860`銆�

## 鏂规硶浜岋細Docker 閮ㄧ讲锛堥€傚悎杩涢樁鐢ㄦ埛锛�

```yaml
# docker-compose.yml
version: '3.8'
services:
  sd-webui:
    image: ghcr.io/akebus/stable-diffusion-webui:latest
    container_name: sd-webui
    ports:
      - "7860:7860"
    volumes:
      - ./models:/app/stable-diffusion-webui/models
      - ./outputs:/app/stable-diffusion-webui/outputs
    environment:
      - CLI_ARGS=--xformers --precision full --no-half
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

```bash
docker-compose up -d
```

## 鍩虹浣跨敤鎸囧崡

1. **Prompt锛堟鍚戞彁绀鸿瘝锛�**锛氭弿杩颁綘鎯崇敾鐨勫唴瀹癸紝濡� `1girl, long hair, sunset, detailed`
2. **Negative Prompt锛堝弽鍚戞彁绀鸿瘝锛�**锛氫笉鎯宠鐨勫厓绱狅紝濡� `low quality, blurry, extra fingers`
3. **Sampling Steps**锛氶噰鏍锋鏁帮紝20-30 瓒冲
4. **CFG Scale**锛氭彁绀鸿瘝寮曞寮哄害锛�7-12 鎺ㄨ崘
5. **灏哄**锛氶粯璁� 512x512锛屽彲璁句负 1024x1024锛堥渶瑕侀珮娓呮ā鍨嬶級

## 甯歌闂

**Q锛氱敓鎴愰€熷害澶氬皯锛�**
A锛歊TX 3060 绾� 3-5 绉�/鍥撅紝RTX 4090 绾� 1-2 绉�/鍥俱€�

**Q锛氭ā鍨嬫斁鍝噷锛�**
A锛歚models\Stable-diffusion` 鐩綍锛屾敮鎸� .safetensors 鍜� .ckpt 鏍煎紡銆�

**Q锛氭姤 CUDA 閿欒鎬庝箞鍔烇紵**
A锛氱‘淇� NVIDIA 椹卞姩 >= 535锛屾洿鏂� CUDA Toolkit銆�

---

鏈湴閮ㄧ讲 Stable Diffusion 鏄� AI 缁樼敾鐨勭涓€姝ャ€傞儴缃插畬鎴愬悗锛屼綘鍙互灏濊瘯 ControlNet 鎺у浘銆丩oRA 寰皟銆丆omfyUI 宸ヤ綔娴佺瓑杩涢樁鐜╂硶锛岀敾鍑哄晢涓氱骇浣滃搧銆�
