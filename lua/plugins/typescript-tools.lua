return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr })
        end
      end,
      settings = {
        vtsls = {
          experimental = {
            completion = {
              -- Enables experimental completion support, which should improve completion performance
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        tsserver_file_preferences = {
          -- Inlay Hints
          includeInlayParameterNameHints = 'none',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    }
  end,
}
