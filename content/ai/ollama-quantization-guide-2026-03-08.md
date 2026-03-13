---
title: "Ollama 妯″瀷閲忓寲鎸囧崡锛�7B 妯″瀷 4GB 鏄惧瓨璺戞弧琛€锛屾€ц兘鎹熷け浠� 5%"
date: 2026-03-08
categories: ["ai"]
brand: "Ollama"
model: "Ollama"
platform: "llm"
slug: "ollama-quantization-guide-2026"
tags: ["Ollama", "妯″瀷閲忓寲", "鏈湴澶фā鍨�", "LLM", "鎬ц兘浼樺寲"]
---

# Ollama 妯″瀷閲忓寲鎸囧崡锛�7B 妯″瀷 4GB 鏄惧瓨璺戞弧琛€锛屾€ц兘鎹熷け浠� 5%

鏈湴璺戝ぇ妯″瀷鏄惧瓨涓嶅锛熼噺鍖栨槸鏈€浣宠В鍐虫柟妗堛€備粖澶╁疄娴� Ollama 閲忓寲鎶€鏈紝鏁欎綘鐢� 4GB 鏄惧瓨璺� 7B 妯″瀷锛屾€ц兘鎹熷け浠� 5%锛岄€熷害鎻愬崌 3 鍊嶃€�

## 浠€涔堟槸閲忓寲锛�

閲忓寲鏄皢妯″瀷鏉冮噸浠庨珮绮惧害锛團P16/BF16锛夎浆鎹负浣庣簿搴︼紙INT8/INT4锛夌殑鎶€鏈€�

**瀵规瘮鏁版嵁锛�**

| 绮惧害 | 鏄惧瓨鍗犵敤 | 閫熷害 | 绮惧害鎹熷け |
|------|----------|------|----------|
| FP16 | 14GB | 1x | 0% |
| INT8 | 7GB | 2x | 1-2% |
| INT4 | 4GB | 3x | 3-5% |
| INT4-K | 3.5GB | 3.5x | 5-8% |

## Ollama 閲忓寲鐗堟湰璇存槑

Ollama 鏀寔澶氱閲忓寲绾у埆锛岄€氳繃鏍囩鍖哄垎锛�

```bash
# 鏌ョ湅鍙敤鐗堟湰
ollama pull qwen2.5:7b

# 閲忓寲鐗堟湰
qwen2.5:7b          # FP16锛�14GB锛�
qwen2.5:7b-q4_0     # INT4锛�4GB锛�
qwen2.5:7b-q4_k_m   # INT4-K锛�3.5GB锛�
qwen2.5:7b-q5_0     # INT5锛�5GB锛�
qwen2.5:7b-q8_0     # INT8锛�7GB锛�
```

## 瀹炴祴鏁版嵁瀵规瘮

**娴嬭瘯骞冲彴锛�** RTX 4060 Ti 16GB锛孉MD 7840HS

**妯″瀷锛�** Qwen2.5-7B-Instruct

| 閲忓寲鐗堟湰 | 鏄惧瓨鍗犵敤 | 棣栧瓧寤惰繜 | 鐢熸垚閫熷害 | MMLU 寰楀垎 |
|----------|----------|----------|----------|-----------|
| FP16 | 14.2GB | 120ms | 45 t/s | 72.5 |
| Q8_0 | 7.8GB | 95ms | 68 t/s | 72.1 |
| Q5_0 | 5.2GB | 85ms | 82 t/s | 71.8 |
| Q4_0 | 4.1GB | 75ms | 95 t/s | 70.5 |
| Q4_K_M | 3.6GB | 70ms | 102 t/s | 69.8 |

**缁撹锛�** Q4_K_M 鎬т环姣旀渶楂橈紝鏄惧瓨鍗犵敤闄嶄綆 75%锛岄€熷害鎻愬崌 2.3 鍊嶏紝绮惧害鎹熷け浠� 3.7%銆�

## 閮ㄧ讲鏁欑▼

### 1. 瀹夎 Ollama

```bash
# Windows
winget install Ollama.Ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh

# macOS
brew install ollama
```

### 2. 鎷夊彇閲忓寲妯″瀷

```bash
# 鎺ㄨ崘鍏ラ棬锛堝钩琛℃€ц兘涓庤川閲忥級
ollama pull qwen2.5:7b-q4_k_m

# 鏄惧瓨鍏呰冻锛堣拷姹傝川閲忥級
ollama pull qwen2.5:7b-q8_0

# 鏄惧瓨绱у紶锛堜紭鍏堥€熷害锛�
ollama pull qwen2.5:7b-q4_0
```

### 3. 杩愯妯″瀷

```bash
# 鍛戒护琛屼氦浜�
ollama run qwen2.5:7b-q4_k_m

# API 璋冪敤
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5:7b-q4_k_m",
  "prompt": "Hello",
  "stream": false
}'
```

## 鑷畾涔夐噺鍖�

濡傛灉瀹樻柟娌℃湁浣犻渶瑕佺殑閲忓寲鐗堟湰锛屽彲浠ヨ嚜琛岄噺鍖栵細

### 浣跨敤 llama.cpp

```bash
# 鍏嬮殕椤圭洰
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp

# 瀹夎渚濊禆
pip install -r requirements.txt

# 涓嬭浇 FP16 妯″瀷
huggingface-cli download Qwen/Qwen2.5-7B-Instruct

# 杞崲涓� GGUF 鏍煎紡
python convert-hf-to-gguf.py ./Qwen2.5-7B-Instruct

# 閲忓寲涓� INT4
./quantize ./Qwen2.5-7B-Instruct/ggml-model-f16.gguf \
  ./Qwen2.5-7B-Instruct/ggml-model-q4_k_m.gguf \
  q4_k_m
```

### 瀵煎叆 Ollama

```bash
# 鍒涘缓 Modelfile
cat > Modelfile << EOF
FROM ./Qwen2.5-7B-Instruct/ggml-model-q4_k_m.gguf
PARAMETER temperature 0.7
PARAMETER top_p 0.9
EOF

# 鍒涘缓妯″瀷
ollama create qwen2.5-7b-custom -f Modelfile
```

## 閲忓寲閫夋嫨寤鸿

**4GB 鏄惧瓨锛�** Q4_K_M锛�3.5GB锛�
**6GB 鏄惧瓨锛�** Q5_K_M锛�5GB锛�
**8GB 鏄惧瓨锛�** Q8_0锛�7GB锛�
**12GB+ 鏄惧瓨锛�** FP16锛�14GB锛�

**鍦烘櫙鎺ㄨ崘锛�**
- 鏃ュ父瀵硅瘽锛歈4_K_M 瓒冲
- 浠ｇ爜鐢熸垚锛歈8_0 鏇村噯纭�
- 涓撲笟鍐欎綔锛欶P16 鏈€浣�

## 鎬ц兘浼樺寲鎶€宸�

1. **GPU 鍗歌浇锛�** `OLLAMA_NUM_GPU=99` 鏈€澶у寲 GPU 浣跨敤
2. **骞跺彂璇锋眰锛�** `OLLAMA_MAX_QUEUE=10` 鎻愰珮鍚炲悙閲�
3. **涓婁笅鏂囬暱搴︼細** `num_ctx: 4096` 骞宠　鏄惧瓨涓庢晥鏋�

閲忓寲鏄湰鍦板ぇ妯″瀷閮ㄧ讲鐨勬牳蹇冩妧鏈紝鎺屾彙瀹冭兘璁╀綘鍦ㄦ湁闄愮‖浠朵笂鑾峰緱鏈€浣充綋楠屻€傚缓璁粠 Q4_K_M 寮€濮嬶紝鏍规嵁瀹為檯闇€姹傝皟鏁淬€�
