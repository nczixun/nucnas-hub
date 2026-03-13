---
title: "Ollama + OpenWebUI 鏈湴閮ㄧ讲锛?0 鍒嗛挓鎼缓绉佷汉 AI 鍔╂墜"
date: 2026-03-07
categories: ["ai"]
summary: "Ollama 2026 鏈€鏂扮増瀹夎鏁欑▼锛岄厤鍚?OpenWebUI 瀹炵幇 ChatGPT 绾т綋楠屻€傛敮鎸?DeepSeek R1銆丵wen2.5銆丩lama3.1 绛変富娴佹ā鍨嬶紝瀹屽叏绂荤嚎杩愯锛屾暟鎹笉鍑烘湰鍦般€?
slug: "ollama-openwebui-deploy-2026"
tags: ["Ollama", "OpenWebUI", "鏈湴閮ㄧ讲", "DeepSeek R1", "AI 鏁欑▼"]
---

# Ollama + OpenWebUI 鏈湴閮ㄧ讲锛?0 鍒嗛挓鎼缓绉佷汉 AI 鍔╂墜


2026 骞达紝鏈湴 AI 閮ㄧ讲宸茬粡闈炲父鎴愮啛銆侽llama + OpenWebUI 缁勫悎锛岃兘璁╀綘鍦ㄦ湰鍦版嫢鏈夊拰 ChatGPT 鍑犱箮涓€鏍风殑浣撻獙锛岃€屼笖**瀹屽叏鍏嶈垂銆佹暟鎹笉鍑烘湰鍦?*銆?
鏈枃鍩轰簬 Windows 11 + NUC 杩蜂綘涓绘満瀹炴祴锛?0 鍒嗛挓鎼炲畾銆?
## 娴嬭瘯鐜

| 椤圭洰 | 閰嶇疆 |
|------|------|
| 璁惧 | 闆跺埢 SER8 Pro锛?845HS锛?|
| 鍐呭瓨 | 32GB DDR5 |
| 绯荤粺 | Windows 11 Pro |
| 妯″瀷 | DeepSeek R1 14B銆丵wen2.5 7B |

## 涓€銆佸畨瑁?Ollama

### 1.1 涓嬭浇瀹夎

璁块棶瀹樼綉锛歨ttps://ollama.com

```powershell
# 鎴栬€呯敤鍛戒护琛屽畨瑁咃紙Windows锛?winget install Ollama.Ollama
```

瀹夎瀹屾垚鍚庯紝Ollama 浼氳嚜鍔ㄥ湪鍚庡彴杩愯锛岄粯璁ょ鍙?`11434`銆?
### 1.2 楠岃瘉瀹夎

```powershell
# PowerShell 娴嬭瘯
ollama --version

# 杈撳嚭绀轰緥锛?# ollama version is 0.6.5
```

### 1.3 涓嬭浇妯″瀷

```powershell
# DeepSeek R1 14B锛堟帹鑽愶紝16GB 鍐呭瓨鍙繍琛岋級
ollama pull deepseek-r1:14b

# Qwen2.5 7B锛堜腑鏂囦紭鍖栵級
ollama pull qwen2.5:7b

# Llama 3.1 8B锛堣嫳鏂囪兘鍔涘己锛?ollama pull llama3.1:8b

# 杞婚噺鐗堬紙8GB 鍐呭瓨鍙繍琛岋級
ollama pull deepseek-r1:7b
```

| 妯″瀷 | 澶у皬 | 鏈€浣庡唴瀛?| 鎺ㄨ崘鍦烘櫙 |
|------|------|----------|----------|
| deepseek-r1:1.5b | 1.2GB | 4GB | 灏濋矞/绠€鍗曞璇?|
| deepseek-r1:7b | 5.8GB | 8GB | 鏃ュ父瀵硅瘽/鏂囨 |
| deepseek-r1:14b | 10GB | 16GB | 涓撲笟鍐欎綔/浠ｇ爜 |
| qwen2.5:7b | 5.5GB | 8GB | 涓枃鍐呭鍒涗綔 |

## 浜屻€佸畨瑁?OpenWebUI

OpenWebUI 鎻愪緵 Web 鐣岄潰锛屼綋楠屾帴杩?ChatGPT銆?
### 2.1 Docker 瀹夎锛堟帹鑽愶級

```powershell
# 鍒涘缓 Docker 瀹瑰櫒
docker run -d `
  -p 3000:8080 `
  --add-host=host.docker.internal:host-gateway `
  -v open-webui:/app/backend/data `
  --name open-webui `
  --restart always `
  ghcr.io/open-webui/open-webui:main
```

### 2.2 璁块棶鐣岄潰

娴忚鍣ㄦ墦寮€锛歨ttp://localhost:3000

棣栨鐧诲綍闇€瑕佸垱寤虹鐞嗗憳璐﹀彿锛?- 閭锛氶殢鎰忓～鍐欙紙鏈湴鐢級
- 瀵嗙爜锛氬缓璁?12 浣嶄互涓?
### 2.3 杩炴帴 Ollama

```
1. 鐐瑰嚮鍙充笂瑙掑ご鍍?鈫?璁剧疆
2. 杩涘叆 妯″瀷 鈫?Ollama
3. Base URL: http://host.docker.internal:11434
4. 鐐瑰嚮 娴嬭瘯杩炴帴
5. 淇濆瓨
```

## 涓夈€佹€ц兘瀹炴祴

### 3.1 鎺ㄧ悊閫熷害娴嬭瘯

璁惧锛氶浂鍒?SER8 Pro锛?845HS锛?2GB 鍐呭瓨锛?
| 妯″瀷 | 棣栧瓧寤惰繜 | 鐢熸垚閫熷害 | 鍐呭瓨鍗犵敤 |
|------|----------|----------|----------|
| deepseek-r1:7b | 0.8s | 42 tokens/s | 6.2GB |
| deepseek-r1:14b | 1.5s | 28 tokens/s | 10.5GB |
| qwen2.5:7b | 0.7s | 45 tokens/s | 5.8GB |

**璇勪环**锛?845HS 璺?14B 妯″瀷瀹屽叏澶熺敤锛?8 tokens/s 鐨勯€熷害鏃ュ父浣跨敤娴佺晠銆?
### 3.2 澶氳疆瀵硅瘽娴嬭瘯

杩炵画瀵硅瘽 20 杞紝涓婁笅鏂囬暱搴?8K锛?
| 妯″瀷 | 鍝嶅簲鏃堕棿 | 鍐呭瓨澧為暱 | 绋冲畾鎬?|
|------|----------|----------|--------|
| deepseek-r1:14b | 2-3s | +1.2GB | 绋冲畾 |
| qwen2.5:7b | 1-2s | +0.8GB | 绋冲畾 |

## 鍥涖€侀珮绾ч厤缃?
### 4.1 妯″瀷鍒囨崲

OpenWebUI 鏀寔鍦ㄧ晫闈㈢洿鎺ュ垏鎹㈡ā鍨嬶細

```
1. 鐐瑰嚮宸︿晶妯″瀷閫夋嫨鍣?2. 閫夋嫨宸蹭笅杞界殑妯″瀷
3. 鏂板璇濅細浣跨敤閫夊畾妯″瀷
```

### 4.2 鑷畾涔夌郴缁熸彁绀?
```
浣犳槸涓€鍚嶄笓涓氱殑鎶€鏈姪鎵嬶紝鎿呴暱锛?1. 缂栫▼闂瑙ｇ瓟锛圥ython/JavaScript/Go锛?2. 鎶€鏈柟妗堣璁?3. 浠ｇ爜瀹℃煡鍜屼紭鍖?
瑕佹眰锛?- 鍥炵瓟绠€娲侊紝鐩存帴缁欏嚭瑙ｅ喅鏂规
- 浠ｇ爜蹇呴』鍙繍琛岋紝鍖呭惈蹇呰娉ㄩ噴
- 涓嶇‘瀹氱殑鍐呭瑕佽鏄?```

### 4.3 API 璋冪敤

Ollama 鎻愪緵 OpenAI 鍏煎 API锛?
```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

response = client.chat.completions.create(
    model="deepseek-r1:14b",
    messages=[{"role": "user", "content": "Hello"}]
)

print(response.choices[0].message.content)
```

## 浜斻€佸父瑙侀棶棰?
### 闂 1锛氭ā鍨嬩笅杞芥參

**鍘熷洜**锛歄llama 鏈嶅姟鍣ㄥ湪鍥藉

**瑙ｅ喅**锛?```powershell
# 浣跨敤鍥藉唴闀滃儚
$env:OLLAMA_HOST="https://ollama.azhao.top"
ollama pull deepseek-r1:14b
```

### 闂 2锛氬唴瀛樹笉瓒?
**鐥囩姸**锛氱郴缁熷崱椤裤€佹ā鍨嬪姞杞藉け璐?
**瑙ｅ喅**锛?- 鍏抽棴鍏朵粬鍗犵敤鍐呭瓨鐨勭▼搴?- 浣跨敤鏇村皬鍙傛暟妯″瀷锛?b 鎴?1.5b锛?- 澧炲姞铏氭嫙鍐呭瓨锛堝缓璁?32GB 浠ヤ笂锛?
### 闂 3锛歄penWebUI 鏃犳硶杩炴帴 Ollama

**妫€鏌?*锛?```powershell
# 纭 Ollama 鍦ㄨ繍琛?ollama list

# 娴嬭瘯 API
curl http://localhost:11434/api/tags
```

## 鍏€佹墿灞曞缓璁?
| 鎵╁睍 | 鐢ㄩ€?| 闅惧害 |
|------|------|------|
| Everything 鎻掍欢 | 鏈湴鏂囦欢鎼滅储 | 猸愨瓙 |
| 鐭ヨ瘑搴?RAG | 绉佹湁鏂囨。闂瓟 | 猸愨瓙猸?|
| 璇煶杈撳叆 | 璇煶杞枃瀛?| 猸愨瓙 |
| 澶氭ā鍨嬭矾鐢?| 鑷姩閫夋嫨鏈€浣虫ā鍨?| 猸愨瓙猸愨瓙 |

---

*鏇村<a href="/ai/" target="_blank">AI</a>閮ㄧ讲鏁欑▼鍜?a href="/review/" target="_blank">纭欢娴嬭瘎</a>璇峰叧娉?[NUC NAS Hub](/)銆?

<div class="page-nav">
  <a href="/ai/deepseek-r1-local-deploy-2026/" rel="prev">涓婁竴椤碉細DeepSeek R1 鏈湴閮ㄧ讲鏁欑▼</a>
</div>

*鏈枃鐢?NUC NAS Hub 鑷姩鐢熸垚锛屽熀浜?nucnas.top 瀹炴祴鏁版嵁*
