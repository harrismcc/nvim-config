return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- add any opts here
    provider = 'copilot',

    vendors = {
      r1 = {
        __inherited_from = 'openai',
        api_key_name = 'OPENWEBUI_API_KEY',
        endpoint = 'https://chat.socksmy.rocks/api',
        model = 'deepseek-r1',
      },
      ['o1'] = {
        __inherited_from = 'openai',
        api_key_name = 'OPENWEBUI_API_KEY',
        endpoint = 'https://chat.socksmy.rocks/api',
        model = 'litellm.o1',
      },
      ['o1-mini'] = {
        __inherited_from = 'openai',
        api_key_name = 'OPENWEBUI_API_KEY',
        endpoint = 'https://chat.socksmy.rocks/api',
        model = 'litellm.o1-mini',
      },
      ['4o-mini'] = {
        __inherited_from = 'openai',
        api_key_name = 'OPENWEBUI_API_KEY',
        endpoint = 'https://chat.socksmy.rocks/api',
        model = 'litellm.gpt-4o-mini',
      },
    },

    mappings = {
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
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
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
