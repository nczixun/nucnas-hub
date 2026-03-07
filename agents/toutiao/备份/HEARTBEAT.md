# HEARTBEAT.md

## 反馈群聊
- **群聊ID**: oc_20463abbe4970f39d9faf6cc4eda0492
- **群名称**: 今日头条 toutiao Agent
- **反馈规则**: 每次发布后实时反馈

## 每日任务

### P0 - 最高优先级
- 用户消息 - 立即响应

### P1 - 运营任务
- 今日头条文章发布
- 热点追踪
- **发布后反馈到群聊**（格式见下方）

### P2 - 优化任务
- self-improve 经验记录

---

## 经验记录

使用 self-improve skill 记录运营经验：
- 捕获用户纠正 → `self-improve.sh learn "规则" --correction`
- 捕获失败 → `self-improve.sh learn "错误" --failure`

学习日志位置：`memory/learnings.md`

---

## 发布反馈模板

### 发布成功
```
✅ 今日头条发布成功

📌 标题: xxx
🕐 发布时间: xxx
📊 状态: 已发布
```

### 发布失败
```
❌ 今日头条发布失败

📌 标题: xxx
❌ 失败原因: xxx
🔧 建议: xxx
```
