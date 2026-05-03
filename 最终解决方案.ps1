# ========================================
# elite20-starter-LH - 最终推送解决方案
# ========================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  elite20-starter-LH - 推送脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "【步骤 1/2: 准备本地仓库..." -ForegroundColor Yellow
Write-Host ""

# 创建临时目录
$tempPath = "d:\onenotes\OneDrive\文档\GitHub\elite20-starter-LH-final"
$sourcePath = "d:\onenotes\OneDrive\文档\GitHub\elite20-starter\students\elite20-starter-LH"

# 清理旧目录
if (Test-Path $tempPath) {
    Remove-Item $tempPath -Recurse -Force
}

# 创建新目录
New-Item -ItemType Directory -Path $tempPath -Force | Out-Null

# 复制文件
Copy-Item -Path "$sourcePath\*" -Destination $tempPath -Recurse -Force
Write-Host "✓ 文件已复制" -ForegroundColor Green

# 进入目录
Set-Location $tempPath

# 初始化 git
git init
git add .
git commit -m "Initial commit: AI 编程助手 - Elite20 入门项目"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  本地仓库准备就绪！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "【步骤 2/2: 现在请在 PowerShell 中执行以下命令：】" -ForegroundColor Yellow
Write-Host ""
Write-Host "cd $tempPath" -ForegroundColor White
Write-Host "git remote add origin https://github.com/lihuaok/elite20-starter-LH.git" -ForegroundColor White
Write-Host "git branch -M main" -ForegroundColor White
Write-Host "git push -f -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "或者，你可以直接复制这 4 行，一次性粘贴执行！" -ForegroundColor Green
Write-Host ""

# 打开文件夹
Invoke-Item $tempPath
