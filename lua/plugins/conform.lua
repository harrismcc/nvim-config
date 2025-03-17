-- Autoformat
return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = true,
    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
    formatters = {
      biome = {
        require_cwd = true,
      },
      prettier = {
        require_cwd = true,
      },
      prettierd = {
        require_cwd = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      hcl = { 'packer_fmt' },
      nix = { 'nixfmt' },
      ['javascript'] = { 'biome', 'prettierd', 'prettier', stop_after_first = false },
      ['javascriptreact'] = { 'biome', 'prettierd', 'prettier', stop_after_first = false },
      ['typescript'] = { 'biome', 'prettierd', 'prettier', stop_after_first = false },
      ['typescriptreact'] = { 'biome', 'prettierd', 'prettier', stop_after_first = false },
      ['astro'] = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      ['vue'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['css'] = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      ['scss'] = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      ['less'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['html'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['json'] = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      ['jsonc'] = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      ['yaml'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['markdown'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['graphql'] = { 'prettierd', 'prettier', stop_after_first = true },
      ['handlebars'] = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
