# Nallam Farms Root Deployment Automation Script (PowerShell)
# This script compiles the Flutter web application and deploys it to the root of the gh-pages branch.

$ErrorActionPreference = "Stop"

# Get current branch to restore it at the end
$currentBranch = (git symbolic-ref --short HEAD).Trim()
Write-Host "Current branch detected: $currentBranch" -ForegroundColor Cyan

# Define temporary path outside the repository directory to hold compile outputs
$tempBuildPath = Join-Path (Split-Path -Parent $PSScriptRoot) "temp_nallam_web_build"

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

Write-Host "Step 2: Copying build output to temporary directory..." -ForegroundColor Yellow
if (Test-Path $tempBuildPath) {
    Remove-Item -Path $tempBuildPath -Recurse -Force
}
New-Item -Path $tempBuildPath -ItemType Directory > $null
Copy-Item -Path "$buildWebPath\*" -Destination $tempBuildPath -Recurse -Force

Write-Host "Step 3: Switching to deployment branch (gh-pages)..." -ForegroundColor Yellow
git checkout -f gh-pages

Write-Host "Step 4: Cleaning up old branch contents..." -ForegroundColor Yellow
# Use git to remove all tracked files on the branch
git rm -r -f -q .
# Clean up any leftover untracked files/folders gracefully (ignoring locked folders and the script itself)
Get-ChildItem -Path $PSScriptRoot -Exclude .git, deploy.ps1 | ForEach-Object {
    Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Step 5: Moving compiled files to root..." -ForegroundColor Yellow
Copy-Item -Path "$tempBuildPath\*" -Destination $PSScriptRoot -Recurse -Force

Write-Host "Step 6: Cleaning up temporary directory..." -ForegroundColor Yellow
Remove-Item -Path $tempBuildPath -Recurse -Force

Write-Host "Step 7: Committing deployment updates..." -ForegroundColor Yellow
git add -A
# Allow commit to fail/succeed silently if there are no new changes
git commit -m "Deploy Flutter web app to domain root" -a --allow-empty

Write-Host "Step 8: Restoring original development branch ($currentBranch)..." -ForegroundColor Yellow
git checkout $currentBranch

Write-Host "`nDeployment preparation complete! 🎉" -ForegroundColor Green
Write-Host "You can now push the updates to GitHub using:" -ForegroundColor Green
Write-Host "  git push origin main" -ForegroundColor Yellow
Write-Host "  git push origin gh-pages" -ForegroundColor Yellow
