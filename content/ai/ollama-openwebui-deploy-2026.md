---
title: "Ollama + OpenWebUI 鏈湴閮ㄧ讲锛�10鍒嗛挓鏋勫缓绉佷汉AI鍔╂墜"
date: 2026-03-07
categories: ["ai"]
summary: "Ollama 2026 鏈€鏂扮増瀹夎鏁欑▼锛岄厤鍚� OpenWebUI 瀹炵幇 ChatGPT 浣撻獙銆傛敮鎸� DeepSeek R1銆丵wen2.5銆丩lama3.1 绛変富娴佹ā鍨嬶紝瀹屽叏绂荤嚎杩愯锛屾暟鎹笉鍑烘湰鍦般€�"
slug: "ollama-openwebui-deploy-2026"
tags: ["Ollama", "OpenWebUI", "鏈湴閮ㄧ讲", "DeepSeek R1", "AI 鏁欑▼"]
---

# Ollama + OpenWebUI 鏈湴閮ㄧ讲锛�10鍒嗛挓鏋勫缓绉佷汉AI鍔╂墜

2026 骞达紝鏈湴 AI 閮ㄧ讲宸茬粡闈炲父鎴愮啛銆侽llama + OpenWebUI 缁勫悎锛岃兘璁╀綘鍦ㄦ湰鍦版嫢鏈夊拰 ChatGPT 鍑犱箮涓€鏍风殑浣撻獙锛岃€屼笖**瀹屽叏鍏嶈垂銆佹暟鎹笉鍑烘湰鍦�**銆�

## 涓轰粈涔堥€夋嫨 Ollama + OpenWebUI锛�

1. **瀹屽叏鍏嶈垂**锛氭棤闇€ API 璐圭敤
2. **鏁版嵁闅愮**锛氬畬鍏ㄧ绾胯繍琛�
3. **澶氭ā鍨嬫敮鎸�**锛欴eepSeek R1銆丵wen2.5銆丩lama3.1 绛�
4. **涓婃墜绠€鍗�**锛�10 鍒嗛挓閮ㄧ讲瀹屾垚

## 閮ㄧ讲姝ラ

### 1. 瀹夎 Ollama

```bash
# Windows
winget install Ollama.Ollama

# 鎴栬€呬娇鐢ㄥ畨瑁呭寘
```

### 2. 瀹夎 OpenWebUI

```bash
# 浣跨敤 Docker
docker run -d -p 8080:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### 3. 璁块棶浣跨敤

鎵撳紑娴忚鍣ㄨ闂� `http://localhost:8080`

## 鏀寔鐨勬ā鍨�

| 妯″瀷 | 鏄惧瓨瑕佹眰 | 鎺ㄨ崘鍦烘櫙 |
|------|----------|----------|
| Llama3.1 8B | 8GB | 鏃ュ父瀵硅瘽 |
| Qwen2.5 14B | 16GB | 涓撲笟浠诲姟 |
| DeepSeek R1 70B | 80GB | 澶嶆潅鎺ㄧ悊 |

## 甯歌闂

**Q: 鏄惧瓨涓嶅鎬庝箞鍔烇紵**
A: 閫夋嫨閲忓寲鐗堟湰锛屽 Q4_K_M銆丵5_K_S

**Q: 濡備綍鏇存柊妯″瀷锛�**
A: `ollama pull 妯″瀷鍚嶇О`
