---
title: "ChatGPT 进阶使用技巧：如何写出高质量 Prompt？"
date: 2026-03-07
categories: ["ai"]
brand: "使用教程"
model: "ChatGPT Prompt"
slug: "chatgpt-prompt-advanced-techniques-2026"
---

# ChatGPT 进阶使用技巧：如何写出高质量 Prompt？

同样的 ChatGPT，为什么别人用的比你好？关键在于 **Prompt**。

**核心公式：**

```
角色 + 任务 + 约束 + 格式
```

**优质 Prompt 示例：**

```
你是一位资深程序员，熟悉 Python 和 Go。
请用 Python 写一个 FastAPI 接口，
要求：1. 支持 JWT 认证 2. 返回 JSON 格式 3. 包含单元测试示例
```

**进阶技巧：**

1. **Few-shot 示例**：给几个例子，让 AI 模仿格式
2. **思维链**：加一句"请一步步思考"让推理更准确
3. **温度参数**：创意写作用 0.9，代码生成用 0.2
4. **分隔符**：用 ``` 或 === 区分指令和内容

**实测效果：**
模糊提问："帮我写个接口" → 回复 200 字
精准提问："用 FastAPI 写用户登录接口，包含密码哈希和 JWT，返回 token" → 回复 800 字完整代码

提问越精准，答案越靠谱。
