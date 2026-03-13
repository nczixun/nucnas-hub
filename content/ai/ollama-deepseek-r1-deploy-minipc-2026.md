---
title: "Ollama 鏈湴閮ㄧ讲 DeepSeek R1锛氭渶浣庨厤缃姹�"
date: 2026-03-07
categories: ["ai"]
brand: "鏈湴閮ㄧ讲"
model: "Ollama + DeepSeek R1"
slug: "ollama-deepseek-r1-deploy-minipc-2026"
---

# Ollama 鏈湴閮ㄧ讲 DeepSeek R1锛氭渶浣庨厤缃姹�

DeepSeek R1 寮€婧愬悗锛屽緢澶氫汉鎯虫湰鍦伴儴缃层€傛渶浣庨厤缃埌搴曟槸澶氬皯锛�

**涓嶅悓鍙傛暟妯″瀷閰嶇疆瑕佹眰锛�**

| 妯″瀷 | 閲忓寲鐗堟湰 | 鏄惧瓨瑕佹眰 | 鍐呭瓨瑕佹眰 | 鎺ㄨ崘璁惧 |
| :--- | :--- | :--- | :--- | :--- |
| 1.5B | Q4_K_M | 4GB | 8GB | N100 杩蜂綘涓绘満 |
| 7B | Q4_K_M | 8GB | 16GB | 鏍告樉杞昏杽鏈� |
| 14B | Q5_K_M | 12GB | 24GB | 娓告垙鏈� / 杩蜂綘涓绘満 |
| 32B | Q4_K_M | 20GB | 32GB | 鍙板紡鏈� / 鏄惧崱鍧� |
| 70B | Q4_K_M | 43GB | 64GB | 澶氬崱鏈嶅姟鍣� |

**瀹炴祴鏁版嵁锛�**
- N100 閮ㄧ讲 1.5B 妯″瀷锛氭瘡绉� 8 tokens
- 8845HS 閮ㄧ讲 7B 妯″瀷锛氭瘡绉� 15 tokens
- 13900H + 32GB 鍐呭瓨锛�7B 妯″瀷姣忕 25 tokens

**閮ㄧ讲鍛戒护锛�**

```bash
ollama run deepseek-r1:1.5b
```

妯″瀷澶ぇ锛熺敤 **llama.cpp** 鍋氶噺鍖栧鐞嗭紝鏁堟灉宸笉澶氾紝鍗犵敤灏戜竴鍗娿€�
