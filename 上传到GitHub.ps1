# elite20-starter-LH - 自动上传到 GitHub 脚本
# 创建时间: 2026-05-01

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  elite20-starter-LH - 自动上传脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 步骤 0: 检查是否在 GitHub 上创建了仓库
Write-Host "【重要】请确认：" -ForegroundColor Yellow
Write-Host "1. 你已经在 https://github.com/new 创建了仓库" -ForegroundColor Yellow
Write-Host "2. 仓库名称是: elite20-starter-LH" -ForegroundColor Yellow
Write-Host "3. 创建时没有勾选任何初始化选项" -ForegroundColor Yellow
Write-Host ""
$confirmation = Read-Host "确认已创建仓库？(y/n)"
if ($confirmation -ne 'y') {
    Write-Host "请先在 GitHub 上创建仓库，然后重新运行此脚本。" -ForegroundColor Red
    exit
}

# 步骤 1: 创建新目录
Write-Host ""
Write-Host "[1/6] 创建新仓库目录..." -ForegroundColor Green
$basePath = "d:\onenotes\OneDrive\文档\GitHub"
$newRepoPath = Join-Path $basePath "elite20-starter-LH"
$sourcePath = Join-Path $basePath "elite20-starter\students\elite20-starter-LH"

if (-not (Test-Path $newRepoPath)) {
    New-Item -ItemType Directory -Path $newRepoPath -Force | Out-Null
    Write-Host "✓ 目录创建成功: $newRepoPath" -ForegroundColor Green
} else {
    Write-Host "⚠ 目录已存在: $newRepoPath" -ForegroundColor Yellow
}

# 步骤 2: 复制文件
Write-Host ""
Write-Host "[2/6] 复制项目文件..." -ForegroundColor Green
if (Test-Path $sourcePath) {
    Copy-Item -Path "$sourcePath\*" -Destination $newRepoPath -Recurse -Force
    Write-Host "✓ 文件复制成功" -ForegroundColor Green
} else {
    Write-Host "✗ 找不到源文件: $sourcePath" -ForegroundColor Red
    exit
}

# 步骤 3: 初始化 git
Write-Host ""
Write-Host "[3/6] 初始化 Git 仓库..." -ForegroundColor Green
Set-Location $newRepoPath
git init
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Git 初始化成功" -ForegroundColor Green
} else {
    Write-Host "✗ Git 初始化失败" -ForegroundColor Red
    exit
}

# 步骤 4: 添加文件
Write-Host ""
Write-Host "[4/6] 添加文件到 Git..." -ForegroundColor Green
git add .
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 文件添加成功" -ForegroundColor Green
} else {
    Write-Host "✗ 文件添加失败" -ForegroundColor Red
    exit
}

# 步骤 5: 提交
Write-Host ""
Write-Host "[5/6] 提交文件..." -ForegroundColor Green
git commit -m "Initial commit: AI 编程助手 - Elite20 入门项目"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 提交成功" -ForegroundColor Green
} else {
    Write-Host "✗ 提交失败" -ForegroundColor Red
    exit
}

# 步骤 6: 关联远程仓库并推送
Write-Host ""
Write-Host "[6/6] 推送到 GitHub..." -ForegroundColor Green
git remote add origin https://github.com/lihuaok/elite20-starter-LH.git
git branch -M main

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  准备就绪！现在执行推送..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "请执行以下命令完成推送：" -ForegroundColor Yellow
Write-Host ""
Write-Host "cd $newRepoPath" -ForegroundColor White
Write-Host "git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "或者，如果你想让我尝试推送，请告诉我！" -ForegroundColor Cyan
Write-Host ""
Write-Host "📍 你的项目已准备好，位于: $newRepoPath" -ForegroundColor Green

# 打开文件夹
Invoke-Item $newRepoPath
