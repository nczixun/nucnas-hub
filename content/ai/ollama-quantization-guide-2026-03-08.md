---
title: "Ollama 濡€崇€烽柌蹇撳閹稿洤宕￠敍锟�7B 濡€崇€� 4GB 閺勬儳鐡ㄧ捄鎴炲姬鐞涒偓閿涘本鈧嗗厴閹圭喎銇戞禒锟� 5%"
date: 2026-03-08
categories: ["ai"]
brand: "Ollama"
model: "Ollama"
platform: "llm"
slug: "ollama-quantization-guide-2026"
tags: ["Ollama", "濡€崇€烽柌蹇撳", "閺堫剙婀存径褎膩閸拷", "LLM", "閹嗗厴娴兼ê瀵�"]
---

# Ollama 濡€崇€烽柌蹇撳閹稿洤宕￠敍锟�7B 濡€崇€� 4GB 閺勬儳鐡ㄧ捄鎴炲姬鐞涒偓閿涘本鈧嗗厴閹圭喎銇戞禒锟� 5%

閺堫剙婀寸捄鎴濄亣濡€崇€烽弰鎯х摠娑撳秴顧勯敍鐔煎櫤閸栨牗妲搁張鈧担瀹犘掗崘铏煙濡楀牄鈧倷绮栨径鈺佺杽濞达拷 Ollama 闁插繐瀵查幎鈧張顖ょ礉閺佹瑤缍橀悽锟� 4GB 閺勬儳鐡ㄧ捄锟� 7B 濡€崇€烽敍灞锯偓褑鍏橀幑鐔枫亼娴狅拷 5%閿涘矂鈧喎瀹抽幓鎰磳 3 閸婂秲鈧拷

## 娴犫偓娑斿牊妲搁柌蹇撳閿涳拷

闁插繐瀵查弰顖氱殺濡€崇€烽弶鍐櫢娴犲酣鐝划鎯у閿涘湗P16/BF16閿涘娴嗛幑顫礋娴ｅ海绨挎惔锔肩礄INT8/INT4閿涘娈戦幎鈧張顖樷偓锟�

**鐎佃鐦弫鐗堝祦閿涳拷**

| 缁儳瀹� | 閺勬儳鐡ㄩ崡鐘垫暏 | 闁喎瀹� | 缁儳瀹抽幑鐔枫亼 |
|------|----------|------|----------|
| FP16 | 14GB | 1x | 0% |
| INT8 | 7GB | 2x | 1-2% |
| INT4 | 4GB | 3x | 3-5% |
| INT4-K | 3.5GB | 3.5x | 5-8% |

## Ollama 闁插繐瀵查悧鍫熸拱鐠囧瓨妲�

Ollama 閺€顖涘瘮婢舵氨顫掗柌蹇撳缁狙冨焼閿涘矂鈧俺绻冮弽鍥╊劮閸栧搫鍨庨敍锟�

```bash
# 閺屻儳婀呴崣顖滄暏閻楀牊婀�
ollama pull qwen2.5:7b

# 闁插繐瀵查悧鍫熸拱
qwen2.5:7b          # FP16閿涳拷14GB閿涳拷
qwen2.5:7b-q4_0     # INT4閿涳拷4GB閿涳拷
qwen2.5:7b-q4_k_m   # INT4-K閿涳拷3.5GB閿涳拷
qwen2.5:7b-q5_0     # INT5閿涳拷5GB閿涳拷
qwen2.5:7b-q8_0     # INT8閿涳拷7GB閿涳拷
```

## 鐎圭偞绁撮弫鐗堝祦鐎佃鐦�

**濞村鐦獮鍐插酱閿涳拷** RTX 4060 Ti 16GB閿涘瓑MD 7840HS

**濡€崇€烽敍锟�** Qwen2.5-7B-Instruct

| 闁插繐瀵查悧鍫熸拱 | 閺勬儳鐡ㄩ崡鐘垫暏 | 妫ｆ牕鐡у鎯扮箿 | 閻㈢喐鍨氶柅鐔峰 | MMLU 瀵版鍨� |
|----------|----------|----------|----------|-----------|
| FP16 | 14.2GB | 120ms | 45 t/s | 72.5 |
| Q8_0 | 7.8GB | 95ms | 68 t/s | 72.1 |
| Q5_0 | 5.2GB | 85ms | 82 t/s | 71.8 |
| Q4_0 | 4.1GB | 75ms | 95 t/s | 70.5 |
| Q4_K_M | 3.6GB | 70ms | 102 t/s | 69.8 |

**缂佹捁顔戦敍锟�** Q4_K_M 閹傜幆濮ｆ梹娓舵姗堢礉閺勬儳鐡ㄩ崡鐘垫暏闂勫秳缍� 75%閿涘矂鈧喎瀹抽幓鎰磳 2.3 閸婂稄绱濈划鎯у閹圭喎銇戞禒锟� 3.7%閵嗭拷

## 闁劎璁查弫娆戔柤

### 1. 鐎瑰顥� Ollama

```bash
# Windows
winget install Ollama.Ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh

# macOS
brew install ollama
```

### 2. 閹峰褰囬柌蹇撳濡€崇€�

```bash
# 閹恒劏宕橀崗銉╂，閿涘牆閽╃悰鈩冣偓褑鍏樻稉搴ゅ窛闁插骏绱�
ollama pull qwen2.5:7b-q4_k_m

# 閺勬儳鐡ㄩ崗鍛板喕閿涘牐鎷峰Ч鍌濆窛闁插骏绱�
ollama pull qwen2.5:7b-q8_0

# 閺勬儳鐡ㄧ槐褍绱堕敍鍫滅喘閸忓牓鈧喎瀹抽敍锟�
ollama pull qwen2.5:7b-q4_0
```

### 3. 鏉╂劘顢戝Ο鈥崇€�

```bash
# 閸涙垝鎶ょ悰灞兼唉娴滐拷
ollama run qwen2.5:7b-q4_k_m

# API 鐠嬪啰鏁�
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5:7b-q4_k_m",
  "prompt": "Hello",
  "stream": false
}'
```

## 閼奉亜鐣炬稊澶愬櫤閸栵拷

婵″倹鐏夌€规ɑ鏌熷▽鈩冩箒娴ｇ娀娓剁憰浣烘畱闁插繐瀵查悧鍫熸拱閿涘苯褰叉禒銉ㄥ殰鐞涘矂鍣洪崠鏍电窗

### 娴ｈ法鏁� llama.cpp

```bash
# 閸忓娈曟い鍦窗
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp

# 鐎瑰顥婃笟婵婄
pip install -r requirements.txt

# 娑撳娴� FP16 濡€崇€�
huggingface-cli download Qwen/Qwen2.5-7B-Instruct

# 鏉烆剚宕叉稉锟� GGUF 閺嶇厧绱�
python convert-hf-to-gguf.py ./Qwen2.5-7B-Instruct

# 闁插繐瀵叉稉锟� INT4
./quantize ./Qwen2.5-7B-Instruct/ggml-model-f16.gguf \
  ./Qwen2.5-7B-Instruct/ggml-model-q4_k_m.gguf \
  q4_k_m
```

### 鐎电厧鍙� Ollama

```bash
# 閸掓稑缂� Modelfile
cat > Modelfile << EOF
FROM ./Qwen2.5-7B-Instruct/ggml-model-q4_k_m.gguf
PARAMETER temperature 0.7
PARAMETER top_p 0.9
EOF

# 閸掓稑缂撳Ο鈥崇€�
ollama create qwen2.5-7b-custom -f Modelfile
```

## 闁插繐瀵查柅澶嬪瀵ら缚顔�

**4GB 閺勬儳鐡ㄩ敍锟�** Q4_K_M閿涳拷3.5GB閿涳拷
**6GB 閺勬儳鐡ㄩ敍锟�** Q5_K_M閿涳拷5GB閿涳拷
**8GB 閺勬儳鐡ㄩ敍锟�** Q8_0閿涳拷7GB閿涳拷
**12GB+ 閺勬儳鐡ㄩ敍锟�** FP16閿涳拷14GB閿涳拷

**閸︾儤娅欓幒銊ㄥ礃閿涳拷**
- 閺冦儱鐖剁€电鐦介敍姝�4_K_M 鐡掑啿顧�
- 娴狅絿鐖滈悽鐔稿灇閿涙瓐8_0 閺囨潙鍣涵锟�
- 娑撴挷绗熼崘娆庣稊閿涙P16 閺堚偓娴ｏ拷

## 閹嗗厴娴兼ê瀵查幎鈧锟�

1. **GPU 閸楁瓕娴囬敍锟�** `OLLAMA_NUM_GPU=99` 閺堚偓婢堆冨 GPU 娴ｈ法鏁�
2. **楠炶泛褰傜拠閿嬬湴閿涳拷** `OLLAMA_MAX_QUEUE=10` 閹绘劙鐝崥鐐叉倷闁诧拷
3. **娑撳﹣绗呴弬鍥毐鎼达讣绱�** `num_ctx: 4096` 楠炲疇銆€閺勬儳鐡ㄦ稉搴㈡櫏閺嬶拷

闁插繐瀵查弰顖涙拱閸︽澘銇囧Ο鈥崇€烽柈銊ц閻ㄥ嫭鐗宠箛鍐╁Η閺堫垽绱濋幒灞惧綑鐎瑰啳鍏樼拋鈺€缍橀崷銊︽箒闂勬劗鈥栨禒鏈电瑐閼惧嘲绶遍張鈧担鍏呯秼妤犲被鈧倸缂撶拋顔荤矤 Q4_K_M 瀵偓婵绱濋弽瑙勫祦鐎圭偤妾棁鈧Ч鍌濈殶閺佹番鈧拷
