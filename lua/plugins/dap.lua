-- Debug Adapter Protocol client implementation for Neovim
-- See: https://github.com/mfussenegger/nvim-dap
return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    -- Creates a beautiful UI for nvim-dap
    -- See: https://github.com/rcarriga/nvim-dap-ui
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
      config = function()
        local dapui = require 'dapui'
        dapui.setup {
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
              },
              size = 40,
              position = 'left',
            },
            {
              elements = {
                { id = 'repl', size = 0.5 },
                { id = 'console', size = 0.5 },
              },
              size = 0.25,
              position = 'bottom',
            },
          },
        }

        local dap = require 'dap'
        -- Automatically open/close dap-ui when debugging starts/stops
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close()
        end
      end,
    },

    -- Bridge between mason.nvim and nvim-dap
    -- See: https://github.com/jay-babu/mason-nvim-dap.nvim
    -- Mason must be available for this plugin to work
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
      -- Load after nvim-dap
      opts = {
        -- Tells mason-nvim-dap where dap is set up
        -- dap_configuration_file = vim.fn.stdpath('config') .. '/lua/plugins/dap.lua', -- Adjust if needed
        -- Automatically install configured adapters
        automatic_installation = true,
        -- Provide handlers for setting up adapters, e.g.:
        handlers = {},
        -- Ensure adapters are installed. Will be merged with mason.nvim's ensure_installed
        ensure_installed = {
          -- Add the debug adapters you need here, e.g.:
          'js-debug-adapter',
          -- 'python-debugpy',
        },
      },
    },

    -- Virtual text for debugging info
    -- See: https://github.com/theHamsta/nvim-dap-virtual-text
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {}, -- Use default configuration
    },
  },
  config = function()
    -- Ensure mason-nvim-dap is setup BEFORE defining configurations
    require('mason-nvim-dap').setup() -- Use opts defined in the plugin spec above

    local dap = require 'dap'

    -- Keymaps
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step O[u]t' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Toggle [R]EPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run [L]ast' })
    vim.keymap.set('n', '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', { desc = 'Toggle [U]I' })
    vim.keymap.set('n', '<leader>dk', dap.terminate, { desc = 'Terminate ([K]ill)' })

    -- Register with which-key
    -- The '<leader>d' group should already be registered in init.lua
    require('which-key').register {
      ['<leader>d'] = {
        name = '[D]ebug',
        b = { dap.toggle_breakpoint, '[B]reakpoint' },
        c = { dap.continue, '[C]ontinue' },
        i = { dap.step_into, 'Step [I]nto' },
        o = { dap.step_over, 'Step [O]ver' },
        O = { dap.step_out, 'Step O[u]t' },
        r = { dap.repl.toggle, '[R]EPL' },
        l = { dap.run_last, 'Run [L]ast' },
        u = { '<cmd>lua require("dapui").toggle()<CR>', 'Toggle [U]I' },
        k = { dap.terminate, 'Terminate ([K]ill)' },
      },
    }

    -- Configure js-debug-adapter
    -- Assumes mason-nvim-dap correctly sets up the 'pwa-node' adapter type
    -- See: https://github.com/microsoft/vscode-js-debug
    -- For config options, see: https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
    local node_dap_configs = {
      type = 'pwa-node', -- Adapter type provided by mason-nvim-dap for js-debug-adapter
      request = 'launch',
      name = 'Launch file (Node)', -- Updated name for clarity
      program = '${file}', -- Launch the current file
      cwd = '${workspaceFolder}', -- Run in the project root
      runtimeExecutable = 'node',
      runtimeArgs = { '--nolazy' },
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal', -- Show output in the integrated terminal
      resolveSourceMapLocations = {
        '${workspaceFolder}/**',
        '!**/node_modules/**',
      },
    }

    -- Create a separate config for Bun by copying the Node config and changing the runtime
    local bun_dap_configs = vim.deepcopy(node_dap_configs) -- Deep copy to avoid modifying the original
    bun_dap_configs.name = 'Launch file (Bun)'
    bun_dap_configs.runtimeExecutable = 'bun'
    -- Bun might not need/support the same runtimeArgs, adjust if necessary
    -- bun_dap_configs.runtimeArgs = {} -- Example: remove args if Bun doesn't need them

    -- Assign both configurations to the relevant filetypes
    -- When starting debugging, DAP will ask which configuration to use
    dap.configurations.javascript = { node_dap_configs, bun_dap_configs }
    dap.configurations.typescript = { node_dap_configs, bun_dap_configs }
    dap.configurations.javascriptreact = { node_dap_configs, bun_dap_configs }
    dap.configurations.typescriptreact = { node_dap_configs, bun_dap_configs }

    print 'nvim-dap configured with Node and Bun support!'
  end,
}
