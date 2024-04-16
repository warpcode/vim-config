local pexec = require 'warpcode.priority-exec'

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
                return vim.fn.executable 'make' == 1
            end,
        },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        -- { 'nvim-telescope/telescope-dap.nvim' },
    },
    config = function()
        local telescope = require 'telescope'
        -- local actions = require 'telescope.actions'
        local builtin = require "telescope.builtin"
        -- local previewers = require "telescope.previewers"
        -- local sorters = require "telescope.sorters"
        -- local pexec = require 'warpcode.priority-exec'

        telescope.setup {
            -- defaults = {
            --   file_sorter = sorters.get_fzf_sorter,
            --   prompt_prefix = " >",
            --   color_devicons = true,
            --   file_previewer = previewers.vim_buffer_cat.new,
            --   grep_previewer = previewers.vim_buffer_vimgrep.new,
            --   qflist_previewer = previewers.vim_buffer_qflist.new,
            --   mappings = {
            --     i = {
            --       ["<C-h>"] = "which_key",
            --       ["<ESC>"] = actions.close
            --     }
            --   }
            -- },
            -- pickers = {
            --   buffers = {
            --     ignore_current_buffer = true,
            --     sort_lastused = true,
            --   },
            -- },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
                -- fzf = {
                --   fuzzy = true,                              -- false will only do exact matching
                --   override_generic_sorter = true,            -- override the generic sorter
                --   override_file_sorter = true,               -- override the file sorter
                --   case_mode = "smart_case",                  -- or "ignore_case" or "respect_case"
                --   -- the default case_mode is "smart_case"
                -- }
            },
        }

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
        pexec.addCall('buffers.browse', builtin.buffers, 10)

        -- Diagnostics
        pexec.addCall('diagnostics.buffer', function()
            builtin.diagnostics({ bufnr = 0, prompt_title = "Current file" })
        end, 20)
        pexec.addCall('diagnostics.workspace', function() builtin.diagnostics({ prompt_title = "Project" }) end, 20)

        -- Filesystem
        pexec.addCall('fs.find_files', function()
            local opts = {} -- define here if you want to define something
            local ok = pcall(builtin.git_files, opts)
            if not ok then builtin.find_files(opts) end
        end, 10)
        pexec.addCall('fs.find_recent_files', function()
            require 'telescope.builtin'.oldfiles({ cwd_only = true })
        end, 10)

        -- LSP
        pexec.addCall('lsp.definition', builtin.lsp_definitions, 10)
        pexec.addCall('lsp.implementation', builtin.lsp_implementations, 10)
        pexec.addCall('lsp.references', builtin.lsp_references, 10)
        pexec.addCall('lsp.type_definition', builtin.lsp_type_definitions, 10)
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
