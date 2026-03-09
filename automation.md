# 全自动发布系统

> 目标：无需人工手动，全自动发布到各平台
> 更新日期：2026-03-09

---

## 一、当前状态

| 平台 | 自动化程度 | 限制 |
|------|-----------|------|
| 网站 | ✅ 自动化 | Cron Job |
| 头条 | ⚠️ 半自动 | 需登录+图片 |
| 小红书 | ⚠️ 半自动 | 需登录+图片 |

---

## 二、自动化架构

```
┌─────────────────────────────────────────────────────────────┐
│                      调度中心 (Cron)                         │
│              每天 8:00 / 12:00 / 18:00                     │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   ┌─────────┐  ┌─────────┐  ┌─────────┐
   │  网站    │  │  头条   │  │ 小红书  │
   │  nucnas  │  │  toutiao│  │ xiaohong│
   │  .top   │  │         │  │   shu   │
   └────┬────┘  └────┬────┘  └────┬────┘
        │             │             │
        ▼             ▼             ▼
   GitHub        浏览器          浏览器
   Push          自动化          自动化
```

---

## 三、各平台自动化方案

### 3.1 网站 (nucnas.top) - ✅ 已完成

**流程**：
```
Cron触发 → AI生成内容 → Pexels配图 → Hugo构建 → GitHub推送 → Cloudflare部署
```

**定时任务**：
- 每天 8:00 AM
- 生成 3-5 篇

**实现方式**：
- Cron Job 调用 generate-content.ps1
- GitHub Actions 自动部署

---

### 3.2 头条 - 🔄 自动化方案

**目标**：全自动发布，无需手动

**流程**：
```
1. 定时触发
2. 获取热点话题
3. AI生成文章
4. 自动登录（Cookie持久化）
5. 自动发布（标题+正文+封面）
```

**技术方案**：

```powershell
# 头条自动发布脚本 (touTiao-publish.ps1)

# 1. 获取Cookie（首次手动，后续自动）
function Save-Cookie {
    # 登录后保存Cookie到文件
    $cookies = Get-ChromeCookies -Domain "toutiao.com"
    $cookies | ConvertTo-Json | Set-Content "cookies/toutiao.json"
}

# 2. 自动发布
function Publish-Toutiao {
    param(
        [string]$Title,
        [string]$Content,
        [string]$CoverImage
    )
    
    # 注入Cookie登录
    $cookie = Get-Content "cookies/toutiao.json" | ConvertFrom-Json
    
    # 调用发布API 或 浏览器自动化
    # ...
}
```

**关键点**：
- Cookie持久化：保存登录状态
- 热点获取：接入头条热点API
- 封面：使用Pexels配图

---

### 3.3 小红书 - 🔄 自动化方案

**目标**：全自动发布，无需手动

**流程**：
```
1. 定时触发
2. 获取热门话题
3. AI生成文案
4. 自动登录（Cookie持久化）
5. 自动发布（标题+图文+标签）
```

**技术方案**：

```powershell
# 小红书自动发布脚本 (xiaohongshu-publish.ps1)

# 1. 获取Cookie
function Save-XHS-Cookie {
    $cookies = Get-ChromeCookies -Domain "xiaohongshu.com"
    $cookies | ConvertTo-Json | Set-Content "cookies/xiaohongshu.json"
}

# 2. 自动发布图文
function Publish-Xiaohongshu {
    param(
        [string]$Title,
        [string[]]$Images,
        [string[]]$Tags
    )
    
    # 注入Cookie
    $cookie = Get-Content "cookies/xiaohongshu.json" | ConvertFrom-Json
    
    # 使用Playwright自动发布
    # ...
}
```

**关键点**：
- 图片上传：Playwright set_input_files
- 文字配图：Canvas/API生成
- Cookie持久化：Skip login

---

## 四、Cookie持久化方案

### 4.1 方案说明

**核心思路**：
1. 首次手动登录，保存Cookie
2. 后续自动读取Cookie，跳过登录
3. 定期更新Cookie（检测失效自动提醒）

### 4.2 实现

```powershell
# 通用Cookie保存函数
function Save-ChannelCookie {
    param(
        [string]$Channel,
        [string]$Domain
    )
    
    $cookieDir = "C:\Users\nczix\.openclaw\workspace\nucnas-hub\cookies"
    if (!(Test-Path $cookieDir)) {
        New-Item -ItemType Directory -Path $cookieDir
    }
    
    # 使用Playwright获取Cookie
    # 保存到 JSON 文件
}

# 使用时自动注入
function Load-Cookie {
    param([string]$Channel)
    
    $cookieFile = "cookies\$Channel.json"
    if (Test-Path $cookieFile) {
        return Get-Content $cookieFile | ConvertFrom-Json
    }
    return $null
}
```

---

## 五、定时任务配置

### 5.1 Cron 任务表

| 时间 | 任务 | 平台 |
|------|------|------|
| 8:00 AM | 生成+发布 | 网站 |
| 12:00 PM | 发布 | 头条 |
| 6:00 PM | 发布 | 小红书 |

### 5.2 实现

```json
{
  "jobs": [
    {
      "id": "nucnas-daily",
      "schedule": "0 8 * * *",
      "task": "powershell -File scripts/generate-content.ps1"
    },
    {
      "id": "toutiao-publish",
      "schedule": "0 12 * * *",
      "task": "powershell -File scripts/toutiao-publish.ps1"
    },
    {
      "id": "xiaohongshu-publish",
      "schedule": "0 18 * * *",
      "task": "powershell -File scripts/xiaohongshu-publish.ps1"
    }
  ]
}
```

---

## 六、需要开发/完善的脚本

### 待开发

| 脚本 | 状态 | 说明 |
|------|------|------|
| generate-content.ps1 | ⚠️ 需完善 | 网站内容生成 |
| touTiao-publish.ps1 | 🔴 待开发 | 头条自动发布 |
| xiaohongshu-publish.ps1 | 🔴 待开发 | 小红书自动发布 |
| hot-topics.ps1 | 🔴 待开发 | 热点获取 |
| cookie-manager.ps1 | 🔴 待开发 | Cookie管理 |

---

## 七、执行计划

### 阶段1：完善网站自动化 (今天)
- [ ] 完善 generate-content.ps1
- [ ] 接入AI生成实际内容
- [ ] 测试Cron任务

### 阶段2：头条自动化 (明天)
- [ ] 开发 touTiao-publish.ps1
- [ ] 手动登录保存Cookie
- [ ] 测试自动发布

### 阶段3：小红书自动化 (后天)
- [ ] 开发 xiaohongshu-publish.ps1
- [ ] 手动登录保存Cookie
- [ ] 测试自动发布

### 阶段4：统一调度 (第4天)
- [ ] 配置Cron定时任务
- [ ] 监控告警
- [ ] 异常处理

---

## 八、当前可执行的操作

### 立即可以做
1. ✅ 网站：已有Cron框架
2. ⚠️ 头条：需要先手动登录保存Cookie
3. ⚠️ 小红书：需要先手动登录保存Cookie

### 需要你配合
1. **首次手动登录**头条和小红书（我来操作保存Cookie）
2. **提供API Key**（如需要更智能的内容生成）

---

*本文件记录自动化开发进度*
