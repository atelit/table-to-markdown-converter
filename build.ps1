$Name = "table-to-markdown-converter"
$PackageJson = Get-Content -Raw -Path ".\package.json" | ConvertFrom-Json
$Version = $PackageJson.version
$TargetFile = "${Name}-${VERSION}.vsix"

Write-Host "Starting extension build process for Windows..." -ForegroundColor Cyan
Write-Host "Detected extension version: ${Version}"

# REMOVE OLD FILE IF EXISTS TO PREVENT ERRORS
if (Test-Path $TargetFile) {
    Write-Host "Removing old build: $TargetFile" -ForegroundColor Yellow
    Remove-Item -Force $TargetFile
}

New-Item -ItemType Directory -Force -Path ".\extension" | Out-Null
Copy-Item "package.json", "extension.js", "README.md", "logo.png" -Destination ".\extension"
Compress-Archive -Path ".\extension" -DestinationPath ".\plugin.zip" -Force
Rename-Item -Path ".\plugin.zip" -NewName $TargetFile -Force
Remove-Item -Recurse -Force ".\extension"

Write-Host "Build successful! Extension package created: $TargetFile" -ForegroundColor Green
