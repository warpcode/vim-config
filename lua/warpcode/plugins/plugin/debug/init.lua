local p = require('warpcode.utils.keymap-actions')
-- Shows how to use the DAP plugin to debug your code.
return {
  {
    'mfussenegger/nvim-dap',
    -- Default is 50 and this should load after the autocomplete plugins because of mason
    priority = 10,
    dependencies = {
      -- Creates a beautiful debugger UI
      {
        'rcarriga/nvim-dap-ui',
        dependencies = {
          'nvim-neotest/nvim-nio',
        },
      },

      -- Installs the debug adapters for you
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      -- 'leoluz/nvim-dap-go',

      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      --
      require('mason-nvim-dap').setup({
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          'php',
        },
      })

      --
      -- -- Basic debugging keymaps, feel free to change to your liking!

      p.addCall('debug.breakpoint_toggle', dap.toggle_breakpoint, 10)
      p.addCall('debug.breakpoint_conditional', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, 10)
      p.addCall('debug.continue', dap.continue, 10)
      p.addCall('debug.terminate', dap.terminate, 10)
      p.addCall('debug.step_over', dap.step_over, 10)
      p.addCall('debug.step_into', dap.step_into, 10)
      p.addCall('debug.step_out', dap.step_out, 10)

      dap.configurations.php = {
        {
          name = 'Listen for Martini xdebug',
          type = 'php',
          request = 'launch',
          port = '9003',
          log = true,
          pathMappings = {
            ['/var/www/html/martini-git'] = '${workspaceFolder}',
          },
        },
        {
          name = 'Listen for xdebug',
          type = 'php',
          request = 'launch',
          port = '9003',
          log = true,
        },
        {
          name = 'Launch currently open script',
          type = 'php',
          request = 'launch',
          program = '${file}',
          cwd = '${fileDirname}',
          port = 0,
          runtimeArgs = {
            '-dxdebug.start_with_request=yes',
          },
          env = {
            XDEBUG_MODE = 'debug,develop',
            XDEBUG_CONFIG = 'client_port=${port}',
          },
        },
        {
          name = 'Launch Built-in web server',
          type = 'php',
          request = 'launch',
          runtimeArgs = {
            '-dxdebug.mode=debug',
            '-dxdebug.start_with_request=yes',
            '-S',
            'localhost:0',
          },
          program = '',
          cwd = '${workspaceRoot}',
          port = 9003,
          serverReadyAction = {
            pattern = 'Development Server \\(http://localhost:([0-9]+)\\) started',
            uriFormat = 'http://localhost:%s',
            action = 'openExternally',
          },
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({
        layouts = {
          {
            elements = {
              {
                id = 'scopes',
                size = 0.70,
              },
              {
                id = 'breakpoints',
                size = 0.10,
              },
              {
                id = 'stacks',
                size = 0.20,
              },
            },
            position = 'left',
            size = 50,
          },
          {
            elements = {
              {
                id = 'repl',
                size = 1,
              },
            },
            position = 'bottom',
            size = 10,
          },
        },
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      })
      --
      -- -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      -- vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
      --
      -- -- Install golang specific config
      -- require('dap-go').setup()
      require('nvim-dap-virtual-text').setup({})
    end,
  },
  {
    'vim-test/vim-test',
    config = function()
      vim.g['test#neovim#start_normal'] = 1
    end,
  },
}
