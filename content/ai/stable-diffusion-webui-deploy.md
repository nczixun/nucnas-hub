---
title: "Stable Diffusion WebUI 閺堫剙婀撮柈銊ц閺佹瑧鈻奸敍姘帳鐠愬湱鏁撻幋锟� AI 閻㈣缍�"
date: 2026-03-08
category: "AI"
tags: ["Stable Diffusion", "閺堫剙婀撮柈銊ц", "AI 缂佹ê娴�", "Docker"]
description: "鐠囷箒袙 Stable Diffusion WebUI 閺堫剙婀撮柈銊ц閺傝纭堕敍宀勬祩閹存劖婀版潻鎰攽 AI 缂佹ê娴�"
---

# Stable Diffusion WebUI 閺堫剙婀撮柈銊ц閺佹瑧鈻奸敍姘帳鐠愬湱鏁撻幋锟� AI 閻㈣缍�

## 娑撹桨绮堟稊鍫熸拱閸︿即鍎寸純璇х吹

 Stable Diffusion閿涘牏鐣濈粔锟� SD閿涘妲稿鈧┃锟� AI 缂佹ê娴樺Ο鈥崇€烽敍灞界暚閸忋劌鍘ょ拹鐟板讲閻€劊鈧倿鍎寸純鎻掓躬閺堫剙婀撮幇蹇撴嚄閻偓閿涳拷
- 閺冪娀妾洪悽鐔稿灇閿涘奔绗夐崣锟� API 鐠愬湱鏁ら梽鎰煑
- 闂呮劗顫嗙€瑰鍙忛敍灞芥禈閻楀洣绗夋径鏍︾炊
- 閸欘垵鍤滅€规矮绠熷Ο鈥崇€烽妴浣瑰絻娴狅拷

## 绾兛娆㈢憰浣圭湴

| 闁板秶鐤� | 閺堚偓娴ｏ拷 | 閹恒劏宕� |
|------|------|------|
| 閺勬儳宕� | GTX 1060 6GB | RTX 3060 12GB+ |
| 閸愬懎鐡� | 16GB | 32GB |
| 鐎涙ê鍋� | 50GB | 100GB+ |

閺嶅憡妯夐幋鏍︾秵缁旑垱妯夐崡鈥茬瘍閼冲€熺箥鐞涘矉绱濇担鍡欐晸閹存劙鈧喎瀹虫潏鍐╁弮閵嗭拷

## 閺傝纭舵稉鈧敍姝恑ndows 娑撯偓闁款喖鐣ㄧ憗鍜冪礄閹恒劏宕橀弬鐗堝閿涳拷

### 缁楊兛绔村銉窗鐎瑰顥� Python 娑擄拷 Git

1. 娑撳娴� [Python 3.10.6](https://www.python.org/)閿涳拷**閸斺€崇箑閸曢箖鈧拷 Add to PATH**閿涳拷
2. 娑撳娴� [Git for Windows](https://git-scm.com/)

### 缁楊兛绨╁銉窗閸忓娈曟い鍦窗

```powershell
# 閸掓稑缂撳銉ょ稊閻╊喖缍�
mkdir C:\SD-WebUI
cd C:\SD-WebUI

# 閸忓娈曠€规ɑ鏌熸禒鎾崇氨
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
```

### 缁楊兛绗佸銉窗娑撳娴囧Ο鈥崇€�

1. 鐠佸潡妫� [Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0) 娑撳娴� `sd_xl_base_1.0.safetensors`
2. 閺€鎯у弳 `models\Stable-diffusion` 閻╊喖缍�

### 缁楊剙娲撳銉窗閸氼垰濮╂潻鎰攽

```powershell
cd C:\SD-WebUI
webui-user.bat
```

妫ｆ牗顐奸崥顖氬З娴兼矮绗呮潪鎴掔贩鐠ф牭绱濈痪锟� 10-15 閸掑棝鎸撻妴鍌氭儙閸斻劍鍨氶崝鐔锋倵閿涘本绁荤憴鍫濇珤鐠佸潡妫� `http://127.0.0.1:7860`閵嗭拷

## 閺傝纭舵禍宀嬬窗Docker 闁劎璁查敍鍫モ偓鍌氭値鏉╂盯妯侀悽銊﹀煕閿涳拷

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

## 閸╄櫣顢呮担璺ㄦ暏閹稿洤宕�

1. **Prompt閿涘牊顒滈崥鎴炲絹缁€楦跨槤閿涳拷**閿涙碍寮挎潻棰佺稑閹磭鏁鹃惃鍕敶鐎圭櫢绱濇俊锟� `1girl, long hair, sunset, detailed`
2. **Negative Prompt閿涘牆寮介崥鎴炲絹缁€楦跨槤閿涳拷**閿涙矮绗夐幆瀹狀洣閻ㄥ嫬鍘撶槐鐙呯礉婵★拷 `low quality, blurry, extra fingers`
3. **Sampling Steps**閿涙岸鍣伴弽閿嬵劄閺佸府绱�20-30 鐡掑啿顧�
4. **CFG Scale**閿涙碍褰佺粈楦跨槤瀵洖顕卞鍝勫閿涳拷7-12 閹恒劏宕�
5. **鐏忓搫顕�**閿涙岸绮拋锟� 512x512閿涘苯褰茬拋鍙ヨ礋 1024x1024閿涘牓娓剁憰渚€鐝〒鍛侀崹瀣剁礆

## 鐢瓕顫嗛梻顕€顣�

**Q閿涙氨鏁撻幋鎰扳偓鐔峰婢舵艾鐨敍锟�**
A閿涙瓓TX 3060 缁撅拷 3-5 缁夛拷/閸ユ拝绱漅TX 4090 缁撅拷 1-2 缁夛拷/閸ヤ勘鈧拷

**Q閿涙碍膩閸ㄥ鏂侀崫顏堝櫡閿涳拷**
A閿涙瓪models\Stable-diffusion` 閻╊喖缍嶉敍灞炬暜閹革拷 .safetensors 閸滐拷 .ckpt 閺嶇厧绱￠妴锟�

**Q閿涙碍濮� CUDA 闁挎瑨顕ら幀搴濈疄閸旂儑绱�**
A閿涙氨鈥樻穱锟� NVIDIA 妞瑰崬濮� >= 535閿涘本娲块弬锟� CUDA Toolkit閵嗭拷

---

閺堫剙婀撮柈銊ц Stable Diffusion 閺勶拷 AI 缂佹ḿ鏁鹃惃鍕儑娑撯偓濮濄儯鈧倿鍎寸純鎻掔暚閹存劕鎮楅敍灞肩稑閸欘垯浜掔亸婵婄槸 ControlNet 閹貉冩禈閵嗕俯oRA 瀵邦喛鐨熼妴涓唎mfyUI 瀹搞儰缍斿ù浣虹搼鏉╂盯妯侀悳鈺傜《閿涘瞼鏁鹃崙鍝勬櫌娑撴氨楠囨担婊冩惂閵嗭拷
