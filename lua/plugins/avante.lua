return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- The default provider to use
    provider = 'gemini-pro',

    -- The provider to use when applying the cursor diff
    cursor_applying_provider = 'llama-3.3-70b',
    behaviour = {
      auto_apply_diff_after_generation = true,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },

    vendors = {
      ['claude-3.7-sonnet'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'anthropic/claude-3.7-sonnet',
        max_tokens = 8192,
      },
      -- Used for the cursor planning mode
      ['llama-3.3-70b'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'meta-llama/llama-3.3-70b-instruct:nitro',
        max_tokens = 8192,
      },
      r1 = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'deepseek/deepseek-r1:nitro',
        disable_tools = true,
        max_tokens = 8192,
      },
      ['o1-mini'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'openai/o1-mini',
        max_tokens = 8192,
      },
      ['gemini-flash-2.0-thinking'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'google/gemini-2.0-flash-thinking-exp:free',
        disable_tools = true,
        max_tokens = 8192,
      },
      ['gemini-pro'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'google/gemini-2.0-pro-exp-02-05:free',
        max_tokens = 8192,
      },
    },

    web_search_engine = {
      provider = 'tavily', -- tavily, serpapi or google
    },

    mappings = {
      diff = {
        all_theirs = 'cT',
      },
      ask = '<leader>cc', -- ask
      edit = '<leader>ce', -- edit
      refresh = '<leader>ur', -- refresh
      switch_provider = '<leader>cp', -- new provider switch mapping
      sidebar = {
        apply_all = 'Z',
        apply_cursor = 'a',
        switch_windows = '<Tab>',
        reverse_switch_windows = '<S-Tab>',
      },
      submit = {
        normal = '<CR>',
        insert = '<CR>',
      },
    },
  },
  keys = function(_, keys)
    ---@type avante.Config
    local opts = require('lazy.core.plugin').values(require('lazy.core.config').spec.plugins['avante.nvim'], 'opts', false)
    local mappings = {
      {
        opts.mappings.switch_provider,
        function()
          local providers = vim.tbl_keys(opts.vendors)
          table.insert(providers, 1, opts.provider)
          require('telescope.pickers')
            .new({
              prompt_title = 'Avante Providers',
              finder = require('telescope.finders').new_table {
                results = providers,
              },
              sorter = require('telescope.config').values.generic_sorter {},
              layout_config = {
                width = 0.4, -- 40% of the screen width
                height = 0.4, -- 40% of the screen height
              },
              attach_mappings = function(_, map)
                map('i', '<CR>', function(prompt_bufnr)
                  local selection = require('telescope.actions.state').get_selected_entry()
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd.AvanteSwitchProvider(selection.value)
                end)
                return true
              end,
            })
            :find()
        end,
        desc = 'avante: switch provider',
      },
      {
        opts.mappings.ask,
        function()
          require('avante.api').ask()
        end,
        desc = 'avante: ask',
        mode = { 'n', 'v' },
      },
      {
        opts.mappings.refresh,
        function()
          require('avante.api').refresh()
        end,
        desc = 'avante: refresh',
        mode = 'v',
      },
      {
        opts.mappings.edit,
        function()
          require('avante.api').edit()
        end,
        desc = 'avante: edit',
        mode = { 'n', 'v' },
      },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
