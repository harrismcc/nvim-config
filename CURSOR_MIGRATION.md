# Neovim to Cursor Keybinding Migration

This document explains the keybinding migration from your Neovim configuration to Cursor.

## Generated Files

- `cursor-settings.json` - Contains all your Neovim keybindings converted to Cursor/VSCode format

## How to Use

1. Open Cursor
2. Open Settings (Cmd+, on Mac, Ctrl+, on Windows/Linux)
3. Click the "Open Settings (JSON)" icon in the top right
4. Copy the contents of `cursor-settings.json` into your Cursor `settings.json` file
5. You may need to merge with existing settings if you already have some configured

## Keybinding Mappings

### Basic Navigation
- `<leader>/` → Find in Files (fuzzy search in current buffer equivalent)
- `<C-h/j/k/l>` → Window navigation (focus left/right/below/above)

### Diagnostics
- `[d` → Previous diagnostic/error
- `]d` → Next diagnostic/error
- `<leader>q` → Open Problems panel

### File Explorer
- `<leader>e` → Toggle sidebar (Neo-tree equivalent)

### Telescope (Search)
- `<leader>sf` → Quick Open (file search)
- `<leader>sg` → Find in Files (live grep)
- `<leader>sb` → Find in Files (buffer search)
- `<leader>sh` → Show Commands
- `<leader>sk` → Open Keybindings
- `<leader>sd` → Problems panel
- `<leader>sr` → Find in Files (resume)
- `<leader>s.` → Open Recent
- `<leader>sn` → Quick Open (Neovim config search)
- `<leader><leader>` → Show All Editors (buffer list)

### LSP Navigation
- `gd` → Go to Definition
- `gr` → Go to References
- `gI` → Go to Implementation
- `gD` → Go to Declaration
- `K` → Show Hover
- `<leader>D` → Go to Type Definition
- `<leader>ds` → Go to Symbol in Document
- `<leader>ws` → Show All Symbols (workspace)
- `<leader>rn` → Rename Symbol
- `<leader>ca` → Quick Fix (code action)
- `<leader>uh` → Toggle Inline Hints

### Harpoon (File Navigation)
Note: Cursor doesn't have exact equivalents for Harpoon's file marking system. These mappings use editor group commands as approximations:
- `<leader>A` → Add Editor to Next Group
- `<leader>a` → Show All Editors
- `<leader>1-5` → Open Editor at Index 1-5

### Git (Gitsigns)
- `]h` → Next Change
- `[h` → Previous Change
- `<leader>ghs` → Stage (hunk)
- `<leader>ghr` → Revert Selected Ranges
- `<leader>ghS` → Stage All
- `<leader>ghu` → Unstage
- `<leader>ghR` → Revert All
- `<leader>ghp` → Next Change (preview)
- `<leader>ghb` → Toggle Blame
- `<leader>ghd` → Open Change
- `<leader>ghD` → Open Change

### Debug (DAP)
- `<leader>db` → Toggle Breakpoint
- `<leader>dc` → Start Debugging
- `<leader>di` → Step Into
- `<leader>do` → Step Over
- `<leader>dO` → Step Out
- `<leader>dr` → Toggle REPL
- `<leader>dl` → Restart Debugging
- `<leader>du` → Toggle REPL
- `<leader>dk` → Stop Debugging

### Persistence (Sessions)
- `<leader>qs` → Save Workspace As
- `<leader>ql` → Open Workspace
- `<leader>qd` → Close Workspace

### File Operations
- `<leader>by` → Copy File Path (may need custom command)

### Avante (AI Assistant)
Note: These use Cursor's built-in chat commands. You may need to adjust based on Cursor's actual AI command IDs:
- `<leader>cc` → Open Chat
- `<leader>ce` → Open Chat
- `<leader>cp` → Open Chat
- `<leader>ur` → Refresh Chat

### Insert Mode (Completion)
- `<C-n>` → Select Next Suggestion
- `<C-p>` → Select Previous Suggestion
- `<Tab>` → Accept Selected Suggestion
- `<C-Space>` → Trigger Suggestions
- `<C-l>` → Accept Next Word (inline suggest)
- `<C-h>` → Accept Previous Word (inline suggest)

### Visual Mode
- `<leader>ghs` → Stage Selected Ranges
- `<leader>ghr` → Revert Selected Ranges

## Notes and Limitations

1. **Command IDs**: Some command IDs may need adjustment. Cursor uses VSCode's command system, but some commands might have different IDs. You can discover available commands by:
   - Opening Command Palette (Cmd+Shift+P)
   - Running "Preferences: Open Keyboard Shortcuts (JSON)"
   - Checking what commands are available

2. **Harpoon**: Cursor doesn't have a direct equivalent to Harpoon's file marking system. The mappings provided are approximations using editor groups.

3. **Avante**: The AI assistant keybindings use generic chat commands. You may need to find Cursor-specific AI command IDs.

4. **Git Commands**: Some git commands might need the Git extension to be installed and may have slightly different command IDs.

5. **File Path Yank**: The `copyFilePath` command might need to be a custom command or extension.

6. **Missing Keybindings**: Some Neovim-specific features don't have direct equivalents:
   - Comment toggling (gc) - Cursor has built-in comment toggling with Cmd+/ or Ctrl+/
   - Flash navigation - No direct equivalent
   - Mini.surround - No direct equivalent

## Testing Your Keybindings

After adding the settings:

1. Test each keybinding to ensure it works as expected
2. If a keybinding doesn't work, check the Command Palette for the correct command ID
3. Some commands may require extensions to be installed
4. Adjust command IDs as needed based on what's actually available in Cursor

## Custom Commands

If you need custom commands (like the file path yank), you may need to:
1. Install a VSCode extension that provides the command
2. Create a custom extension
3. Use a different command that achieves the same result

## Leader Key

The leader key is set to `<space>` (spacebar), matching your Neovim configuration.




