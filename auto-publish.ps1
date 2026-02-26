# NUC NAS Hub 自动文章生成与发布脚本
# 每天 3-5 篇文章，自动配图

param(
    [int]$ArticleCount = 4
)

$ErrorActionPreference = "Stop"

# 配置
$RepoPath = $PSScriptRoot
$ContentPath = Join-Path $RepoPath "content"
$SecretsPath = Join-Path (Split-Path $RepoPath -Parent) "nucnas-secrets.json"

# 加载密钥
if (Test-Path $SecretsPath) {
    $secrets = Get-Content $SecretsPath | ConvertFrom-Json
    $GithubToken = $secrets.github.token
    $PexelsToken = $secrets.pexels.token
} else {
    throw "密钥文件不存在: $SecretsPath"
}

# 栏目配置
$Categories = @{
    "hardware" = @{
        Topics = @(
            "迷你主机新品发布", "迷你主机性能对比", "迷你主机散热测试", 
            "NAS硬盘选购", "NAS系统对比", "软路由搭建",
            "新品牌测评", "性价比推荐", "硬件开箱"
        )
        Keywords = @("minipc", "computer", "technology", "server", "hardware")
    }
    "nas" = @{
        Topics = @(
            "Docker容器部署", "家庭影音搭建", "数据备份策略",
            "远程访问配置", "NAS安全设置", "虚拟化方案",
            "照片管理", "智能家居集成", "文件同步方案"
        )
        Keywords = @("server", "network", "storage", "technology", "data")
    }
    "ai" = @{
        Topics = @(
            "本地大模型部署", "Ollama使用教程", "AI绘图入门",
            "语音识别方案", "AI代理搭建", "模型微调指南",
            "API使用技巧", "开源模型推荐", "AI硬件配置"
        )
        Keywords = @("artificial intelligence", "technology", "computer", "coding", "robot")
    }
}

# 获取 Pexels 图片
function Get-PexelsImage {
    param([string]$Keyword)
    
    try {
        $url = "https://api.pexels.com/v1/search?query=$Keyword&per_page=5&orientation=landscape"
        $response = Invoke-RestMethod -Uri $url -Headers @{ Authorization = $PexelsToken }
        
        if ($response.photos.Count -gt 0) {
            $photo = $response.photos | Get-Random
            return @{
                Url = $photo.src.large
                Photographer = $photo.photographer
                PhotographerUrl = $photo.photographer_url
                Alt = $photo.alt
            }
        }
    } catch {
        Write-Warning "获取图片失败: $_"
    }
    return $null
}

# 生成文章内容（使用大模型）
function New-ArticleContent {
    param(
        [string]$Category,
        [string]$Topic
    )
    
    # 这里调用配置的大模型生成内容
    # 实际实现需要通过 OpenClaw 的 agent 接口
    
    $prompt = @"
请为 NUC NAS Hub 网站写一篇关于"$Topic"的文章。

要求：
1. 标题吸引眼球，包含主题关键词
2. 文章长度 800-1500 字
3. 内容专业且通俗易懂
4. 包含实用技巧或具体步骤
5. 使用 Markdown 格式
6. 包含 2-3 个小标题

栏目背景：
- hardware：迷你主机、NAS 硬件测评
- nas：NAS 使用教程
- ai：本地 AI 部署教程

请直接输出文章内容（不含 front matter）。
"@
    
    # 返回生成的文章（这里需要实际调用模型）
    return $prompt
}

# 生成文章文件
function New-Article {
    param(
        [string]$Category,
        [string]$Topic
    )
    
    $today = Get-Date -Format "yyyy-MM-dd"
    $slug = $Topic -replace '[^\w\s-]', '' -replace '\s+', '-' -replace '-+', '-'
    $slug = $slug.ToLower().Substring(0, [Math]::Min($slug.Length, 50))
    
    # 获取配图
    $keywords = $Categories[$Category].Keywords
    $image = Get-PexelsImage ($keywords | Get-Random)
    
    # 生成 front matter
    $frontMatter = @"
---
title: "$Topic"
date: $today
categories: ["$Category"]
summary: "关于 $Topic 的详细教程与实用技巧。"
image: "$($image.Url)"
imageCredit: "$($image.Photographer)"
---
"@
    
    # 生成文章内容
    $content = New-ArticleContent -Category $Category -Topic $Topic
    
    # 组合完整文章
    $fullContent = @"
$frontMatter

# $Topic

![$($image.Alt)]($($image.Url))
*图片: $($image.Photographer) / Pexels*

$content

---
*本文由 NUC NAS Hub 自动生成，内容仅供参考。*
"@
    
    # 写入文件
    $fileName = "$slug.md"
    $filePath = Join-Path $ContentPath $Category $fileName
    
    # 避免重复
    if (Test-Path $filePath) {
        $fileName = "$slug-$(Get-Random -Maximum 9999).md"
        $filePath = Join-Path $ContentPath $Category $fileName
    }
    
    $fullContent | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "已生成文章: $filePath"
    
    return $fileName
}

# 提交到 GitHub
function Push-ToGitHub {
    param([string[]]$Files)
    
    Push-Location $RepoPath
    
    try {
        git config user.email "bot@nucnas.top"
        git config user.name "NUC NAS Bot"
        
        git add $Files
        git commit -m "Auto publish: $(Get-Date -Format 'yyyy-MM-dd') articles"
        
        # 使用 token 推送
        $remoteUrl = "https://$GithubToken@github.com/nczixun/nucnas-hub.git"
        git remote set-url origin $remoteUrl
        git push origin main
        
        Write-Host "已推送到 GitHub"
    } finally {
        Pop-Location
    }
}

# 主流程
function Main {
    Write-Host "开始生成今日文章..."
    
    $generatedFiles = @()
    
    # 按比例分配到各栏目
    $distribution = @("hardware", "hardware", "nas", "ai") | Get-Random -Count $ArticleCount
    
    foreach ($category in $distribution) {
        $topics = $Categories[$category].Topics
        $topic = $topics | Get-Random
        
        $file = New-Article -Category $category -Topic $topic
        $generatedFiles += "content/$category/$file"
        
        Start-Sleep -Seconds 2  # 避免频率限制
    }
    
    # 推送到 GitHub
    if ($generatedFiles.Count -gt 0) {
        Push-ToGitHub -Files $generatedFiles
    }
    
    Write-Host "完成！共生成 $($generatedFiles.Count) 篇文章"
}

Main
