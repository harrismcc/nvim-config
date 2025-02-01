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
      ['javascript'] = { { 'biome', 'prettierd', 'prettier' } },
      ['javascriptreact'] = { { 'biome', 'prettierd', 'prettier' } },
      ['typescript'] = { { 'biome', 'prettierd', 'prettier' } },
      ['typescriptreact'] = { { 'biome', 'prettierd', 'prettier' } },
      ['astro'] = { { 'biome', 'prettierd', 'prettier' } },
      ['vue'] = { { 'prettierd', 'prettier' } },
      ['css'] = { { 'biome', 'prettierd', 'prettier' } },
      ['scss'] = { { 'biome', 'prettierd', 'prettier' } },
      ['less'] = { { 'prettierd', 'prettier' } },
      ['html'] = { { 'prettierd', 'prettier' } },
      ['json'] = { { 'biome', 'prettierd', 'prettier' } },
      ['jsonc'] = { { 'biome', 'prettierd', 'prettier' } },
      ['yaml'] = { { 'prettierd', 'prettier' } },
      ['markdown'] = { { 'prettierd', 'prettier' } },
      ['mdx'] = { { 'prettierd', 'prettier' } },
      ['graphql'] = { { 'prettierd', 'prettier' } },
      ['handlebars'] = { { 'prettierd', 'prettier' } },
    },
  },
}
