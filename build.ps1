# 1. Define plugin metadata and parse version automatically from package.json
$Name = "table-to-markdown-converter"
$PackageJson = Get-Content -Raw -Path ".\package.json" | ConvertFrom-Json
$Version = $PackageJson.version
$TargetFile = "${Name}-${Version}.vsix"

Write-Host "Starting extension build process for Windows..." -ForegroundColor Cyan
Write-Host "Detected extension version: ${Version}"

# Remove old file if exists to prevent errors
if (Test-Path $TargetFile) {
    Write-Host "Removing old build: $TargetFile" -ForegroundColor Yellow
    Remove-Item -Force $TargetFile
}

# 2. Create a mandatory temporary structure folder
New-Item -ItemType Directory -Force -Path ".\extension" | Out-Null

# 3. Copy extension assets
Copy-Item "package.json", "extension.js", "logo.png" -Destination ".\extension"

# 4. Modify README.md for the local VSIX package
Write-Host "Optimizing README.md for local installation..." -ForegroundColor Cyan
$ReadmeContent = Get-Content -Path ".\README.md" -Raw
# Strip the HTML logo container
$CleanReadme = $ReadmeContent -replace '(?s)<p align="center">.*?</p>', ''
$CleanReadme = $CleanReadme + "`n`n## Updates and Support`nSince this extension is installed manually, it does not support automatic updates. Please check the official repository for the latest versions: [GitHub Repository](https://github.com/atelit/table-to-markdown-converter)"
Set-Content -Path ".\extension\README.md" -Value $CleanReadme

# 5. Zip the archive
Compress-Archive -Path ".\extension" -DestinationPath ".\plugin.zip" -Force

# 6. Rename to VS Code extension format and clean up
Rename-Item -Path ".\plugin.zip" -NewName $TargetFile -Force
Remove-Item -Recurse -Force ".\extension"

Write-Host "Build successful! Extension package created: $TargetFile" -ForegroundColor Green
