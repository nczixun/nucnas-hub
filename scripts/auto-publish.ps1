# NUC NAS Hub - 自动发布脚本
# 1. 生成内容 2. 构建Hugo 3. 推送到GitHub

param(
    [int]$ArticleCount = 3
)

$ErrorActionPreference = "Stop"

$ProjectDir = "D:\Projects\nucnas-hub"

Write-Host "========================================="
Write-Host "NUC NAS Hub 自动发布流程"
Write-Host "========================================="

# 1. 生成内容
Write-Host "`n[1/4] 生成内容..."
& "$ProjectDir\scripts\generate-content.ps1" -Count $ArticleCount

# 2. Git提交
Write-Host "`n[2/4] Git提交..."
Set-Location $ProjectDir
git add -A
git commit -m "auto: 生成新内容 $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>$null

# 3. 推送到GitHub
Write-Host "`n[3/4] 推送到GitHub..."
git push

# 4. 等待Cloudflare构建
Write-Host "`n[4/4] 发布完成！"
Write-Host "网站将在几分钟后更新: https://www.nucnas.top"
Write-Host "========================================="
