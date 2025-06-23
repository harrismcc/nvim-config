return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- The default provider to use
      provider = 'gemini-2.5-pro',
      mode = 'agentic',

      behaviour = {
        auto_apply_diff_after_generation = true,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },

      auto_approve = true,

      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub_ok, hub = pcall(require, 'mcphub')
        if not hub_ok or not hub then
          return ''
        end
        local current_hub = hub.get_hub_instance and hub.get_hub_instance()
        return current_hub and current_hub.get_active_servers_prompt and current_hub:get_active_servers_prompt() or ''
      end,

      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = (function()
        local hub_ok, hub = pcall(require, 'mcphub')
        if not hub_ok or not hub then
          return {}
        end
        local avante_ext_ok, avante_ext = pcall(require, 'mcphub.extensions.avante')
        if not avante_ext_ok or not avante_ext then
          return {}
        end
        local tool = avante_ext.mcp_tool and avante_ext.mcp_tool()
        return tool and { tool } or {}
      end)(),

      vendors = {
        ['claude-3.7-sonnet'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'anthropic/claude-3.7-sonnet',
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
        ['o4-mini-high'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'openai/o4-mini',
          max_tokens = 8192,
        },
        ['gemini-2.5-pro'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'google/gemini-2.5-pro-preview',
          max_tokens = 800000,
        },
        ['deepseek-v3'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'deepseek/deepseek-chat-v3-0324',
          -- max_tokens = 800000,
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
      {
        'ravitemer/mcphub.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
        build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
        config = function()
          require('mcphub').setup()
        end,
      },
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
  },
}
