---
title: "Ollama 鏈湴閮ㄧ讲瀹屽叏鎸囧崡锛�2026鏈€鏂扮増"
date: 2026-01-01
categories: ["ai"]
summary: "Ollama 鏈湴閮ㄧ讲鏁欑▼锛屾敮鎸� Llama銆丵wen銆丏eepSeek 绛変富娴佸ぇ妯″瀷"
tags: ["Ollama", "鏈湴閮ㄧ讲", "LLM", "AI", "鏁欑▼"]
slug: "ollama-local-deploy-2026"
---

# Ollama 鏈湴閮ㄧ讲瀹屽叏鎸囧崡锛�2026鏈€鏂扮増

## 浠€涔堟槸 Ollama锛�

Ollama 鏄竴涓浣犲湪鏈湴杩愯澶ц瑷€妯″瀷鐨勫伐鍏凤紝鏀寔 Llama銆丵wen銆丏eepSeek 绛変富娴佸紑婧愭ā鍨嬨€�

## 鏀寔鐨勬ā鍨�

| 妯″瀷 | 鏄惧瓨瑕佹眰 | 鎺ㄨ崘鍦烘櫙 |
|------|----------|----------|
| Llama 3.1 8B | 8GB | 鏃ュ父瀵硅瘽 |
| Qwen2.5 14B | 16GB | 涓撲笟浠诲姟 |
| DeepSeek R1 8B | 8GB | 鎺ㄧ悊浠诲姟 |
| DeepSeek R1 70B | 80GB | 澶嶆潅鎺ㄧ悊 |

## 瀹夎姝ラ

### Windows 瀹夎

```powershell
# 浣跨敤 winget 瀹夎
winget install Ollama.Ollama

# 鎴栦笅杞藉畨瑁呭寘
# https://ollama.com/download/windows
```

### macOS 瀹夎

```bash
brew install ollama
```

### Linux 瀹夎

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

## 甯哥敤鍛戒护

### 鏌ョ湅鍙敤妯″瀷

```bash
ollama list
```

### 鎷夊彇妯″瀷

```bash
# 鎷夊彇 Llama 3
ollama pull llama3

# 鎷夊彇 Qwen 2.5
ollama pull qwen2.5

# 鎷夊彇 DeepSeek R1
ollama pull deepseek-r1:8b
```

### 杩愯妯″瀷

```bash
# 浜や簰寮忓璇�
ollama run llama3

# 鎸囧畾鍙傛暟
ollama run qwen2.5 --temperature 0.7 --top-p 0.9
```

### 鑷畾涔夋ā鍨�

```bash
# 鍒涘缓 Modelfile
FROM llama3
PARAMETER temperature 0.8
SYSTEM "浣犳槸涓€涓笓涓氱殑鎶€鏈【闂�"

# 瀵煎叆鑷畾涔夋ā鍨�
ollama create my-model -f Modelfile
```

## API 璋冪敤

### 鍩虹 API

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "浣犲ソ",
  "stream": false
}'
```

### Python 璋冪敤

```python
import ollama

response = ollama.generate(
    model='llama3',
    prompt='浠€涔堟槸NAS锛�'
)
print(response['response'])
```

## 鎬ц兘浼樺寲

### 閲忓寲鐗堟湰

| 閲忓寲绾у埆 | 鏄惧瓨鍗犵敤 | 璐ㄩ噺鎹熷け |
|----------|----------|----------|
| FP16 | 100% | 鏃� |
| Q8_0 | 50% | 鏋佸皬 |
| Q4_K_M | 25% | 杈冨皬 |
| Q2_K | 15% | 鏄庢樉 |

### GPU 鍔犻€�

纭繚 NVIDIA 椹卞姩宸插畨瑁咃細

```bash
nvidia-smi
```

## 甯歌闂

### Q: 鏄惧瓨涓嶅鎬庝箞鍔烇紵

A: 閫夋嫨閲忓寲鐗堟湰锛屽 `qwen2.5:7b-q4_k_m`

### Q: 妯″瀷涓嬭浇鎱紵

A: 浣跨敤闀滃儚婧愭垨鍏堜笅杞藉埌鏈湴鍐嶅鍏�

### Q: 濡備綍鑷畾涔夌鍙ｏ紵

```bash
OLLAMA_HOST=0.0.0.0:8080 ollama serve
```

## 鎼厤浣跨敤

### + OpenWebUI

```bash
docker run -d -p 8080:8080 \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

### + LangChain

```python
from langchain_community.llms import Ollama

llm = Ollama(model="llama3")
```

## 鎬荤粨

Ollama 璁╂湰鍦拌繍琛屽ぇ妯″瀷鍙樺緱闈炲父绠€鍗曪紝鏄� AI 鐖卞ソ鑰呭拰寮€鍙戣€呯殑蹇呭宸ュ叿銆�

**涓嬩竴姝�**锛氶€夋嫨涓€涓ā鍨嬶紝寮€濮嬩綘鐨勬湰鍦� AI 涔嬫梾鍚э紒
