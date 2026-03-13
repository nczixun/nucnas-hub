---
title: "鏈湴AI鐭ヨ瘑搴撴惌寤烘暀绋嬶細RAG绯荤粺瀹炴垬鎸囧崡"
date: 2026-03-08
categories: ["ai"]
summary: "鎵嬫妸鎵嬫暀浣犵敤Ollama + LangChain鎼缓鏈湴RAG鐭ヨ瘑搴擄紝鏀寔PDF/Word/txt鏂囨。锛岄殣绉佸畨鍏ㄥ張鍏嶈垂"
tags: ["AI鐭ヨ瘑搴�", "RAG", "LangChain", "Ollama", "鏈湴閮ㄧ讲", "鍚戦噺鍖�"]
slug: "local-ai-knowledge-base-guide"
---

# 鏈湴AI鐭ヨ瘑搴撴惌寤烘暀绋嬶細RAG绯荤粺瀹炴垬鎸囧崡

寰堝绮変笣闂垜鎬庝箞鍦ㄦ湰鍦版惌寤轰竴涓睘浜庤嚜宸辩殑AI鐭ヨ瘑搴撱€備粖澶╁畨鎺掍笂锛岀敤Ollama + LangChain + Chroma锛岀函鏈湴杩愯锛岄殣绉佹湁淇濋殰銆�

## 浠€涔堟槸RAG锛�

RAG = 妫€绱㈠寮虹敓鎴愩€傜畝鍗曡灏辨槸锛�
1. 鎶婁綘鐨勬枃妗� Embedding 鎴愬悜閲�
2. 瀛樺埌鍚戦噺鏁版嵁搴�
3. 闂棶棰樻椂鍏堟绱㈢浉鍏虫钀�
4. 鎶婃绱㈢粨鏋滃杺缁欏ぇ妯″瀷鐢熸垚绛旀

杩欐牱灏变笉闇€瑕佹妸闅愮鏂囨。涓婁紶鍒颁簯绔簡銆�

## 鐜鍑嗗

### 纭欢瑕佹眰

- 鏄惧瓨锛氳嚦灏�16GB锛堣窇澶фā鍨嬬敤锛�
- 鍐呭瓨锛�32GB浠ヤ笂
- 纭洏锛氳嚦灏�100GB SSD

### 杞欢鐜

- Ubuntu 22.04 鎴� Windows WSL2
- Ollama
- Python 3.10+
- LangChain
- Chroma 鍚戦噺鏁版嵁搴�

## 鎼缓姝ラ

### 绗竴姝ワ細瀹夎Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

鎷夊彇妯″瀷锛�
```bash
ollama pull qwen2.5:7b
```

7B妯″瀷16GB鏄惧瓨澶熺敤锛屾兂瑕佹洿寮烘晥鏋滃彲浠ョ敤14B鎴�32B銆�

### 绗簩姝ワ細瀹夎Python渚濊禆

```bash
pip install langchain langchain-community langchain-chroma
pip install pypdf python-docx
pip install sentence-transformers
```

### 绗笁姝ワ細鍑嗗鐭ヨ瘑搴撴枃妗�

鏀寔鏍煎紡锛歅DF銆乄ord銆乀XT銆丮arkdown

鎴戞祴璇曠敤鐨勬槸PDF鏂囨。锛屾妸鏂囦欢鏀惧埌 `docs/` 鐩綍涓嬨€�

### 绗洓姝ワ細缂栧啓浠ｇ爜

鏍稿績浠ｇ爜寰堢畝鍗曪紝鍒嗕笁閮ㄥ垎锛�

```python
# 1. 鏂囨。鍔犺浇
from langchain_community.document_loaders import PyPDFLoader
loader = PyPDFLoader("docs/yourfile.pdf")
docs = loader.load()

# 2. 鏂囨湰鍒嗗壊
from langchain.text_splitter import RecursiveCharacterTextSplitter
splitter = RecursiveCharacterTextSplitter(chunk_size=500)
splits = splitter.split_documents(docs)

# 3. 鍚戦噺鍖栧瓨鍌�
from langchain_chroma import Chroma
from langchain_ollama import OllamaEmbeddings
embedding = OllamaEmbeddings(model="nomic-embed-text")
vectorstore = Chroma.from_documents(splits, embedding)

# 4. 闂瓟
from langchain_ollama import ChatOllama
llm = ChatOllama(model="qwen2.5:7b")
qa = RetrievalQA.from_chain_type(llm, retriever=vectorstore.as_retriever())
answer = qa.invoke("浣犵殑闂")
```

### 绗簲姝ワ細杩愯娴嬭瘯

```bash
python rag.py
```

闂竴浜涙枃妗ｇ浉鍏崇殑闂锛屾瘮濡傦細"杩欎唤鏂囨。鐨勬牳蹇冭鐐规槸浠€涔堬紵"

## 鎬ц兘娴嬭瘯

鎴戠敤N100 + 32GB鍐呭瓨瀹炴祴锛�

| 妯″瀷 | 棣栨鍝嶅簲鏃堕棿 | 鍐呭瓨鍗犵敤 |
|------|-------------|----------|
| qwen2.5:7b | 3-5绉� | 8GB |
| qwen2.5:14b | 6-8绉� | 16GB |
| deepseek-r1:14b | 8-10绉� | 18GB |

鏂囨。瓒婂锛屾绱㈡椂闂翠細鐩稿簲澧炲姞锛屼絾涓€鑸笉浼氳秴杩�2绉掋€�

## 甯歌闂

### 鍥炵瓟璐ㄩ噺宸�

- 璋冨ぇchunk_size
- 璋冩暣鍒嗗壊overlap
- 鎹㈡洿寮虹殑embedding妯″瀷

### 鏄惧瓨涓嶅

- 鐢�4bit閲忓寲妯″瀷
- 鍑忓皯鍚屾椂鍔犺浇鐨勬枃妗ｉ噺

## 鎬荤粨

鏈湴RAG鐭ヨ瘑搴撴槸涓ソ涓滆タ锛屼笉鐢ㄤ氦浼氬憳璐癸紝涓嶇敤鎷呭績闅愮娉勯湶銆侼100灏忎富鏈哄氨鑳借窇锛岄€傚悎涓汉鎴栧皬鍥㈤槦浣跨敤銆�

鏈夐棶棰樼殑璇勮鍖鸿锛佽寰椾竴閿笁杩烇紒

---
