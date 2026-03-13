---
title: "闁哄牜鍓欏﹢纰匢闁活厹鍎撮惁鎴炴償閹惧瓨鍎楃€点倗鍎ら弳鈧紒瀣儜缁辩櫅AG缂侇垵宕电划铏光偓鍦仦閸剟骞愰崶褍纭€"
date: 2026-03-08
categories: ["ai"]
summary: "闁归潧顑嗘俊鎼佸箥鐎ｎ偅娈屽ù锝囧Х閺侇椀llama + LangChain闁圭⒈鍘肩紓鎾诲嫉椤掆偓濠€纰G闁活厹鍎撮惁鎴炴償閹垮嫮绀夐柡鈧娑樼槷PDF/Word/txt闁哄倸娲﹂妴鍌炴晬瀹€鍕吅缂佸绀侀悾銊╁礂閵娿儱瀚夐柛蹇撶Х閸拷"
tags: ["AI闁活厹鍎撮惁鎴炴償閿燂拷", "RAG", "LangChain", "Ollama", "闁哄牜鍓欏﹢鎾焾閵娧嗩唹", "闁告碍鍨块崳娲礌閿燂拷"]
slug: "local-ai-knowledge-base-guide"
---

# 闁哄牜鍓欏﹢纰匢闁活厹鍎撮惁鎴炴償閹惧瓨鍎楃€点倗鍎ら弳鈧紒瀣儜缁辩櫅AG缂侇垵宕电划铏光偓鍦仦閸剟骞愰崶褍纭€

鐎垫澘鐗嗛ˇ璺ㄥ垝婢跺顐鹃梻鍌ゅ枟閸ㄦ粓骞€鎼存繄鐤勯柛锔哄妽濠€浼村捶閻楀牊鍎楃€点倛妗ㄧ粩瀛樼▔椤忓嫮娼ｅù婊冩唉閸ゆ粌顔忔潏鈺傜暠AI闁活厹鍎撮惁鎴炴償閹炬墎鍋撻崒娆戠煏濠㈠灈鏅涢悾銊╁箳閹哄秶鐟愰柨娑樼灱閺侇椀llama + LangChain + Chroma闁挎稑鐬奸崙浠嬪嫉椤掆偓濠€瀛樻交閹邦垼鏀介柨娑樼焸濞堬絿绮旀担瑙勭畳濞ｅ洦绻堝▓浼村Υ閿燂拷

## 濞寸姭鍋撳☉鏂跨墛濡茬AG闁挎冻鎷�

RAG = 婵☆偀鍋撶紒渚垮灩椤ゅ啫顕ｉ搹瑙勬櫢闁瑰瓨鍔戦埀顒€鍊婚悾婵嬪础閺団槅鍤涢悘蹇氶哺濡叉悂鏁嶉敓锟�
1. 闁硅泛锕ｇ紞姗€鎯冮崟顒佺€俊妤嬫嫹 Embedding 闁瑰瓨鍔曢幃婊堟煂閿燂拷
2. 閻庢稒锚閸╁矂宕ラ幋锕€娅ら柡浣哄瀹撲焦鎯旈敓锟�
3. 闂傚偆鍣ｅΛ鑸碉紣濡粯顦ч柛蹇撶墛椤ュ懐妲愰姀銏＄ゲ闁稿繗娅曢宀勬媰閿燂拷
4. 闁硅泛锕ラˉ鍛閵忋垻娉㈤柡瀣矊閺夎櫣绱掑▎蹇嬩海婵☆垪鈧磭鈧兘鎮介悢绋跨亣缂佹稒姊归、锟�

閺夆晜鐟﹂悧杈╀焊閸欐ḿ鐟濋梻鍥ｅ亾閻熸洑鐒︽俊鎼佹⒕閹邦噮娼岄柡鍌氭处閵嗗倹绋夋繝浣虹倞闁告帡顣︾花顖滅博椤栨瑧鍟婇柕鍡嫹

## 闁绘粠鍨伴。銊╁礄閸℃妲�

### 缁绢収鍏涘▎銏㈡啺娴ｅ湱婀�

- 闁哄嫭鍎抽悺銊╂晬濮樺啿娈鹃悘蹇ユ嫹16GB闁挎稑鐗愮粣鍥ㄥ緞瑜庤啯闁搞劌顑囬弫銈夋晬閿燂拷
- 闁告劕鎳庨悺銊╂晬閿燂拷32GB濞寸姰鍎扮粭锟�
- 缁绢収鍓涘ú蹇涙晬濮樺啿娈鹃悘蹇ユ嫹100GB SSD

### 閺夌儐鍨▎銏ゆ偝椤栨凹鏆�

- Ubuntu 22.04 闁硅揪鎷� Windows WSL2
- Ollama
- Python 3.10+
- LangChain
- Chroma 闁告碍鍨块崳娲极閻楀牆绁﹂幖杈炬嫹

## 闁圭⒈鍘肩紓鎾愁潰閵夆晩鈧拷

### 缂佹鍏涚粩鏉戭潰閵夘垳绐楅悗鐟邦槼椤ュllama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

闁瑰嘲顦ぐ鍥熼垾宕団偓鐑芥晬閿燂拷
```bash
ollama pull qwen2.5:7b
```

7B婵☆垪鈧磭鈧拷16GB闁哄嫭鍎抽悺銊﹀緞閻旂儤鏆忛柨娑樻湰閸忓倻鎲版担瑙勭函鐎殿喚鍎ら弲銉╁几濠婂啫璁插ù鐘劤閺侊拷14B闁硅揪鎷�32B闁靛棴鎷�

### 缂佹鍏涚花鈺侇潰閵夘垳绐楅悗鐟邦槼椤ュython濞撴碍绻嗙粋锟�

```bash
pip install langchain langchain-community langchain-chroma
pip install pypdf python-docx
pip install sentence-transformers
```

### 缂佹鍏涚粭浣割潰閵夘垳绐楅柛鎴濇椤︻剟鎯岄妷銊ф閹煎瓨鎸婚弸鍐浖閿燂拷

闁衡偓椤栨稑鐦柡宥囧帶缁憋繝鏁嶅鍖楩闁靛棔绠榦rd闁靛棔绠慩T闁靛棔搴渁rkdown

闁瑰瓨鍨剁粊瀵告嫚閺囩姵鏆忛柣銊ュ濡茬DF闁哄倸娲﹂妴鍌炴晬鐏炴儳惟闁哄倸娲ｅ▎銏ゅ绩閹冪厒 `docs/` 闁烩晩鍠栫紞宥嗙▔鐎ｃ劉鍋撻敓锟�

### 缂佹鍓欏ú鎾愁潰閵夘垳绐楃紓鍌涚墪閸熸挻绂掗敐鍥╁灣

闁哄秶枪缁虹偓绂掗敐鍥╁灣鐎垫澘鐗忛悾婵嬪础閺囶亞绀夐柛鎺戞缁椾線鏌堥妸銉ョ€婚柨娑虫嫹

```python
# 1. 闁哄倸娲﹂妴鍌炲礉閻樼儤绁�
from langchain_community.document_loaders import PyPDFLoader
loader = PyPDFLoader("docs/yourfile.pdf")
docs = loader.load()

# 2. 闁哄倸娲﹀﹢浼村礆閸℃顥�
from langchain.text_splitter import RecursiveCharacterTextSplitter
splitter = RecursiveCharacterTextSplitter(chunk_size=500)
splits = splitter.split_documents(docs)

# 3. 闁告碍鍨块崳娲礌閺嵮呮憼闁稿矉鎷�
from langchain_chroma import Chroma
from langchain_ollama import OllamaEmbeddings
embedding = OllamaEmbeddings(model="nomic-embed-text")
vectorstore = Chroma.from_documents(splits, embedding)

# 4. 闂傚偆鍠氶悺锟�
from langchain_ollama import ChatOllama
llm = ChatOllama(model="qwen2.5:7b")
qa = RetrievalQA.from_chain_type(llm, retriever=vectorstore.as_retriever())
answer = qa.invoke("濞达絿濮峰▓鎴︽⒒椤曗偓椤ｏ拷")
```

### 缂佹鍏涚花鎻掝潰閵夘垳绐楅弶鈺傚姌椤㈡垵霉鐎ｎ厾妲�

```bash
python rag.py
```

闂傚偆鍠曠粩瀛樼濞戞瑦鐎俊妤嬬悼濞村宕楀畷鍥ㄧ暠闂傚偆鍣ｉ。浠嬫晬鐏炲墽妲峰┑鈥冲亰缁憋拷"閺夆晜鐟ら崬銈夊棘閸ャ劊鈧倿鎯冮崟顒傚闊洤鍟抽～鍥倷鐟欏嫭笑濞寸姭鍋撳☉鏂跨墳缁憋拷"

## 闁诡儸鍡楀幋婵炴潙顑堥惁锟�

闁瑰瓨鍨归弫顥�100 + 32GB闁告劕鎳庨悺銊р偓鍦仦缁佹挳鏁嶉敓锟�

| 婵☆垪鈧磭鈧拷 | 濡絾鐗楅濂稿传瀹ュ懐瀹夐柡鍐ㄧ埣濡拷 | 闁告劕鎳庨悺銊╁础閻樺灚鏆� |
|------|-------------|----------|
| qwen2.5:7b | 3-5缂佸鎷� | 8GB |
| qwen2.5:14b | 6-8缂佸鎷� | 16GB |
| deepseek-r1:14b | 8-10缂佸鎷� | 18GB |

闁哄倸娲﹂妴鍌滄惥婵犲偆妯嬮柨娑樻湰椤ュ懐妲愰姀鈩冾槯闂傚倻绻濈槐浼存儎缁嬭法瀹夊褏鍋涙慨鐐烘晬鐏炶偐绋诲☉鎾亾闁煎壊鍏涚粭澶嬪濮樺磭孝閺夆晪鎷�2缂佸甯囬埀顒婃嫹

## 閻㈩垱鐡曢～鍡涙⒒椤曗偓椤ｏ拷

### 闁搞儳鍋熼悺鐔烘嫻閵娾晛娅ょ€归潻鎷�

- 閻犲鍟妵鍢絟unk_size
- 閻犲鍟弳锝夊礆閸℃顥弌verlap
- 闁瑰箍鍨哄ú鍨嚕閾忚鐣眅mbedding婵☆垪鈧磭鈧拷

### 闁哄嫭鍎抽悺銊︾▔瀹ュ拋妾�

- 闁活澁鎷�4bit闂佹彃绻愮€垫彃螣閳ュ磭鈧拷
- 闁告垵绻愰惃顖炲触鐏炵偓顦ч柛鏃傚Ь濞村洭鎯冮崟顒佺€俊妤嬬秮閸ｏ拷

## 闁诡剝宕电划锟�

闁哄牜鍓欏﹢纰G闁活厹鍎撮惁鎴炴償閹惧瓨笑濞戞搩浜滈妶鑺ョ▔濠婂棎鍋柨娑樺缁楀鎮介妸銈嗗攭濞村吋鑹鹃幉宕囨嫻閻у摜绀夊☉鎾崇Ф閺併倝骞忛崨顓犲闂傚懏鍔楅～鍡椻枖閸曨垱鑻熼柕鍡曠偗100閻忓繐绻嬬€靛矂寮甸崫鍕殤闁煎啿鈧喓鐛撻柨娑樼焸閳ь剙鍊搁幃搴㈢▔椤忓啯鐪介柟瀛樼墪閻剟宕堕姀銈喰曞ù锝堟硶閺併倝濡撮敓锟�

闁哄牆顦靛Λ鑸碉紣濡吋鐣遍悹鍥у椤旀垿宕犳ウ娆炬綄闁挎稐娴囬鍥ь嚗濡炲墽顏遍梺娆惧枙缁椾焦娼婚悜鍥╃＜

---
