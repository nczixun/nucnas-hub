---
title: "Stable Diffusion WebUI 閺堫剙婀撮柈銊ц閺佹瑧鈻奸敍姘▔閸楋繝鍘ょ純顔藉瘹閸楋拷"
date: 2026-03-08T15:03:00+08:00
category: ["AI"]
tags: ["Stable Diffusion", "WebUI", "閺堫剙婀撮柈銊ц", "AI 缂佹ḿ鏁�", "閺勬儳宕�", "閺佹瑧鈻�"]
draft: false
---

閹磭鏁� Stable Diffusion 閻㈢喐鍨氶崶鍓у閿涘奔绲炬稉宥嗗厒閻€劌婀痪鎸庢箛閸斺槄绱垫潻娆戠槖閺佹瑤缍橀張顒€婀撮柈銊ц WebUI閿涘瞼鏁鹃崶鐐纯閼奉亞鏁遍妴锟�

## 绾兛娆㈢憰浣圭湴

閺堚偓娴ｅ酣鍘ょ純顕嗙窗
- 閺勬儳鐡� 6GB閿涘牆濯哄楦垮厴鐠烘埊绱�
- 閸愬懎鐡� 16GB
- 绾剛娲� 50GB+閿涘牊膩閸ㄥ绶㈡径褝绱�

閹恒劏宕橀柊宥囩枂閿涳拷
- 閺勬儳鐡� 8GB+
- 閸愬懎鐡� 32GB
- SSD 鐎涙ê鍋�

## 閻滎垰顣ㄩ崙鍡楊槵

### 1. 鐎瑰顥� Python

瀵ら缚顔呮担璺ㄦ暏 Anaconda 閹存牜娲块幒銉ョ暔鐟侊拷 Python 3.10+閿涳拷

```bash
# 濡偓閺岋拷 Python 閻楀牊婀�
python --version
```

### 2. 鐎瑰顥� Git

```bash
# Windows 娑撳鐣ㄧ憗锟� Git
winget install Git.Git
```

### 3. 閸忓娈曟い鍦窗

```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
```

## 閺勬儳宕辨す鍗炲З闁板秶鐤�

### NVIDIA 閺勬儳宕�

绾喕绻氱€瑰顥婃禍鍡樻付閺備即鈹嶉崝顭掔礉閻掕泛鎮楃€瑰顥� CUDA閿涳拷

```bash
# 濡偓閺屻儵鈹嶉崝锟�
nvidia-smi

# 鐎瑰顥� CUDA Toolkit閿涘牆顩ч弸婊勭梾鐟佸拑绱�
winget install NVIDIA.CUDA Toolkit
```

### AMD 閺勬儳宕遍敍鍦爄nux閿涳拷

闂団偓鐟曚礁鐣ㄧ憗锟� ROCm閿涳拷

```bash
# 濞ｈ濮� ROCm 娴犳挸绨�
sudo apt update
sudo apt install rocm-libs
```

## 閸氼垰濮� WebUI

### Windows

閻╁瓨甯存潻鎰攽閿涳拷

```bash
./webui-user.bat
```

妫ｆ牗顐奸崥顖氬З娴兼矮绗呮潪钘夌唨绾偓濡€崇€烽敍宀勬付鐟曚椒绔存禍娑欐闂傛番鈧拷

### 閼奉亜鐣炬稊澶婂棘閺侊拷

娣囶喗鏁� `webui-user.bat`閿涳拷

```bat
set COMMANDLINE_ARGS=--xformers --medvram --opt-split-attention
```

閸欏倹鏆熺拠瀛樻閿涳拷
- `--xformers`閿涙矮濞囬悽锟� xformers 娴兼ê瀵查敍灞炬▔鐎涙ɑ娲块惇锟�
- `--medvram`閿涙矮鑵戠粵澶嬫▔鐎涙ü绱崠锟�
- `--opt-split-attention`閿涙矮绱崠鏍ㄦ暈閹板繐濮忛張鍝勫煑

## 閺勬儳鐡ㄦ导妯哄閹垛偓瀹革拷

### 1. 閸氼垳鏁� xformers

```bash
pip install xformers
```

### 2. 闂勫秳缍嗛悽鐔稿灇閸掑棜椴搁悳锟�

妫ｆ牗顐奸悽鐔稿灇瀵ら缚顔呴悽锟� 512x512閿涘瞼鍟涢幃澶婃倵閸愬秷鐨熸妯糕偓锟�

### 3. 娴ｈ法鏁ゅΟ鈥崇€烽柌蹇撳

闁瀚ㄩ柌蹇撳閸氬海娈戝Ο鈥崇€烽敍鍫濐洤 SD 1.5 4bit 闁插繐瀵查悧鍫礆閵嗭拷

## 鐢瓕顫嗛梻顕€顣�

**Q: 閺勬儳鐡ㄦ稉宥咁檮閹簼绠為崝鐑囩吹**
A: 娴ｈ法鏁� --lowvram 濡€崇础閿涘本鍨ㄩ懓鍛磳缁狙勬▔閸椔扳偓锟�

**Q: 閻㈢喐鍨氬鍫熷弮閹簼绠為崝鐑囩吹**
A: 绾喛顓婚弰鎯у幢妞瑰崬濮╅崪锟� CUDA 濮濓絿鈥樼€瑰顥婇敍灞芥儙閻拷 xformers閵嗭拷

**Q: 濡€崇€锋稉瀣祰閸掓澘鎽㈤柌宀嬬吹**
A: `models/Stable-diffusion/` 閻╊喖缍嶉妴锟�

## 閹恒劏宕樺Ο鈥崇€�

閸忋儵妫幒銊ㄥ礃閿涳拷
- Stable Diffusion 1.5閿涘牊娓堕幋鎰暃閿涘瞼鏁撻幀浣规付婵傛枻绱�
- DreamShaper閿涘牅姹夐悧鈺傛櫏閺嬫粌銈介敍锟�
- Realistic Vision閿涘牆鍟撶€圭偤顥撻弽纭风礆

## 閹存垹娈戦柊宥囩枂閸掑棔闊�

鏉╂瑦妲搁幋鎴犳畱閸氼垰濮╅崣鍌涙殶閿涳拷

```bat
set COMMANDLINE_ARGS=--xformers --medvram --api --listen
```

闁板秴鎮� RTX 3060 12GB閿涘苯鐔€閺堫剝鍏樼捄锟� 1024x1024 閸掑棜椴搁悳鍥モ偓锟�

---
*濞村鐦弰鎯у幢閿涙瓓TX 3060 12GB閿涘矂鈹嶉崝锟� 535.154閿涘ython 3.10.11*
