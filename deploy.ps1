# Nallam Farms Root Deployment Automation Script (PowerShell)
# This script compiles the Flutter web application and deploys it directly to the root of the main branch for Vercel hosting.

$ErrorActionPreference = "Stop"

# Get current branch to restore/verify
$currentBranch = (git symbolic-ref --short HEAD).Trim()
Write-Host "Current branch detected: $currentBranch" -ForegroundColor Cyan

if ($currentBranch -ne "main") {
    Write-Error "Deployment must be run from the main branch. Aborting."
}

Write-Host "Step 1: Compiling Flutter web application..." -ForegroundColor Yellow
cd textiles_app
fvm flutter clean
fvm flutter build web --release
cd ..

# Verify build output exists
$buildWebPath = Join-Path $PSScriptRoot "textiles_app\build\web"
if (-not (Test-Path $buildWebPath)) {
    Write-Error "Flutter web build output not found at $buildWebPath. Aborting."
}

Write-Host "Step 2: Cleaning old compiled files from root..." -ForegroundColor Yellow
$compiledItems = @("index.html", "flutter.js", "flutter_bootstrap.js", "flutter_service_worker.js", "main.dart.js", "version.json", "assets", "canvaskit", "farms", ".last_build_id")
foreach ($item in $compiledItems) {
    $destPath = Join-Path $PSScriptRoot $item
    if (Test-Path $destPath) {
        Remove-Item -Path $destPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Step 3: Copying new compiled files to root..." -ForegroundColor Yellow
Copy-Item -Path "$buildWebPath\*" -Destination $PSScriptRoot -Recurse -Force

Write-Host "Step 4: Committing deployment updates..." -ForegroundColor Yellow
git add -A
# Allow commit to fail/succeed silently if there are no new changes
git commit -m "Deploy compiled Flutter web app to domain root on main" -a --allow-empty

Write-Host "Step 5: Pushing updates to GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host "`nDeployment complete! 🎉 Vercel will now deploy the update." -ForegroundColor Green
