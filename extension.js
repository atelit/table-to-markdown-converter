const vscode = require('vscode');

function activate(context) {
    let disposable = vscode.commands.registerCommand('table-to-markdown.toggle', function () {
        const editor = vscode.window.activeTextEditor;
        if (!editor) return;

        const selection = editor.selection;
        const text = editor.document.getText(selection);
        if (!text.trim()) {
            vscode.window.showInformationMessage('Select text before converting!');
            return;
        }

        // Check for Markdown table dividers: for example | --- | or |--|
        const hasMarkdownTableDividers = /\| ?--- ?\|/.test(text) || /\|-+\|/.test(text);

        // Mode 1: If this is a Markdown table -> revert to Confluence text
        if (text.includes('|') && hasMarkdownTableDividers) {
            const lines = text.trim().split('\n').filter(line => line.trim());
            let finalRows = [];

            lines.forEach(line => {
                if (line.includes('---')) return; // skip the divider line with dashes
                const cleanLine = line.replace(/^\|/, '').replace(/\|$/, '');
                const cells = cleanLine.split('|').map(cell => cell.trim());
                finalRows.push(cells.join('\t'));
            });

            editor.edit(editBuilder => editBuilder.replace(selection, finalRows.join('\n')));
        } 
        // Mode 2: Otherwise this is regular Confluence text -> convert to Markdown
       else {
            const lines = text.trim().split('\n').filter(line => line.trim());
            const rows = lines.map(line => line.split('\t').map(cell => cell.trim()));
            if (rows.length === 0) return;

            const maxCols = Math.max(...rows.map(row => row.length));
            rows.forEach(row => { while (row.length < maxCols) row.push(''); });

            let result = [];
            result.push(`| ${rows[0].join(' | ')} |`); // Headers
            result.push(`| ${Array(maxCols).fill('---').join(' | ')} |`); // Required block
            
            for (let i = 1; i < rows.length; i++) {
                result.push(`| ${rows[i].join(' | ')} |`); // Data
            }

            editor.edit(editBuilder => editBuilder.replace(selection, result.join('\n')));
        }
    });

    context.subscriptions.push(disposable);
}

function deactivate() {}

module.exports = { activate, deactivate };
