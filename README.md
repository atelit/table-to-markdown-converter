![Table to Markdown Logo](logo.png)

# Table to Markdown

A lightweight and secure VS Code extension that converts tables between text (for example, Confluence (TSV)) and Markdown formats in both directions with a single hotkey or click.

## Features

- **Smart Toggle**: A single intelligent command that detects the context and either converts text to Markdown or reverts Markdown back to tab-separated text.
- **Auto-Alignment**: Automatically detects and fixes missing cells if rows have mismatched column counts.
- **100% Offline & Secure**: No external dependencies, no server requests. Your data never leaves your machine.

## How to Use

1. **Select** the table text in your editor.
2. Press your platform's hotkey (or right-click and choose `Convert / Revert Table Format`).
3. The extension will automatically choose whether to convert or revert based on your selection!

## Keyboard Shortcuts (Keybindings)

| Command | Windows / Linux | macOS | Description |
| :--- | :--- | :--- | :--- |
| **Convert / Revert Table Format** | `Alt + Shift + M` | `Option (⌥) + Shift + M` | Toggles table format back and forth |

## Installation

Since this is a custom secure extension, you can install it manually in less than a minute:

### For Windows
1. Copy the extension folder containing `package.json`, `extension.js`, `logo.png`, and this `README.md`.
2. Paste it into your VS Code extensions directory:
   `C:\Users\<Your_Username>\.vscode\extensions\`
3. Restart VS Code.

### For macOS / Linux
1. Copy the extension folder containing `package.json`, `extension.js`, `logo.png`, and this `README.md`.
2. Paste it into your VS Code extensions directory:
   `~/.vscode/extensions/`
3. Restart VS Code.

## Packaging into `.vsix` (No Node.js / npm required)

If you want to share this extension with your team as a single installable file, you can package it entirely using the native build scripts included in this repository.

### Option A: For Windows (PowerShell)
1. Open PowerShell in the project root folder.
2. Run the build script:
   ```powershell
   .\build.ps1
   ```

### Option B: For macOS / Linux (Terminal)
1. Open Terminal in the project root folder.
2. Run the build script:
   ```bash
   ./build.sh
   ```

### Installing the Generated `.vsix` File
1. Open VS Code and navigate to the **Extensions** tab on the left sidebar (`Ctrl + Shift + X` / `Cmd + Shift + X`).
2. Click on the **`...`** (three dots) icon at the very top right corner of the Extensions panel.
3. Select **Install from VSIX...** from the dropdown menu.
4. Locate and select the generated `.vsix` file.
5. The extension is now successfully installed and ready to use team-wide!

## Extension Settings

This extension contributes the following command:

* `table-to-markdown.toggle`: Smart toggle between Text and Markdown format.

## License

MIT