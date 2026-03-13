# NUC NAS Hub - 内容自动生成脚本 v4
# 用途：每天自动生成3-5篇文章
# 使用本地AI（通过OpenClaw）生成内容

param(
    [int]$Count = 3,
    [string]$Category = ""
)

$ErrorActionPreference = "Stop"

# 配置
$ProjectDir = "D:\Projects\nucnas-hub"
$ContentDir = "$ProjectDir\content"

# 内容选题库
$Topics = @{
    "hardware" = @(
        "Intel N150 迷你主机值不值得买？",
        "AMD Ryzen AI 300 系列对比评测",
        "迷你主机选购指南2026",
        "Minisforum MS-01 深度测评",
        "Beelink SER8 优缺点分析",
        "ASUS NUC 14 Pro+ 怎么样",
        "零刻GTR7 Pro评测",
        "迷你主机散热方案对比"
    )
    "nas" = @(
        "NAS硬盘选购避坑指南",
        "群晖DS923+ vs 威联通TS-464C对比",
        "Docker容器推荐：NAS必装应用",
        "NAS组网方案：2.5G交换机怎么选",
        "极空间Z4Pro使用体验",
        "TrueNAS vs Unraid 哪个好",
        "NAS备份策略：321原则",
        "Docker Compose教程入门"
    )
    "ai" = @(
        "本地部署DeepSeek R1 教程",
        "Ollama vs LM Studio 哪个好？",
        "迷你主机跑大模型性能测试",
        "本地AI助手搭建指南",
        "AI PC选购建议",
        "RAG知识库搭建教程",
        "本地大模型量化科普",
        "Ollama模型管理技巧"
    )
}

function Invoke-LocalAI {
    param(
        [string]$Topic,
        [string]$Category
    )
    
    $prompt = "你是一个专业的数码评测博主。请根据以下主题写一篇800字左右的测评文章。

主题：$Topic

要求：
1. 标题吸引人，包含数字更佳
2. 内容专业但易懂
3. 包含优缺点分析
4. 适合SEO优化
5. 输出JSON格式：{""title"":""标题"",""content"":""正文内容"",""summary"":""摘要50字"",""tags"":[""标签1"",""标签2""]}"

    # 调用本地OpenClaw API生成内容
    $body = @{
        model = "minimax-cn/MiniMax-M2.5"
        messages = @(
            @{
                role = "user"
                content = $prompt
            }
        )
        temperature = 0.7
        max_tokens = 2000
    } | ConvertTo-Json -Depth 3
    
    try {
        # 使用本地AI API
        $response = Invoke-RestMethod -Uri "http://127.0.0.1:18789/v1/chat/completions" -Method Post -Body $body -ContentType "application/json" -TimeoutSec 120
        
        if ($response.choices) {
            $content = $response.choices[0].message.content
            # 尝试解析JSON
            try {
                $json = $content | ConvertFrom-Json
                return $json
            } catch {
                # 如果解析失败，尝试提取JSON
                if ($content -match '\{.*\}') {
                    $json = $matches[0] | ConvertFrom-Json
                    return $json
                }
            }
        }
    } catch {
        Write-Host "AI生成失败: $_"
    }
    
    # 失败时返回模板
    return @{
        title = $Topic
        content = "这是一篇关于$Topic的深度测评文章。作为迷你主机和NAS领域的专业评测博主，我来详细分析这款产品的优缺点。

【外观设计】
这款产品在外观设计上采用了简约风格，机身小巧精致，适合各种使用场景。

【性能表现】
在性能方面，这款产品表现出色，能够满足日常办公和家庭娱乐需求。

【优缺点分析】
优点：
1. 性能强劲
2. 性价比高
3. 做工精细

缺点：
1. 散热有待优化
2. 扩展性一般

【购买建议】
总体来说，这款产品适合对性能和性价比有要求的用户选择。"
        summary = "$Topic 深度测评"
        tags = @($Category, "测评", "推荐")
    }
}

function New-HugoPost {
    param(
        [string]$Title,
        [string]$Category,
        [string]$Summary,
        [string]$Content,
        [string[]]$Tags
    )
    
    $date = Get-Date -Format "yyyy-MM-dd"
    $slug = $Title -replace '[^\w\u4e00-\u9fa5]', '-' -replace '-+', '-'
    $filename = "$ContentDir\$Category\$slug.md"
    
    # 无配图，使用占位图
    $imageUrl = "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg"
    
    $tagsStr = ($Tags | ForEach-Object { """$_""" }) -join ", "
    
    $content = @"
---
title: "$Title"
date: $date
summary: "$Summary"
categories: ["$Category"]
tags: [$tagsStr]
image: "$imageUrl"
---

# $Title

$Content

---
*本文由 NUC NAS Hub 自动生成*
"@
    
    # 确保目录存在
    $dir = Split-Path $filename -Parent
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    
    Set-Content -Path $filename -Value $content -Encoding UTF8
    Write-Host "Created: $filename"
    return $filename
}

# 主流程
Write-Host "========================================="
Write-Host "NUC NAS Hub 内容自动生成 v4 (本地AI)"
Write-Host "========================================="

$categories = @("hardware", "nas", "ai")
if ($Category -and $categories -contains $Category) {
    $categories = @($Category)
}

$created = 0
for ($i = 0; $i -lt $Count; $i++) {
    $cat = $categories[$i % $categories.Count]
    $topicList = $Topics[$cat]
    $topic = $topicList[$i % $topicList.Count]
    
    Write-Host "`n[$($created+1)] 生成 $cat 类别: $topic"
    Write-Host "调用本地AI..."
    
    # 使用本地AI生成内容
    $result = Invoke-LocalAI -Topic $topic -Category $cat
    
    # 创建文章
    New-HugoPost -Title $result.title -Category $cat -Summary $result.summary -Content $result.content -Tags $result.tags
    
    $created++
    Write-Host "完成!"
    Start-Sleep -Seconds 3
}

Write-Host "`n========================================="
Write-Host "完成！共生成 $created 篇文章"
Write-Host "========================================="
