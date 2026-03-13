---
title: "杩蜂綘涓绘満璺戞湰鍦板ぇ妯″瀷锛歄llama閮ㄧ讲Qwen2.5瀹炴祴"
date: 2026-03-07
categories: ["ai"]
tags: ["Ollama", "鏈湴澶фā鍨�", "Qwen", "LLM閮ㄧ讲"]
slug: "ollama-qwen25-minipc-deploy-2026"
---

# 杩蜂綘涓绘満璺戞湰鍦板ぇ妯″瀷锛歄llama閮ㄧ讲Qwen2.5瀹炴祴

鎯崇敤杩蜂綘涓绘満璺戞湰鍦板ぇ妯″瀷锛熸病闂锛屼粖澶╂墜鎶婃墜鏁欎綘鐢� Ollama 閮ㄧ讲 Qwen2.5锛屽疄娴嬪彲鐢ㄣ€�

## 鐜瑕佹眰

- 杩蜂綘涓绘満锛堟帹鑽� AMD 8845HS 鎴� Intel Ultra 7 浠ヤ笂锛�
- 鍐呭瓨 32GB 浠ヤ笂锛�16GB 鍕夊己璺� 7B 妯″瀷锛�
- 纭洏 50GB 浠ヤ笂绌洪棿

## 瀹夎姝ラ

### 1. 瀹夎 Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Windows 鐢ㄦ埛鐩存帴鍘诲畼缃戜笅杞藉畨瑁呭寘銆�

### 2. 鎷夊彇妯″瀷

鏍规嵁鍐呭瓨閫夋嫨妯″瀷澶у皬锛�

```bash
# 7B 妯″瀷锛堥渶瑕� 16GB 鍐呭瓨锛�
ollama pull qwen2.5:7b

# 14B 妯″瀷锛堥渶瑕� 32GB 鍐呭瓨锛�
ollama pull qwen2.5:14b
```

### 3. 鍚姩鏈嶅姟

```bash
ollama serve
```

鏂板紑缁堢瀵硅瘽锛�

```bash
ollama run qwen2.5:7b
```

## 瀹炴祴鏁版嵁

**娴嬭瘯鏈哄瀷锛�** 闆跺埢 SER8 8845HS + 32GB 鍐呭瓨

| 妯″瀷 | 棣栨鍔犺浇 | 鐢熸垚閫熷害 | 鍐呭瓨鍗犵敤 |
|------|----------|----------|----------|
| Qwen2.5:7b | 15 绉� | 20 token/s | 14GB |
| Qwen2.5:14b | 28 绉� | 12 token/s | 28GB |

## 杩涢樁锛歐ebUI 鐣岄潰

鎺ㄨ崘鐢� Open WebUI锛岀晫闈㈢編瑙傦細

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

璁块棶 http://localhost:3000 鍗冲彲銆�

## 閫傜敤鍦烘櫙

- 鏈湴鐭ヨ瘑搴撻棶绛�
- 浠ｇ爜杈呭姪缂栫▼
- 鏂囨。鎬荤粨鍐欎綔
- 绂荤嚎 AI 鍔╂墜

鐩告瘮浜戠 API锛屾湰鍦伴儴缃�**闅愮瀹夊叏**锛�**鏃犻檺鐣呰亰**锛�**鎴愭湰涓洪浂**銆傛劅鍏磋叮鐨勮刀绱ц瘯璇曪紒
