-- Autoformat
return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      hcl = { 'packer_fmt' },
      nix = { 'nixfmt' },
      ['javascript'] = { { 'prettierd', 'prettier' } },
      ['javascriptreact'] = { { 'prettierd', 'prettier' } },
      ['typescript'] = { { 'prettierd', 'prettier' } },
      ['typescriptreact'] = { { 'prettierd', 'prettier' } },
      ['vue'] = { { 'prettierd', 'prettier' } },
      ['css'] = { { 'prettierd', 'prettier' } },
      ['scss'] = { { 'prettierd', 'prettier' } },
      ['less'] = { { 'prettierd', 'prettier' } },
      ['html'] = { { 'prettierd', 'prettier' } },
      ['json'] = { { 'prettierd', 'prettier' } },
      ['jsonc'] = { { 'prettierd', 'prettier' } },
      ['yaml'] = { { 'prettierd', 'prettier' } },
      ['markdown'] = { { 'prettierd', 'prettier' } },
      ['markdown.mdx'] = { { 'prettierd', 'prettier' } },
      ['graphql'] = { { 'prettierd', 'prettier' } },
      ['handlebars'] = { { 'prettierd', 'prettier' } },
    },
  },
}
