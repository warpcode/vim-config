local p = require('warpcode.utils.keymap-actions')

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    -- { 'nvim-telescope/telescope-dap.nvim' },
    {
      'aznhe21/actions-preview.nvim',
      config = function()
        -- LSP
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('warpcode-lsp-attach-actions-preview', { clear = true }),
          callback = function(event)
            p.addCall('lsp.code_action', require('actions-preview').code_actions, 20, event.buf, event, event.id)
          end,
        })
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    -- local previewers = require "telescope.previewers"
    -- local sorters = require "telescope.sorters"
    -- local conf = require('telescope.config').values
    -- local finders = require('telescope.finders')
    -- local pickers = require('telescope.pickers')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<C-h>'] = 'which_key',
            ['<ESC>'] = actions.close,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'dap')

    -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    --     -- vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
    --     -- -- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
    --     -- vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
    --
    --     -- diagnostics overrides

    -- -- Slightly advanced example of overriding default behavior and theme
    -- vim.keymap.set('n', '<leader>/', function()
    --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    --     winblend = 10,
    --     previewer = false,
    --   })
    -- end, { desc = '[/] Fuzzily search in current buffer' })
    --
    -- -- It's also possible to pass additional configuration options.
    -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set('n', '<leader>s/', function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = 'Live Grep in Open Files',
    --   }
    -- end, { desc = '[S]earch [/] in Open Files' })
    --
    -- -- Shortcut for searching your Neovim configuration files
    -- vim.keymap.set('n', '<leader>sn', function()
    --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
    -- end, { desc = '[S]earch [N]eovim files' })
    --
    --
    -- Buffers
    p.addCall('buffers.browse', function()
      builtin.buffers({
        initial_mode = 'normal',
        attach_mappings = function(prompt_bufnr, map)
          local delete_buf = function()
            local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
            current_picker:delete_selection(function(selection)
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            end)
          end

          map('n', '<c-d>', delete_buf)

          return true
        end,
      }, {
        sort_mru = true,
        ignore_current_buffer = true,
      })
    end, 10)

    -- Diagnostics
    p.addCall('diagnostics.buffer', function()
      builtin.diagnostics({ bufnr = 0, prompt_title = 'Current file' })
    end, 20)
    p.addCall('diagnostics.workspace', function()
      builtin.diagnostics({ prompt_title = 'Project' })
    end, 20)

    -- Filesystem
    p.addCall('fs.find_files', function()
      local ok = pcall(builtin.git_files, {
        show_untracked = true,
        -- recurse_submodules = true,
      })

      if ok then
        return
      end

      builtin.find_files({
        hidden = true,
      })
    end, 10)

    p.addCall('fs.find_recent_files', function()
      builtin.oldfiles({ cwd_only = true })
    end, 10)

    -- LSP
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('warpcode-lsp-attach-telescope', { clear = true }),
      callback = function(event)
        p.addCall('lsp.definition', builtin.lsp_definitions, 10, event.buf, event, event.id)
        p.addCall('lsp.implementation', builtin.lsp_implementations, 10, event.buf, event, event.id)
        p.addCall('lsp.references', builtin.lsp_references, 10, event.buf, event, event.id)
        p.addCall('lsp.type_definition', builtin.lsp_type_definitions, 10, event.buf, event, event.id)
      end,
    })

    -- Search
    p.addCall('search.file_contents', builtin.live_grep, 10)
    --
    -- -- Fuzzy find all the symbols in your current document.
    -- --  Symbols are things like variables, functions, types, etc.
    -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    --
    -- -- Fuzzy find all the symbols in your current workspace.
    -- --  Similar to document symbols, except searches over your entire project.
    -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  end,
}
