# NUC NAS Hub - 构建并推送脚本
# 用于定时任务调用

$ErrorActionPreference = "Stop"

$repoDir = "D:\Projects\nucnas-hub"
$message = "Auto publish $(Get-Date -Format 'yyyy-MM-dd HH:mm')"

Write-Host "========================================"
Write-Host "开始构建和推送..."
Write-Host "时间: $(Get-Date)"
Write-Host "========================================"

# 1. 进入目录
Set-Location $repoDir

# 2. Hugo 构建
Write-Host "`n[1/3] 运行 Hugo 构建..."
hugo

if ($LASTEXITCODE -ne 0) {
    Write-Error "Hugo 构建失败！"
    exit 1
}
Write-Host "Hugo 构建成功！"

# 3. Git 添加和提交
Write-Host "`n[2/3] Git 提交..."
git add -A

# 检查是否有更改
$status = git status --porcelain
if (-not $status) {
    Write-Host "没有内容更新，跳过推送"
    exit 0
}

git commit -m $message

# 4. 推送到 GitHub
Write-Host "`n[3/3] 推送到 GitHub..."
git push

if ($LASTEXITCODE -ne 0) {
    Write-Error "Git 推送失败！"
    exit 1
}

Write-Host "========================================"
Write-Host "构建和推送完成！"
Write-Host "========================================"
