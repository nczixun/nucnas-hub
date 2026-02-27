---
title: "ComfyUI 极速入门：像搭积木一样设计 AI 绘图工作流"
date: 2026-02-12
summary: "为什么资深玩家都从 WebUI 转向了 ComfyUI？"
categories: ["ai"]
---

# ComfyUI极速入门：像搭积木一样设计AI绘图工作流

在AI绘图领域，Stable Diffusion WebUI（简称WebUI）曾经是绝对的主流。这个基于Gradio开发的Web界面让每个人都能轻松生成AI画作，极大地推动了AI绘画的普及。然而，随着用户需求越来越专业、越来越个性化，WebUI的局限性也逐渐显现——工作流难以保存、自定义空间有限、节点扩展困难。正是在这个背景下，**ComfyUI**横空出世，迅速成为AI绘画进阶玩家的新宠。

ComfyUI采用完全不同的设计理念：用"节点"而非"滑块"来构建工作流。这种方式不仅更加灵活，还能实现复杂得多的自定义功能。本文将带来ComfyUI的快速入门指南，帮助你从零开始掌握这个强大的AI绘图工具。

## 为什么选择ComfyUI

要理解ComfyUI的优势，先要了解WebUI的局限。WebUI把所有功能都打包成了直观的滑块和按钮，这降低了使用门槛，但也限制了可定制性——用户只能在开发者预设的范围内调整参数，想要添加新功能或改变流程非常困难。

ComfyUI则采用了完全开放的架构。每一个处理步骤——加载模型、输入提示词、设置采样器、生成图像——都被封装成一个独立的"节点"。用户可以像搭积木一样自由组合这些节点，形成一个完整的图像生成工作流。

**ComfyUI的核心优势**包括：

- **工作流可保存**：整个工作流可以保存为JSON文件，下次打开直接使用。
- **极高的定制性**：可以添加第三方节点实现任何你想要的功能。
- **显存效率高**：相比WebUI，ComfyUI对显存的利用更加高效，同样的显卡可以生成更大尺寸的图像。
- **执行速度快**：增量计算和智能缓存让它在很多场景下比WebUI更快。
- **完全免费开源**：没有任何商业化限制。

## 安装与环境配置

ComfyUI可以在Windows、Mac和Linux上运行，推荐使用Windows进行本地部署。以下是Windows安装步骤：

**前置要求**：
- NVIDIA显卡（至少6GB显存，8GB以上为佳）
- 安装Python 3.10-3.11（不要使用Python 3.12）
- 安装Git

**安装步骤**：

第一步，克隆ComfyUI仓库：

```bash
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
```

第二步，创建虚拟环境（推荐）：

```bash
python -m venv venv
venv\Scripts\activate
```

第三步，安装依赖：

```bash
pip install -r requirements.txt
```

第四步，下载模型。将Stable Diffusion模型（.safetensors或.ckpt格式）放入`models/checkpoints`文件夹。推荐先下载一个基础模型，如`v1-5-pruned-emaonly.safetensors`。

第五步，启动ComfyUI：

```bash
python main.py
```

启动完成后，在浏览器中打开`http://127.0.0.1:8188`即可看到ComfyUI界面。

## 界面与基础操作

ComfyUI的界面分为几个区域：

**左侧边栏**：包含所有可用的节点，按类别排列（模型加载器、采样器、提示词、图像处理等）。

**中间画布**：工作流编辑区域，节点放置和连接的地方。

**右侧面板**：当前选中节点的属性设置。

**底部栏**：执行队列和生成进度。

**基本操作流程**：

1. **添加节点**：从左侧拖拽节点到画布，或右键点击画布选择"Add Node"。

2. **连接节点**：从一个节点的输出端口（圆形）拖线到另一个节点的输入端口（方形）。连接需要类型匹配——"MODEL"输出只能连接到"MODEL"输入。

3. **设置参数**：点击节点，在右侧面板中调整参数。

4. **执行生成**：点击"Queue Prompt"按钮开始生成。

5. **保存工作流**：点击"Save"可以将当前工作流保存为JSON文件。

## 构建你的第一个工作流

让我们从零开始构建一个最基本的文生图工作流：

**第一步：加载模型**

添加"Load Checkpoint"节点，选择你要使用的SD模型。

**第二步：输入提示词**

添加"CLIP Text Encode (Prompt)"节点两次——一个连接正面提示词，一个连接负面提示词。将它们的"CLIP"输出连接到Load Checkpoint节点的"CLIP"输入。

**第三步：设置采样器**

添加"KSampler"节点，将Load Checkpoint的"MODEL"连接到KSampler的"model"，正面提示词的"CONDITIONING"连接到positive，负面提示词的"CONDITIONING"连接到negative。

在KSampler中设置：
- Seed：随机种子
- Steps：采样步数（通常20-30）
- CFG：提示词引导强度（7-12为佳）
- Sampler：采样器选择（euler、euler_a、dpm_2等）
- Scheduler：调度器（normal、karras、exponential等）

**第四步：VAE解码**

添加"VAE Decode"节点，将KSampler的"latent"连接到它的"latent"输入，Load Checkpoint的"VAE"连接到VAE的"vae"。

**第五步：保存图像**

添加"Save Image"节点，将VAE Decode的"IMAGE"连接到它的"image"输入。

现在，按下"Queue Prompt"，你就能生成第一张AI图片了！

## 常用节点与进阶功能

ComfyUI有海量的第三方节点可以实现各种功能，以下是一些最常用的：

**ControlNet**：控制图像生成的结构和姿势。需要安装ComfyUI-Manager，然后在管理器中搜索安装ControlNet相关节点。

**LoRA加载器**：加载LoRA模型进行风格调整或角色定制。有多种实现方式，推荐使用"Load LoRA"节点。

**图像到图像（Img2Img）**：使用"VAE Encode"将图像编码为latent，然后在KSampler中处理，再"VAE Decode"回来。

**高清放大**：使用"Ultimate SD Upscale"或"ESRGAN"节点进行AI超分辨率放大。

**提示词增强**：使用"Wildcards"节点实现随机元素，"CLIP Interrogator"可以从图像反推提示词。

## ComfyUI-Manager：扩展管理神器

ComfyUI-Manager是必装的扩展，它提供了一个图形化的界面来管理自定义节点和模型：

第一步，安装ComfyUI-Manager：

```bash
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
```

第二步，重启ComfyUI。在左侧边栏底部会出现"Manager"按钮。点击可以：

- 搜索和安装社区节点
- 一键更新所有节点和ComfyUI本身
- 导入/导出工作流模板
- 修复损坏的安装

## 资源与社区

ComfyUI拥有活跃的社区和丰富的学习资源：

**工作流分享**：Civitai上有大量ComfyUI工作流可以一键导入，许多创作者会分享自己精心调校的工作流。

**节点文档**：每个节点通常都有详细的功能说明，可以在GitHub仓库或官方wiki查阅。

**视频教程**：YouTube和B站上有大量ComfyUI从入门到精通的视频教程。

**Discord社区**：ComfyUI官方Discord非常活跃，可以在里面提问和交流。

## 常见问题解答

**Q：生成的图像是黑的/有噪点？**
A：检查VAE是否正确连接。某些模型需要单独加载VAE。

**Q：显存不够用怎么办？**
A：使用模型量化版本（FP16而非FP32），或在KSampler中启用"Normal"模式而非"ETA Noise Field Wrapper"。

**Q：提示词不生效？**
A：检查节点连接是否正确，特别是CLIP Text Encode节点的CONDITIONING输出必须连接到KSampler。

## 从WebUI迁移

如果你已经是WebUI用户，ComfyUI提供了导入功能。安装"WD14 Tagger"和"DEPDOF"等WebUI插件的对应节点后，可以导入WebUI的设置。但更推荐的方式是重新学习ComfyUI的工作流逻辑——虽然上手门槛稍高，但掌握后的自由度是WebUI无法比拟的。

## 总结

ComfyUI代表了AI绘图的未来方向：更高的自由度、更好的效率、更强的定制能力。虽然它没有WebUI那么"傻瓜式"的界面，但一旦掌握了节点编辑的逻辑，你将拥有无限的可能性。

从今天开始，尝试在ComfyUI中构建你的第一个工作流吧。当你能够自如地组合各种节点，当你可以导入别人分享的精美工作流，当你能够创建属于自己的独特工作流——你会发现，AI绘画的世界远比想象的要宽广得多。
