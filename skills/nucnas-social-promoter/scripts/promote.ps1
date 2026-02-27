# NUC NAS Hub - 社交媒体推广脚本
# 用法: .\promote.ps1 -Platform "feishu" -Latest

param(
    [string]$Platform = "all",
    [string]$Slug = "",
    [switch]$Latest
)

$ErrorActionPreference = "Stop"

$RepoDir = "D:\Projects\nucnas-hub"
$ContentDir = "$RepoDir\content"

# 读取推广配置
$configFile = "$RepoDir\promotion-config.json"
if (Test-Path $configFile) {
    $config = Get-Content $configFile | ConvertFrom-Json
} else {
    $config = $null
}

function Get-LatestArticle {
    param([string]$Category = "")
    
    $articles = @()
    
    foreach ($cat in @("hardware", "nas", "ai")) {
        if ($Category -and $Category -ne $cat) { continue }
        
        $path = "$ContentDir\$cat\*.md"
        $files = Get-ChildItem $path -ErrorAction SilentlyContinue | Where-Object { $_.Name -notlike "_*" }
        
        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($content -match 'title:\s*"([^"]+)"') {
                $title = $matches[1]
            }
            if ($content -match 'date:\s*(\d{4}-\d{2}-\d{2})') {
                $date = $matches[1]
            }
            if ($content -match 'summary:\s*"([^"]+)"') {
                $summary = $matches[1]
            }
            
            $articles += [PSCustomObject]@{
                Title = $title
                Date = $date
                Summary = $summary
                Category = $cat
                Slug = $file.BaseName
                File = $file.FullName
            }
        }
    }
    
    # 按日期排序
    return ($articles | Sort-Object Date -Descending | Select-Object -First 1)
}

function Get-PromotionText {
    param(
        [PSCustomObject]$Article,
        [string]$Platform
    )
    
    $title = $Article.Title
    $summary = $Article.Summary
    $category = $Article.Category
    $slug = $Article.Slug
    
    # 构建URL
    $baseUrl = "https://www.nucnas.top"
    switch ($category) {
        "hardware" { $url = "$baseUrl/review/$slug" }
        "nas"      { $url = "$baseUrl/guide/$slug" }
        "ai"       { $url = "$baseUrl/ai/$slug" }
        default    { $url = "$baseUrl/$slug" }
    }
    
    # 平台适配
    switch ($Platform) {
        "feishu" {
            return @{
                title = "📢 新文章发布：$title"
                content = "**$title**

$summary

🔗 阅读全文：$url

#$($category)"
            }
        }
        "twitter" {
            $text = "🖥️ 新文章：$title

$summary

🔗 $url

#$($category) #NAS"
            return @{ text = $text }
        }
        "telegram" {
            return @{
                text = "📢 *新文章发布*

*$title*

$summary

🔗 阅读：$url"
            }
        }
    }
}

function Send-Feishu {
    param([hashtable]$Message)
    
    if (-not $config.feishu.webhook) {
        Write-Host "⚠️ 飞书 webhook 未配置" -ForegroundColor Yellow
        return
    }
    
    $body = @{
        msg_type = "text"
        content = @{
            text = $Message.content
        }
    } | ConvertTo-Json -Depth 3
    
    try {
        Invoke-RestMethod -Uri $config.feishu.webhook -Method Post -Body $body -ContentType "application/json"
        Write-Host "✓ 飞书推送成功" -ForegroundColor Green
    } catch {
        Write-Host "✗ 飞书推送失败: $_" -ForegroundColor Red
    }
}

function Send-Twitter {
    param([hashtable]$Message)
    
    if (-not $config.twitter.bearer_token) {
        Write-Host "⚠️ Twitter 配置未完成" -ForegroundColor Yellow
        return
    }
    
    # Twitter API v2 发布推文
    $headers = @{
        "Authorization" = "Bearer $($config.twitter.bearer_token)"
        "Content-Type" = "application/json"
    }
    
    $body = @{
        text = $Message.text
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "https://api.twitter.com/2/tweets" -Headers $headers -Method Post -Body $body
        Write-Host "✓ Twitter 发布成功" -ForegroundColor Green
    } catch {
        Write-Host "✗ Twitter 发布失败: $_" -ForegroundColor Red
    }
}

function Send-Telegram {
    param([hashtable]$Message)
    
    if (-not $config.telegram.bot_token) {
        Write-Host "⚠️ Telegram 配置未完成" -ForegroundColor Yellow
        return
    }
    
    $url = "https://api.telegram.org/bot$($config.telegram.bot_token)/sendMessage"
    $body = @{
        chat_id = $config.telegram.chat_id
        text = $Message.text
        parse_mode = "Markdown"
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType "application/json"
        Write-Host "✓ Telegram 发布成功" -ForegroundColor Green
    } catch {
        Write-Host "✗ Telegram 发布失败: $_" -ForegroundColor Red
    }
}

# 主流程
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NUC NAS Hub 社交媒体推广" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 获取文章
if ($Slug) {
    # 查找指定文章
    $article = Get-ChildItem "$ContentDir\*\*.md" | Where-Object { $_.BaseName -eq $Slug } | ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        [PSCustomObject]@{
            Title = if ($content -match 'title:\s*"([^"]+)"') { $matches[1] }
            Slug = $_.BaseName
            Summary = if ($content -match 'summary:\s*"([^"]+)"') { $matches[1] }
        }
    }
} else {
    $article = Get-LatestArticle
}

if (-not $article) {
    Write-Host "✗ 未找到文章" -ForegroundColor Red
    exit 1
}

Write-Host "推广文章: $($article.Title)" -ForegroundColor Yellow
Write-Host ""

# 推广到指定平台
$platforms = @()
if ($Platform -eq "all") {
    $platforms = @("feishu", "twitter", "telegram")
} else {
    $platforms = @($Platform)
}

foreach ($p in $platforms) {
    Write-Host "→ 发送到 $p..." -ForegroundColor Cyan
    $msg = Get-PromotionText -Article $article -Platform $p
    
    switch ($p) {
        "feishu" { Send-Feishu -Message $msg }
        "twitter" { Send-Twitter -Message $msg }
        "telegram" { Send-Telegram -Message $msg }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
