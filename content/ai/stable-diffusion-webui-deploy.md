---
title: "Stable Diffusion WebUI 闁哄牜鍓欏﹢鎾焾閵娧嗩唹闁轰焦鐟ч埢濂告晬濮橆剙甯抽悹鎰贡閺佹捇骞嬮敓锟� AI 闁汇垼顔婄紞锟�"
date: 2026-03-08
category: "AI"
tags: ["Stable Diffusion", "闁哄牜鍓欏﹢鎾焾閵娧嗩唹", "AI 缂備焦锚濞达拷", "Docker"]
description: "閻犲浄绠掕 Stable Diffusion WebUI 闁哄牜鍓欏﹢鎾焾閵娧嗩唹闁哄倽顫夌涵鍫曟晬瀹€鍕ォ闁瑰瓨鍔栧﹢鐗堟交閹邦垼鏀� AI 缂備焦锚濞达拷"
---

# Stable Diffusion WebUI 闁哄牜鍓欏﹢鎾焾閵娧嗩唹闁轰焦鐟ч埢濂告晬濮橆剙甯抽悹鎰贡閺佹捇骞嬮敓锟� AI 闁汇垼顔婄紞锟�

## 濞戞捁妗ㄧ划鍫熺▕閸喐鎷遍柛锔垮嵆閸庡绱旂拠褏鍚�

 Stable Diffusion闁挎稑鐗忛悾婵堢矓閿燂拷 SD闁挎稑顦板Σ绋款嚕閳ь剙鈹冮敓锟� AI 缂備焦锚濞存ê螣閳ュ磭鈧兘鏁嶇仦鐣屾殮闁稿繈鍔岄崢銈囨嫻閻熸澘璁查柣鈧妸閳ь剙鍊块崕瀵哥磾閹绘帗韬柡鍫墮濠€鎾箛韫囨挻鍤勯柣顐熷亾闁挎冻鎷�
- 闁哄啰濞€濡炬椽鎮介悢绋跨亣闁挎稑濂旂粭澶愬矗閿燂拷 API 閻犳劕婀遍弫銈夋⒔閹邦剙鐓�
- 闂傚懏鍔楅～鍡欌偓鐟邦槸閸欏繘鏁嶇仦鑺ョ闁绘娲ｇ粭澶嬪緞閺嶏妇鐐�
- 闁告瑯鍨甸崵婊呪偓瑙勭煯缁犵喎螣閳ュ磭鈧兘濡存担鐟扮祷濞寸媴鎷�

## 缁绢収鍏涘▎銏㈡啺娴ｅ湱婀�

| 闂佹澘绉堕悿锟� | 闁哄牃鍋撳ù锝忔嫹 | 闁规亽鍔忓畷锟� |
|------|------|------|
| 闁哄嫭鍎冲畷锟� | GTX 1060 6GB | RTX 3060 12GB+ |
| 闁告劕鎳庨悺锟� | 16GB | 32GB |
| 閻庢稒锚閸嬶拷 | 50GB | 100GB+ |

闁哄秴鎲″Ο澶愬箣閺嶏妇绉电紒鏃戝灡濡宕￠垾鑼槏闁煎啿鈧喓绠ラ悶娑樼焿缁辨繃鎷呴崱娆愭櫢闁瑰瓨鍔欓埀顒傚枎鐎硅櫕娼忛崘鈺佸籍闁靛棴鎷�

## 闁哄倽顫夌涵鑸电▔閳ь剟鏁嶅鎭憂dows 濞戞挴鍋撻梺娆惧枛閻ｃ劎鎲楅崪鍐闁规亽鍔忓畷姗€寮悧鍫濐杹闁挎冻鎷�

### 缂佹鍏涚粩鏉戭潰閵夘垳绐楅悗鐟邦槼椤ワ拷 Python 濞戞搫鎷� Git

1. 濞戞挸顑堝ù锟� [Python 3.10.6](https://www.python.org/)闁挎冻鎷�**闁告柡鈧磭绠戦柛鏇㈢畺閳ь剨鎷� Add to PATH**闁挎冻鎷�
2. 濞戞挸顑堝ù锟� [Git for Windows](https://git-scm.com/)

### 缂佹鍏涚花鈺侇潰閵夘垳绐楅柛蹇擃儔濞堟洘銇勯崷顓熺獥

```powershell
# 闁告帗绋戠紓鎾愁啅閵夈倗绋婇柣鈺婂枛缂嶏拷
mkdir C:\SD-WebUI
cd C:\SD-WebUI

# 闁稿繐顑夊▓鏇犫偓瑙勆戦弻鐔哥閹惧磭姘�
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
```

### 缂佹鍏涚粭浣割潰閵夘垳绐楀☉鎾愁儓濞村洤螣閳ュ磭鈧拷

1. 閻犱礁娼″Λ锟� [Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0) 濞戞挸顑堝ù锟� `sd_xl_base_1.0.safetensors`
2. 闁衡偓閹冨汲 `models\Stable-diffusion` 闁烩晩鍠栫紞锟�

### 缂佹鍓欏ú鎾愁潰閵夘垳绐楅柛姘煎灠婵晜娼婚幇顖ｆ斀

```powershell
cd C:\SD-WebUI
webui-user.bat
```

濡絾鐗楅濂稿触椤栨艾袟濞村吋鐭粭鍛姜閹存帞璐╅悹褎鐗槐婵堢棯閿燂拷 10-15 闁告帒妫濋幐鎾诲Υ閸屾碍鍎欓柛鏂诲妽閸ㄦ岸宕濋悢閿嬪€甸柨娑樻湰缁佽崵鎲撮崼婵囩彜閻犱礁娼″Λ锟� `http://127.0.0.1:7860`闁靛棴鎷�

## 闁哄倽顫夌涵鑸电瀹€瀣獥Docker 闂侇喓鍔庣拋鏌ユ晬閸儮鍋撻崒姘€ら弶鈺傜洴濡線鎮介妸锕€鐓曢柨娑虫嫹

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

## 闁糕晞娅ｉ、鍛媴鐠恒劍鏆忛柟绋挎搐瀹曪拷

1. **Prompt闁挎稑鐗婇婊堝触閹寸偛绲圭紒鈧ウ璺ㄦГ闁挎冻鎷�**闁挎稒纰嶅鎸庢交妫颁胶绋戦柟顖氱－閺侀箖鎯冮崟顐㈡暥閻庡湱娅㈢槐婵囦繆閿燂拷 `1girl, long hair, sunset, detailed`
2. **Negative Prompt闁挎稑鐗嗗浠嬪触閹寸偛绲圭紒鈧ウ璺ㄦГ闁挎冻鎷�**闁挎稒鐭粭澶愬箚鐎圭媭娲ｉ柣銊ュ閸樻挾妲愰悪鍛濠碘槄鎷� `low quality, blurry, extra fingers`
3. **Sampling Steps**闁挎稒宀搁崳浼村冀闁垮鍔勯柡浣稿簻缁憋拷20-30 閻℃帒鍟块¨锟�
4. **CFG Scale**闁挎稒纰嶈ぐ浣虹矆妤﹁法妲ょ€殿喗娲栭鍗烆嚕閸濆嫬顔婇柨娑虫嫹7-12 闁规亽鍔忓畷锟�
5. **閻忓繐鎼锟�**闁挎稒宀哥划顖滄媼閿燂拷 512x512闁挎稑鑻ぐ鑼媼閸欍儴绀� 1024x1024闁挎稑鐗撳〒鍓佹啺娓氣偓閻濐喖銆掗崨顔涗線宕圭€ｅ墎绀�

## 閻㈩垱鐡曢～鍡涙⒒椤曗偓椤ｏ拷

**Q闁挎稒姘ㄩ弫鎾诲箣閹版壋鍋撻悢宄邦唺濠㈣埖鑹鹃惃顖炴晬閿燂拷**
A闁挎稒鐡揟X 3060 缂佹拝鎷� 3-5 缂佸鎷�/闁搞儲鎷濈槐婕匱X 4090 缂佹拝鎷� 1-2 缂佸鎷�/闁搞儰鍕橀埀顒婃嫹

**Q闁挎稒纰嶈啯闁搞劌顑嗛弬渚€宕鍫濇闁挎冻鎷�**
A闁挎稒鐡猰odels\Stable-diffusion` 闁烩晩鍠栫紞宥夋晬鐏炵偓鏆滈柟闈╂嫹 .safetensors 闁告粣鎷� .ckpt 闁哄秶鍘х槐锟犲Υ閿燂拷

**Q闁挎稒纰嶆慨锟� CUDA 闂佹寧鐟ㄩ銈夊箑鎼存繄鐤勯柛鏃傚剳缁憋拷**
A闁挎稒姘ㄩ垾妯荤┍閿燂拷 NVIDIA 濡炵懓宕慨锟� >= 535闁挎稑鏈ú鍧楀棘閿燂拷 CUDA Toolkit闁靛棴鎷�

---

闁哄牜鍓欏﹢鎾焾閵娧嗩唹 Stable Diffusion 闁哄嫸鎷� AI 缂備焦岣块弫楣冩儍閸曨収鍎戝☉鎾亾婵縿鍎埀顒€鍊块崕瀵哥磾閹绘帞鏆氶柟瀛樺姇閹鏁嶇仦鑲╃☉闁告瑯鍨禍鎺斾焊濠靛﹦妲� ControlNet 闁硅矇鍐╃闁靛棔淇痮RA 鐎甸偊鍠涢惃鐔煎Υ娑撳攷mfyUI 鐎规悶鍎扮紞鏂棵规担铏规惣閺夆晜鐩Ο渚€鎮抽埡鍌溿€婇柨娑樼灱閺侀箖宕欓崫鍕珜濞戞挻姘ㄦ鍥ㄦ媴濠婂啯鎯傞柕鍡嫹
