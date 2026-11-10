#!/bin/bash

# 1. Define plugin metadata and parse version automatically from package.json
NAME="table-to-markdown-converter"
VERSION=$(awk -F'"' '/"version":/ {print $4}' package.json)
TARGET_FILE="${NAME}-${VERSION}.vsix"

echo "Starting extension build process for macOS/Linux..."
echo "Detected extension version: ${VERSION}"

# Remove old build file if exists to prevent conflicts
if [ -f "$TARGET_FILE" ]; then
    echo "Removing old build: $TARGET_FILE"
    rm "$TARGET_FILE"
fi

# 2. Create mandatory temporary structure folder
mkdir -p ./extension

# 3. Copy extension assets
cp package.json extension.js logo.png ./extension/

# 4. Modify README.md for the local VSIX package (remove logo and update install section)
echo "Optimizing README.md for local installation..."
sed -E '/<img src=.*alt="Table to Markdown Logo"/d; /<p align="center">/,/<\/p>/d' README.md > ./extension/README.md

# Append repository link for updates to the modified README
echo -e "\n\n## Updates and Support\nSince this extension is installed manually, it does not support automatic updates. Please check the official repository for the latest versions: [GitHub Repository](https://github.com/atelit/table-to-markdown-converter)" >> ./extension/README.md

# 5. Zip the archive properly with 'extension' as the root folder
zip -q -r ./plugin.zip ./extension

# 6. Rename to VS Code extension format and clean up
mv ./plugin.zip "$TARGET_FILE"
rm -rf ./extension

echo "Build successful! Extension package created: $TARGET_FILE"
