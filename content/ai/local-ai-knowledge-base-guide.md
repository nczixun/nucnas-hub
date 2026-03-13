---
title: "閺堫剙婀碅I閻儴鐦戞惔鎾存儗瀵ょ儤鏆€缁嬪绱癛AG缁崵绮虹€圭偞鍨幐鍥у础"
date: 2026-03-08
categories: ["ai"]
summary: "閹靛濡搁幍瀣殌娴ｇ姷鏁llama + LangChain閹碱厼缂撻張顒€婀碦AG閻儴鐦戞惔鎿勭礉閺€顖涘瘮PDF/Word/txt閺傚洦銆傞敍宀勬缁変礁鐣ㄩ崗銊ュ嫉閸忓秷鍨�"
tags: ["AI閻儴鐦戞惔锟�", "RAG", "LangChain", "Ollama", "閺堫剙婀撮柈銊ц", "閸氭垿鍣洪崠锟�"]
slug: "local-ai-knowledge-base-guide"
---

# 閺堫剙婀碅I閻儴鐦戞惔鎾存儗瀵ょ儤鏆€缁嬪绱癛AG缁崵绮虹€圭偞鍨幐鍥у础

瀵板牆顦跨划澶夌闂傤喗鍨滈幀搴濈疄閸︺劍婀伴崷鐗堟儗瀵よ桨绔存稉顏勭潣娴滃氦鍤滃杈╂畱AI閻儴鐦戞惔鎾扁偓鍌欑矕婢垛晛鐣ㄩ幒鎺嶇瑐閿涘瞼鏁llama + LangChain + Chroma閿涘瞼鍑介張顒€婀存潻鎰攽閿涘矂娈ｇ粔浣规箒娣囨繈娈伴妴锟�

## 娴犫偓娑斿牊妲窻AG閿涳拷

RAG = 濡偓缁便垹顤冨铏规晸閹存劑鈧倻鐣濋崡鏇☆嚛鐏忚鲸妲搁敍锟�
1. 閹跺﹣缍橀惃鍕瀮濡楋拷 Embedding 閹存劕鎮滈柌锟�
2. 鐎涙ê鍩岄崥鎴﹀櫤閺佺増宓佹惔锟�
3. 闂傤噣妫舵０妯绘閸忓牊顥呯槐銏㈡祲閸忚櫕顔岄拃锟�
4. 閹跺﹥顥呯槐銏㈢波閺嬫粌鏉虹紒娆忋亣濡€崇€烽悽鐔稿灇缁涙梹顢�

鏉╂瑦鐗辩亸鍙樼瑝闂団偓鐟曚焦濡搁梾鎰潌閺傚洦銆傛稉濠佺炊閸掗绨粩顖欑啊閵嗭拷

## 閻滎垰顣ㄩ崙鍡楊槵

### 绾兛娆㈢憰浣圭湴

- 閺勬儳鐡ㄩ敍姘冲殾鐏忥拷16GB閿涘牐绐囨径褎膩閸ㄥ鏁ら敍锟�
- 閸愬懎鐡ㄩ敍锟�32GB娴犮儰绗�
- 绾剛娲忛敍姘冲殾鐏忥拷100GB SSD

### 鏉烆垯娆㈤悳顖氼暔

- Ubuntu 22.04 閹达拷 Windows WSL2
- Ollama
- Python 3.10+
- LangChain
- Chroma 閸氭垿鍣洪弫鐗堝祦鎼达拷

## 閹碱厼缂撳銉╊€�

### 缁楊兛绔村銉窗鐎瑰顥奜llama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

閹峰褰囧Ο鈥崇€烽敍锟�
```bash
ollama pull qwen2.5:7b
```

7B濡€崇€�16GB閺勬儳鐡ㄦ径鐔烘暏閿涘本鍏傜憰浣规纯瀵儤鏅ラ弸婊冨讲娴犮儳鏁�14B閹达拷32B閵嗭拷

### 缁楊兛绨╁銉窗鐎瑰顥奝ython娓氭繆绂�

```bash
pip install langchain langchain-community langchain-chroma
pip install pypdf python-docx
pip install sentence-transformers
```

### 缁楊兛绗佸銉窗閸戝棗顦惌銉ㄧ槕鎼存挻鏋冨锟�

閺€顖涘瘮閺嶇厧绱￠敍姝匘F閵嗕箘ord閵嗕箑XT閵嗕府arkdown

閹存垶绁寸拠鏇犳暏閻ㄥ嫭妲窹DF閺傚洦銆傞敍灞惧Ω閺傚洣娆㈤弨鎯у煂 `docs/` 閻╊喖缍嶆稉瀣ㄢ偓锟�

### 缁楊剙娲撳銉窗缂傛牕鍟撴禒锝囩垳

閺嶇ǹ绺炬禒锝囩垳瀵板牏鐣濋崡鏇礉閸掑棔绗侀柈銊ュ瀻閿涳拷

```python
# 1. 閺傚洦銆傞崝鐘烘祰
from langchain_community.document_loaders import PyPDFLoader
loader = PyPDFLoader("docs/yourfile.pdf")
docs = loader.load()

# 2. 閺傚洦婀伴崚鍡楀
from langchain.text_splitter import RecursiveCharacterTextSplitter
splitter = RecursiveCharacterTextSplitter(chunk_size=500)
splits = splitter.split_documents(docs)

# 3. 閸氭垿鍣洪崠鏍х摠閸岋拷
from langchain_chroma import Chroma
from langchain_ollama import OllamaEmbeddings
embedding = OllamaEmbeddings(model="nomic-embed-text")
vectorstore = Chroma.from_documents(splits, embedding)

# 4. 闂傤喚鐡�
from langchain_ollama import ChatOllama
llm = ChatOllama(model="qwen2.5:7b")
qa = RetrievalQA.from_chain_type(llm, retriever=vectorstore.as_retriever())
answer = qa.invoke("娴ｇ姷娈戦梻顕€顣�")
```

### 缁楊兛绨插銉窗鏉╂劘顢戝ù瀣槸

```bash
python rag.py
```

闂傤喕绔存禍娑欐瀮濡楋絿娴夐崗宕囨畱闂傤噣顣介敍灞剧槷婵″偊绱�"鏉╂瑤鍞ら弬鍥ㄣ€傞惃鍕壋韫囧啳顫囬悙瑙勬Ц娴犫偓娑斿牞绱�"

## 閹嗗厴濞村鐦�

閹存垹鏁100 + 32GB閸愬懎鐡ㄧ€圭偞绁撮敍锟�

| 濡€崇€� | 妫ｆ牗顐奸崫宥呯安閺冨爼妫� | 閸愬懎鐡ㄩ崡鐘垫暏 |
|------|-------------|----------|
| qwen2.5:7b | 3-5缁夛拷 | 8GB |
| qwen2.5:14b | 6-8缁夛拷 | 16GB |
| deepseek-r1:14b | 8-10缁夛拷 | 18GB |

閺傚洦銆傜搾濠傤樋閿涘本顥呯槐銏℃闂傜繝绱伴惄绋跨安婢х偛濮為敍灞肩稻娑撯偓閼割兛绗夋导姘崇Т鏉╋拷2缁夋帇鈧拷

## 鐢瓕顫嗛梻顕€顣�

### 閸ョ偟鐡熺拹銊╁櫤瀹革拷

- 鐠嬪啫銇嘽hunk_size
- 鐠嬪啯鏆ｉ崚鍡楀overlap
- 閹广垺娲垮铏规畱embedding濡€崇€�

### 閺勬儳鐡ㄦ稉宥咁檮

- 閻拷4bit闁插繐瀵插Ο鈥崇€�
- 閸戝繐鐨崥灞炬閸旂姾娴囬惃鍕瀮濡楋綁鍣�

## 閹崵绮�

閺堫剙婀碦AG閻儴鐦戞惔鎾存Ц娑擃亜銈芥稉婊嗐偪閿涘奔绗夐悽銊ゆ唉娴兼艾鎲崇拹鐧哥礉娑撳秶鏁ら幏鍛妇闂呮劗顫嗗▔鍕苟閵嗕炯100鐏忓繋瀵岄張鍝勬皑閼冲€熺獓閿涘矂鈧倸鎮庢稉顏冩眽閹存牕鐨崶銏ゆЕ娴ｈ法鏁ら妴锟�

閺堝妫舵０妯兼畱鐠囧嫯顔戦崠楦款潌閿涗浇顔囧妞剧闁款喕绗佹潻鐑囩磼

---
