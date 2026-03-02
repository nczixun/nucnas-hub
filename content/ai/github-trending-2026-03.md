---
title: "2026年3月GitHub热门AI项目盘点：AI伴侣、本地大模型、Agent工具"
date: 2026-03-03
categories: ["ai"]
summary: "盘点2026年3月GitHub最火的AI项目，包括AIRI AI伴侣、ruflo Agent编排平台、OpenSandbox等，提供详细安装教程。"
image: https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg
imageCredit: "Alex Knight"
tags: ["GitHub", "AI", "工具", "教程"]
---

# 2026年3月GitHub热门AI项目盘点

今天GitHub trending发布了最新热门项目，让我们一起来看看有哪些值得关注的AI开源项目！

## 🏆 本期热门项目一览

| 项目 | Stars | 今日新增 | 描述 |
|------|-------|----------|------|
| airi | 21,210 | 1,425 | 自托管AI伴侣 |
| wifi-densepose | 20,699 | 5,080 | WiFi姿态估计 |
| ruflo | 17,825 | 821 | Claude Agent编排平台 |
| OpenSandbox | 3,937 | 982 | 阿里AI沙箱 |

---

## 1️⃣ AIRI - 自托管AI伴侣 ⭐21,210

**项目地址**：https://github.com/moeru-ai/airi

AIRI是一个开源的AI VTuber项目，旨在复现Neuro-sama，让每个用户都能拥有自己的虚拟AI伴侣。

### 🎯 核心功能

- 🤖 支持实时语音对话
- 🎮 能玩Minecraft、Factorio等游戏
- 💬 支持Discord、Telegram集成
- 🎭 支持VRM/Live2D虚拟形象
- 🌐 支持Web/桌面/移动端

### 🚀 安装方式

#### 方式一：直接体验（Web版）

访问 https://airi.moeru.ai 即可直接体验

#### 方式二：Docker部署（推荐）

```bash
# 克隆项目
git clone https://github.com/moeru-ai/airi.git
cd airi

# 使用Docker Compose启动
docker-compose up -d
```

#### 方式三：本地开发

```bash
# 安装pnpm
npm install -g pnpm

# 安装依赖
pnpm install

# 启动Web版本
pnpm dev
```

### 💡 支持的LLM提供商

项目支持30+种大模型API，包括：
- OpenAI (GPT-4)
- Anthropic (Claude)
- Google Gemini
- DeepSeek
- 阿里Qwen
- Ollama (本地模型)
- 以及更多...

---

## 2️⃣ ruflo - Claude Agent编排平台 ⭐17,825

**项目地址**：https://github.com/ruvnet/ruflo

ruflo是目前最火的Claude Agent编排平台，让你可以部署多个智能Agent协同工作。

### 🎯 核心功能

- 🤖 多Agent编排协同
- 💬 对话式AI系统
- 📚 RAG知识库集成
- 🔧 企业级架构
- ☁️ 分布式智能

### 🚀 安装方式

```bash
# 克隆项目
git clone https://github.com/ruvnet/ruflo.git
cd ruflo

# 安装依赖
npm install

# 启动服务
npm run dev
```

---

## 3️⃣ OpenSandbox - 阿里AI沙箱 ⭐3,937

**项目地址**：https://github.com/alibaba/OpenSandbox

阿里开源的通用AI沙箱平台，为AI应用提供安全隔离的执行环境。

### 🎯 核心功能

- 🐳 Docker/Kubernetes运行时
- 📝 多语言SDK支持
- 💻 编程Agent
- 🖥️ GUI Agent
- 📊 Agent评估

### 🚀 安装方式

```bash
# 使用Docker
docker run -d -p 8000:8000 alibaba/opensandbox

# 或使用Kubernetes
kubectl apply -f https://raw.githubusercontent.com/alibaba/OpenSandbox/main/deploy/k8s.yaml
```

---

## 4️⃣ WiFi DensePose - 姿态估计 ⭐20,699

**项目地址**：https://github.com/ruvnet/wifi-densepose

利用普通WiFi信号实现实时人体姿态估计、的生命体征监测和存在检测，无需摄像头！

### 🎯 核心功能

- 📡 WiFi信号姿态估计
- ❤️ 生命体征监测
- 👤 存在检测
- 🔒 隐私保护（无需摄像头）

### 🚀 安装方式

```bash
# 克隆项目
git clone https://github.com/ruvnet/wifi-densepose.git
cd wifi-densepose

# 安装依赖
pip install -r requirements.txt

# 运行推理
python inference.py
```

---

## 📊 本期总结

本期GitHub热门项目主要聚焦于：

1. **AI伴侣/虚拟形象** - AIRI让每个人都能拥有自己的AI虚拟伴侣
2. **Agent编排** - ruflo让多Agent协作变得更简单
3. **AI安全沙箱** - OpenSandbox解决AI应用安全问题
4. **隐私计算** - WiFi DensePose用WiFi实现姿态估计

这些项目代表了AI发展的不同方向，无论是想体验AI伴侣，还是构建自己的AI应用，都值得关注！

---

*本文由 NUC NAS Hub 自动生成*
