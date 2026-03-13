---
title: "Ollama 鏈湴閮ㄧ讲鏁欑▼锛氳糠浣犱富鏈�/NAS 璺戝ぇ妯″瀷瀹屽叏鎸囧崡"
date: 2026-03-07
categories: ["ai"]
brand: "Ollama"
model: "Ollama"
slug: "ollama-local-deploy-2026"
---

# Ollama 鏈湴閮ㄧ讲鏁欑▼锛氳糠浣犱富鏈�/NAS 璺戝ぇ妯″瀷瀹屽叏鎸囧崡

鎯冲湪鏈湴璺戝ぇ妯″瀷锛�**Ollama** 鏄渶绠€鍗曠殑閫夋嫨銆備竴琛屽懡浠ゅ畨瑁咃紝鏀寔 Llama 3銆丏eepSeek R1銆丵wen 绛変富娴佹ā鍨嬶紝瀹屽叏绂荤嚎杩愯銆�

杩欑瘒鏂囩珷璇︾粏璁茶В濡備綍鍦ㄨ糠浣犱富鏈恒€丯AS 涓婇儴缃� Ollama锛屾墦閫犱綘鐨勭浜� AI 鏈嶅姟鍣ㄣ€�


## 涓€銆佷负浠€涔堥€夋嫨 Ollama锛�

| 浼樺娍 | 璇存槑 |
| :--- | :--- |
| 馃殌 **鏋佺畝瀹夎** | 涓€琛屽懡浠ゆ悶瀹氾紝鏃犻渶閰嶇疆鐜 |
| 馃摝 **妯″瀷涓板瘜** | 鏀寔 100+ 寮€婧愬ぇ妯″瀷 |
| 馃捇 **璺ㄥ钩鍙�** | Windows/Mac/Linux/NAS 鍏ㄦ敮鎸� |
| 馃敀 **瀹屽叏绂荤嚎** | 鏁版嵁涓嶅嚭鏈湴锛岄殣绉佸畨鍏� |
| 馃啌 **瀹屽叏鍏嶈垂** | 鏃� API 璐圭敤锛屾棤浣跨敤闄愬埗 |
| 鈿� **鎬ц兘浼樺寲** | 鑷姩閲忓寲锛屾樉瀛樺崰鐢ㄦ洿浣� |


## 浜屻€佺‖浠惰姹備笌妯″瀷閫夋嫨

### 2.1 鍐呭瓨/鏄惧瓨闇€姹�

| 妯″瀷鍙傛暟閲� | 鏈€浣庡唴瀛� | 鎺ㄨ崘鍐呭瓨 | 閫傚悎璁惧 |
| :--- | :--- | :--- | :--- |
| 1.5B-3B | 4GB | 8GB | N100 杩蜂綘涓绘満 |
| 7B-8B | 8GB | 16GB | 8845HS/Ultra5 涓绘満 |
| 14B-16B | 16GB | 32GB | 32GB 鍐呭瓨涓绘満 |
| 32B-34B | 24GB | 48GB | 甯� GPU 涓绘満 |
| 70B+ | 48GB | 64GB+ | 楂樼宸ヤ綔绔� |

### 2.2 鎺ㄨ崘妯″瀷

**鏃ュ父瀵硅瘽锛�**
- Llama 3.2 3B锛堣交閲忓揩閫燂級
- Qwen2.5 7B锛堜腑鏂囦紭绉€锛�
- DeepSeek R1 7B锛堟帹鐞嗗己锛�

**涓撲笟浠诲姟锛�**
- Qwen2.5 14B锛堜唬鐮�/鍐欎綔锛�
- Llama 3.1 70B锛堟渶寮哄紑婧愶級
- Mixtral 8x7B锛圡oE 鏋舵瀯锛�

**涓枃浼樺厛锛�**
- Qwen2.5 绯诲垪锛堥樋閲屽嚭鍝侊級
- DeepSeek R1锛堝浗浜т箣鍏夛級
- Yi 绯诲垪锛堥浂涓€涓囩墿锛�


## 涓夈€佸畨瑁呮暀绋�

### 3.1 Windows 瀹夎

1. 璁块棶瀹樼綉锛歨ttps://ollama.com/download
2. 涓嬭浇 Windows 瀹夎鍖�
3. 鍙屽嚮瀹夎锛堢害 1 鍒嗛挓锛�
4. 鎵撳紑鍛戒护琛屾祴璇曪細
```bash
ollama --version
```

### 3.2 Linux/Mac 瀹夎

```bash
# 涓€閿畨瑁呰剼鏈�
curl -fsSL https://ollama.com/install.sh | sh

# 楠岃瘉瀹夎
ollama --version

# 鍚姩鏈嶅姟锛堝悗鍙拌繍琛岋級
ollama serve
```

### 3.3 缇ゆ櫀 NAS 瀹夎锛圖ocker锛�

```bash
# 鎷夊彇闀滃儚
docker pull ollama/ollama

# 鍒涘缓鏁版嵁鐩綍
mkdir -p /volume1/docker/ollama

# 杩愯瀹瑰櫒
docker run -d \
  --name ollama \
  --restart always \
  -v /volume1/docker/ollama:/root/.ollama \
  -p 11434:11434 \
  ollama/ollama
```

### 3.4 椋炵墰 OS 瀹夎

椋炵墰 OS 搴旂敤涓績鐩存帴鎼滅储"Ollama"锛屼竴閿畨瑁呭嵆鍙€�


## 鍥涖€佷笅杞戒笌浣跨敤妯″瀷

### 4.1 涓嬭浇妯″瀷

```bash
# 鏌ョ湅鍙敤妯″瀷
ollama list

# 涓嬭浇妯″瀷锛堜互 Qwen2.5 7B 涓轰緥锛�
ollama pull qwen2.5:7b

# 涓嬭浇閲忓寲鐗堟湰锛堟洿鐪佸唴瀛橈級
ollama pull qwen2.5:7b-q4_k_m

# 涓嬭浇涓枃浼樺寲鐗�
ollama pull qwen2.5:7b-instruct
```

### 4.2 寮€濮嬪璇�

```bash
# 鍛戒护琛屽璇�
ollama run qwen2.5:7b

# 杈撳叆闂锛岀洿鎺ュ緱鍒板洖绛�
> 濡備綍鐢� Python 璇诲彇 CSV 鏂囦欢锛�
```

### 4.3 甯哥敤鍛戒护

```bash
# 鏌ョ湅宸蹭笅杞芥ā鍨�
ollama list

# 鏌ョ湅妯″瀷淇℃伅
ollama show qwen2.5:7b

# 鍒犻櫎妯″瀷
ollama rm qwen2.5:7b

# 鏇存柊妯″瀷
ollama pull qwen2.5:7b

# 澶嶅埗妯″瀷
ollama cp qwen2.5:7b my-qwen
```


## 浜斻€乄eb UI 閰嶇疆锛堟帹鑽愶級

鍛戒护琛屽鐢紝浣� Web 鐣岄潰鏇村弸濂姐€�

### 5.1 Open WebUI锛堟帹鑽愶級

```bash
# Docker 瀹夎
docker run -d \
  --name open-webui \
  --network host \
  -v open-webui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

璁块棶锛歚http://浣犵殑 IP:8080`

### 5.2 鍏朵粬 Web UI

| 椤圭洰 | 鐗圭偣 | 瀹夎闅惧害 |
| :--- | :--- | :--- |
| **Open WebUI** | 鍔熻兘鏈€鍏紝绫讳技 ChatGPT | 猸愨瓙 |
| **Continue** | VSCode 鎻掍欢锛岀紪绋嬩笓鐢� | 猸� |
| **AnythingLLM** | 鏀寔鏈湴鐭ヨ瘑搴� | 猸愨瓙 |
| **Lobe Chat** | 鐣岄潰缇庤锛屾彃浠朵赴瀵� | 猸愨瓙 |


## 鍏€佹€ц兘浼樺寲

### 6.1 GPU 鍔犻€燂紙NVIDIA锛�

```bash
# 纭 GPU 璇嗗埆
nvidia-smi

# Ollama 浼氳嚜鍔ㄨ皟鐢� GPU
# 鍙€氳繃鐜鍙橀噺璋冩暣
export OLLAMA_GPU_LAYERS=33
ollama run qwen2.5:7b
```

### 6.2 閲忓寲閫夋嫨

| 閲忓寲绾у埆 | 鍐呭瓨鑺傜渷 | 璐ㄩ噺鎹熷け | 鎺ㄨ崘鍦烘櫙 |
| :--- | :--- | :--- | :--- |
| Q4_K_M | 40% | 寰堝皬 | 鏃ュ父浣跨敤 |
| Q5_K_S | 30% | 鍑犱箮鏃� | 涓撲笟浠诲姟 |
| Q6_K | 20% | 鏃� | 楂樼簿搴﹂渶姹� |
| Q8_0 | 10% | 鏃� | 鏋侀檺娴嬭瘯 |

```bash
# 涓嬭浇閲忓寲鐗堟湰
ollama pull llama3.2:3b-q4_k_m
```

### 6.3 涓婁笅鏂囬暱搴�

```bash
# 淇敼妯″瀷閰嶇疆
ollama cp qwen2.5:7b qwen2.5-8k
ollama mod qwen2.5-8k context_window 8192
```


## 涓冦€佸簲鐢ㄥ満鏅�

### 7.1 绉佷汉鍔╃悊
- 馃摑 鏂囨鍐欎綔銆侀偖浠跺洖澶�
- 馃搳 鏁版嵁鍒嗘瀽銆佹€荤粨鎽樿
- 馃寪 缈昏瘧銆佹鼎鑹�

### 7.2 寮€鍙戣緟鍔�
- 馃捇 浠ｇ爜鐢熸垚銆丏ebug
- 馃摉 鎶€鏈枃妗ｆ煡璇�
- 馃敡 鑴氭湰缂栧啓

### 7.3 鏈湴鐭ヨ瘑搴�
閰嶅悎 RAG 鎶€鏈紝鏋勫缓绉佷汉鐭ヨ瘑搴擄細
- 馃搧 浼佷笟鏂囨。
- 馃摃 涓汉绗旇
- 馃帗 瀛︿範璧勬枡

### 7.4 NAS+AI 缁勫悎
鍦� NAS 涓婇儴缃� Ollama锛屽叏瀹惰澶囬兘鑳借闂細
- 鎵嬫満 App 杩滅▼璋冪敤
- 鏅鸿兘瀹跺眳璇煶鍔╂墜
- 鑷姩鍖栦换鍔″鐞�


## 鍏€佸父瑙侀棶棰�

### Q1: 涓嬭浇閫熷害鎱紵
A锛氫娇鐢ㄥ浗鍐呴暅鍍忔垨澶滈棿涓嬭浇锛�7B 妯″瀷绾� 4GB銆�

### Q2: 鍥炵瓟閫熷害鎱紵
A锛�1. 浣跨敤閲忓寲鐗堟湰锛�2. 澧炲姞 GPU锛�3. 鍗囩骇鍐呭瓨銆�

### Q3: 濡備綍鏇存柊 Ollama锛�
A锛歐indows/Mac 閲嶆柊涓嬭浇瀹夎鍖咃紱Linux 閲嶆柊杩愯瀹夎鑴氭湰銆�

### Q4: 鍙互鍦� NAS 涓� 24 灏忔椂杩愯鍚楋紵
A锛氬彲浠ワ紝Docker 鏂瑰紡閮ㄧ讲鍚庤缃甡--restart always`銆�

### Q5: 濡備綍澶栫綉璁块棶锛�
A锛氶厤缃� Tailscale 缁勭綉鎴� Frp 鍐呯綉绌块€忋€�


## 涔濄€佹€荤粨

Ollama 璁�**鏈湴澶фā鍨嬮儴缃�**鍙樺緱鍓嶆墍鏈湁鐨勭畝鍗曘€傛棤璁烘槸杩蜂綘涓绘満杩樻槸 NAS锛岄兘鑳借交鏉捐繍琛岀浜� AI銆�

**鏍稿績浼樺娍锛�**
- 馃啌 鍏嶈垂寮€婧愶紝鏃� API 璐圭敤
- 馃敀 鏁版嵁鏈湴锛岄殣绉佸畨鍏�
- 鈿� 绂荤嚎鍙敤锛屾棤缃戠粶渚濊禆
- 馃嚚馃嚦 涓枃妯″瀷涓板瘜锛屾晥鏋滃ソ

**鍏抽敭璇嶏細** Ollama銆佹湰鍦板ぇ妯″瀷銆佽糠浣犱富鏈� AI銆丯AS 閮ㄧ讲 AI銆佺鏈� AI 鏈嶅姟鍣ㄣ€丩lama 3銆丏eepSeek R1銆佺绾� AI
