local util = require 'lspconfig.util'

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
    }
  end,
  opts = {
    settings = {
      code_lens = 'off',
      complete_function_calls = true,
      include_completions_with_insert_text = true,
      separate_diagnostic_server = true,
      publish_diagnostic_on = 'insert_leave',
      tsserver_path = nil,
      tsserver_max_memory = 20000,
      tsserver_format_options = {},
      tsserver_file_preferences = {
        completions = { completeFunctionCalls = true },
        init_options = { preferences = { disableSuggestions = true } },
        importModuleSpecifierPreference = 'project-relative',
        jsxAttributeCompletionStyle = 'braces',
      },
      tsserver_locale = 'en',
      disable_member_code_lens = true,
    },
    root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
  },
}
