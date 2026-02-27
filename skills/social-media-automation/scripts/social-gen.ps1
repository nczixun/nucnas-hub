# Social Media Content Generator v2
# 社交媒体内容生成器 - 一键生成所有平台内容

param(
    [string]$Platform = "all",
    [int]$Count = 1
)

$RepoDir = "D:\Projects\nucnas-hub"
$ContentDir = "$RepoDir\content"

function Get-LatestArticles {
    param([int]$Count = 1)
    
    $articles = @()
    foreach ($cat in @("hardware", "nas", "ai")) {
        $path = "$ContentDir\$cat\*.md"
        $files = Get-ChildItem $path -ErrorAction SilentlyContinue | Where-Object { $_.Name -notlike "_*" }
        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($content -match 'title:\s*"([^"]+)"') { $title = $matches[1] }
            if ($content -match 'date:\s*(\d{4}-\d{2}-\d{2})') { $date = $matches[1] }
            if ($content -match 'summary:\s*"([^"]+)"') { $summary = $matches[1] }
            if ($content -match 'image:\s*(.+)') { $image = $matches[1].Trim() }
            $articles += [PSCustomObject]@{
                Title = $title
                Date = $date
                Summary = $summary
                Image = $image
                Category = $cat
                Slug = $file.BaseName
            }
        }
    }
    return ($articles | Sort-Object Date -Descending | Select-Object -First $Count)
}

function Get-WeChatContent {
    param($Article)
    
$url = "https://www.nucnas.top/$($Article.Category)/$Article.Slug"
$content = @"
【$($Article.Title)】

$($Article.Summary)

阅读原文：$url

--
NUCNAS - 专注迷你主机与NAS测评
"@
    return $content
}

function Get-WeiboContent {
    param($Article)
    
$url = "https://www.nucnas.top/$($Article.Category)/$Article.Slug"
$content = @"
【$($Article.Title)】

$($Article.Summary)

#迷你主机 #NAS #数码测评 #科技

🔗 $url
"@
    return $content
}

function Get-XiaohongshuContent {
    param($Article)
    
$content = @"
【$($Article.Title)】

$($Article.Summary)

#迷你主机 #NAS #数码 #科技测评 #好物推荐
"@
    return $content
}

function Get-DouyinScript {
    param($Article)
    
$script = @"
【$($Article.Title)】

时长：60秒

脚本：
---
开场白（3秒）：
最近在用这款迷你主机，感觉不错，给大家分享一下

正文（45秒）：
$($Article.Summary)

总结（12秒）：
总的来说，这款产品值得入手。好了，本期测评就到这里，喜欢的话点个赞支持下！

#迷你主机 #NAS #数码测评
---
"@
    return $script
}

function Get-BilibiliScript {
    param($Article)
    
$script = @"
【$($Article.Title)】

时长：5-10分钟

脚本：
---
开场：
兄弟们好，今天来聊聊这款产品

产品介绍：
$($Article.Title)
$($Article.Summary)

使用体验：
[这里是实际使用感受]

优缺点：
- 优点：xxx
- 缺点：xxx

总结：
[是否推荐购买]

结尾：
如果觉得有帮助，请一键三连支持一下，我是XXX，下期再见！

#迷你主机 #NAS #测评
---
"@
    return $script
}

# ============ Main ============
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Social Media Content Generator v2" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$articles = Get-LatestArticles -Count $Count
Write-Host "Found $($articles.Count) articles`n" -ForegroundColor Green

foreach ($article in $articles) {
    Write-Host "=== $($article.Title) ===" -ForegroundColor Yellow
    Write-Host "Date: $($article.Date)" -ForegroundColor Gray
    Write-Host ""
    
    if ($Platform -eq "wechat" -or $Platform -eq "all") {
        Write-Host "[📝 微信公众号]" -ForegroundColor Green
        Write-Host (Get-WeChatContent -Article $article)
        Write-Host ""
    }
    
    if ($Platform -eq "weibo" -or $Platform -eq "all") {
        Write-Host "[🐦 微博]" -ForegroundColor Green
        Write-Host (Get-WeiboContent -Article $article)
        Write-Host ""
    }
    
    if ($Platform -eq "xiaohongshu" -or $Platform -eq "all") {
        Write-Host "[📕 小红书]" -ForegroundColor Green
        Write-Host (Get-XiaohongshuContent -Article $article)
        Write-Host ""
    }
    
    if ($Platform -eq "douyin" -or $Platform -eq "all") {
        Write-Host "[🎵 抖音脚本]" -ForegroundColor Green
        Write-Host (Get-DouyinScript -Article $article)
        Write-Host ""
    }
    
    if ($Platform -eq "bilibili" -or $Platform -eq "all") {
        Write-Host "[📺 B站脚本]" -ForegroundColor Green
        Write-Host (Get-BilibiliScript -Article $article)
        Write-Host ""
    }
}

Write-Host "========================================" -ForegroundColor Cyan
