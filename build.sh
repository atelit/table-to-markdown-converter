#!/bin/bash

NAME="table-to-markdown-converter"
VERSION=$(awk -F'"' '/"version":/ {print $4}' package.json)
TARGET_FILE="${NAME}-${VERSION}.vsix"

echo "Starting extension build process for macOS/Linux..."
echo "Detected extension version: ${VERSION}"

# REMOVE OLD FILE IF EXISTS TO PREVENT ERRORS
if [ -f "$TARGET_FILE" ]; then
    echo "Removing old build: $TARGET_FILE"
    rm "$TARGET_FILE"
fi

mkdir -p ./extension
cp package.json extension.js README.md logo.png ./extension/
zip -q -r ./plugin.zip ./extension
mv ./plugin.zip "$TARGET_FILE"
rm -rf ./extension

echo "Build successful! Extension package created: $TARGET_FILE"
