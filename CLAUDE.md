# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Overview

This is a heavily customized Neovim configuration based on kickstart.nvim, using Lazy.nvim as the plugin manager. The configuration is modular with individual plugin files in `lua/plugins/`.

## Key Architecture

- **Plugin Manager**: Lazy.nvim with lazy loading and event-based loading
- **Core Configuration**: `init.lua` contains basic Neovim settings, keymaps, and Lazy.nvim setup
- **Plugin Structure**: Individual plugin configurations in `lua/plugins/` directory, each returning a Lazy.nvim plugin spec
- **Leader Key**: Space (`<leader>` = `' '`)

## Common Commands

### Plugin Management
- `:Lazy` - Open Lazy.nvim plugin manager UI
- `:Lazy update` - Update all plugins
- `:Mason` - Open Mason LSP/tool installer UI

### LSP and Development
- `:LspInfo` - Show LSP client information
- `:TSInstall <language>` - Install Treesitter parser for language
- Format on save is enabled via conform.nvim

### Package Management
- `pnpm install` - Install Node.js dependencies (has package.json for Claude Code dependency)

## Key Plugins and Their Purpose

### Core Development Tools
- **LSP**: Uses `nvim-lspconfig` with Mason for automatic LSP installation
- **Formatting**: `conform.nvim` with format-on-save for multiple languages (biome, prettier, stylua)
- **Completion**: `nvim-cmp` with various sources
- **Telescope**: Fuzzy finding for files, grep, LSP symbols, etc.
- **Treesitter**: Syntax highlighting and code understanding

### Specialized Tools
- **Avante**: AI-powered coding assistant with multiple LLM providers (Gemini, Claude, DeepSeek, etc.)
- **Harpoon**: Quick file navigation with numbered shortcuts (`<leader>1-6`)
- **TypeScript Tools**: Enhanced TypeScript support via `typescript-tools.nvim`
- **Neo-tree**: File explorer
- **Git Integration**: Gitsigns, gitlinker for GitHub integration

### Key Language Support
- **TypeScript/JavaScript**: Full LSP support, formatting with biome/prettier, enhanced tooling
- **Lua**: Configured for Neovim development with proper LSP settings
- **C/C++**: clangd LSP support
- **Astro**: Full-stack web framework support
- **Nix**: Package manager language support

## Important Keybindings

### Avante (AI Assistant)
- `<leader>cc` - Ask Avante
- `<leader>ce` - Edit with Avante
- `<leader>cp` - Switch Avante provider
- `<leader>ur` - Refresh Avante

### Harpoon (File Navigation)
- `<leader>A` - Add file to harpoon
- `<leader>a` - Open harpoon quick menu
- `<leader>1-5` - Jump to harpoon file 1-5

### Telescope (Search)
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sb` - Search current buffer
- `<leader>sn` - Search Neovim config files
- `<leader><leader>` - Find buffers

### LSP Navigation
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code action
- `<leader>rn` - Rename symbol

## Development Workflow

1. **File Navigation**: Use Harpoon for frequently accessed files, Telescope for searching
2. **Code Editing**: LSP provides completion, diagnostics, and navigation
3. **AI Assistance**: Avante integration with multiple LLM providers for code generation/editing
4. **Formatting**: Automatic formatting on save with language-specific tools
5. **Git Integration**: Built-in git signs and GitHub linking

## Configuration Notes

- Format-on-save is enabled for most file types
- Inlay hints are enabled by default for supported LSPs
- Tab width is set to 2 spaces
- Clipboard integration with system clipboard is enabled
- The config uses MCP (Model Context Protocol) integration via mcphub.nvim for enhanced AI capabilities