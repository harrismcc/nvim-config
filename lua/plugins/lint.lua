return {
  { -- Linting
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim', 'rshkarin/mason-nvim-lint' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Helper to check if a config file exists in project
      local function has_config(patterns)
        return vim.fs.find(patterns, { upward = true, type = 'file' })[1] ~= nil
      end

      local function has_biome()
        return has_config({ 'biome.json', 'biome.jsonc' })
      end

      local function has_eslint()
        return has_config({
          '.eslintrc',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.json',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          'eslint.config.js',
          'eslint.config.mjs',
          'eslint.config.cjs',
        })
      end

      -- Returns the appropriate JS/TS linter based on project config
      local function get_js_linters()
        if has_biome() then
          return { 'biomejs' }
        elseif has_eslint() then
          return { 'eslint_d' }
        end
        return {}
      end

      local js_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        dockerfile = { 'hadolint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if not vim.opt_local.modifiable:get() then
            return
          end

          local ft = vim.bo.filetype
          if vim.tbl_contains(js_filetypes, ft) then
            -- Dynamically determine JS/TS linter based on project config
            lint.try_lint(get_js_linters())
          else
            lint.try_lint()
          end
        end,
      })

      -- Configure mason-nvim-lint
      require('mason-nvim-lint').setup()
    end,
  },
}
