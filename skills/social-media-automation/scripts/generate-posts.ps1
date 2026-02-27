# Social Media Content Generator
# 自动生成国内社交媒体内容

param(
    [string]$Platform = "all",
    [string]$ArticleSlug = "",
    [switch]$Publish
)

$RepoDir = "D:\Projects\nucnas-hub"
$ContentDir = "$RepoDir\content"

function Get-LatestArticle {
    $articles = @()
    foreach ($cat in @("hardware", "nas", "ai")) {
        $path = "$ContentDir\$cat\*.md"
        $files = Get-ChildItem $path -ErrorAction SilentlyContinue | Where-Object { $_.Name -notlike "_*" }
        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($content -match 'title:\s*"([^"]+)"') { $title = $matches[1] }
            if ($content -match 'date:\s*(\d{4}-\d{2}-\d{2})') { $date = $matches[1] }
            if ($content -match 'summary:\s*"([^"]+)"') { $summary = $matches[1] }
            $articles += [PSCustomObject]@{ Title=$title; Date=$date; Summary=$summary; Category=$cat; Slug=$file.BaseName }
        }
    }
    return ($articles | Sort-Object Date -Descending | Select-Object -First 1)
}

function ConvertTo-WeChat {
    param($Article)
    
    $content = @"
【$($Article.Title)】

$($Article.Summary)

---

阅读原文：https://www.nucnas.top/$($Article.Category)/$($Article.Slug)

点击上方蓝字关注我们，获取更多数码测评！
"@
    return $content
}

function ConvertTo-Weibo {
    param($Article)
    
    $content = @"
【$($Article.Title)】

$($Article.Summary)

#数码 #测评 #NAS #迷你电脑

🔗 https://www.nucnas.top/$($Article.Category)/$($Article.Slug)
"@
    return $content
}

function ConvertTo-Xiaohongshu {
    param($Article)
    
    $content = @"
【$($Article.Title)】

$($Article.Summary)

#数码测评 #NAS #迷你主机 #科技
"@
    return $content
}

function ConvertTo-Douyin {
    param($Article)
    
    $script = @"
【$($Article.Title)】

开场：最近有很多朋友问我有什么好的迷你主机推荐，今天来聊聊

内容：$($Article.Summary)

结尾：觉得有用的话，点个赞支持一下，关注我获取更多测评！

#数码 #测评 #NAS #迷你电脑
"@
    return $script
}

# Main
Write-Host "========================================"
Write-Host "  Social Media Content Generator"
Write-Host "========================================"

$article = Get-LatestArticle
Write-Host "Latest article: $($article.Title)"
Write-Host ""

if ($Platform -eq "wechat" -or $Platform -eq "all") {
    Write-Host "[微信] --------------------"
    ConvertTo-WeChat -Article $article
}

if ($Platform -eq "weibo" -or $Platform -eq "all") {
    Write-Host "[微博] --------------------"
    ConvertTo-Weibo -Article $article
}

if ($Platform -eq "xiaohongshu" -or $Platform -eq "all") {
    Write-Host "[小红书] ------------------"
    ConvertTo-Xiaohongshu -Article $article
}

if ($Platform -eq "douyin" -or $Platform -eq "all") {
    Write-Host "[抖音/脚本] --------------"
    ConvertTo-Douyin -Article $article
}

Write-Host ""
Write-Host "========================================"
