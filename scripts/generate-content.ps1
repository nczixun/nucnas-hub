# NUC NAS Hub - 内容自动生成脚本
# 用途：每天自动生成3-5篇文章

param(
    [int]$Count = 3,
    [string]$Category = ""
)

$ErrorActionPreference = "Stop"

# 配置
$ContentDir = "D:\Projects\nucnas-hub\content"
$PexelsApiKey = $env:PEXELS_TOKEN
$OpenAIKey = $env:OPENAI_TOKEN

# 读取secrets
$secrets = Get-Content "D:\Projects\nucnas-hub\secrets.json" | ConvertFrom-Json
$PexelsApiKey = $secrets.pexels_token

function Get-PexelsImage {
    param([string]$Query)
    
    $url = "https://api.pexels.com/v1/search?query=$Query&per_page=1"
    $headers = @{
        "Authorization" = $PexelsApiKey
    }
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        if ($response.photos) {
            return $response.photos[0].src.large2x
        }
    } catch {
        Write-Host "Pexels API Error: $_"
    }
    return "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg"
}

function New-HugoPost {
    param(
        [string]$Title,
        [string]$Category,
        [string]$Summary,
        [string]$Tags
    )
    
    $date = Get-Date -Format "yyyy-MM-dd"
    $slug = $Title -replace '[^\w\u4e00-\u9fa5]', '-' -replace '-+', '-'
    $filename = "$ContentDir\$Category\$slug.md"
    
    # 获取配图
    $imageUrl = Get-PexelsImage -Query $Title
    
    $content = @"
---
title: "$Title"
date: $date
summary: "$Summary"
categories: ["$Category"]
tags: [$tags]
image: "$imageUrl"
---

# $Title

![]($imageUrl)

$Summary

<!-- 更多内容由AI生成 -->

---
*本文由 NUC NAS Hub 自动生成*
"@
    
    Set-Content -Path $filename -Value $content -Encoding UTF8
    Write-Host "Created: $filename"
    return $filename
}

# 主流程
Write-Host "开始生成内容..."

$categories = @("hardware", "nas", "ai")
if ($Category -and $categories -contains $Category) {
    $categories = @($Category)
}

for ($i = 0; $i -lt $Count; $i++) {
    $cat = $categories[$i % $categories.Count]
    
    # 这里可以接入AI生成实际内容
    # 暂时使用模板
    $title = "每日更新 - $cat - $(Get-Date -Format 'yyyyMMddHHmm')"
    $summary = "这是自动生成的文章摘要"
    $tags = '"$cat", "自动生成"'
    
    New-HugoPost -Title $title -Category $cat -Summary $summary -Tags $tags
}

Write-Host "内容生成完成！"
