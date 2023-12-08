pcall(function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local builtins = require "telescope.builtin"
    local previewers = require "telescope.previewers"
    local sorters = require "telescope.sorters"
    local pexec = require 'warpcode.priority-exec'

    telescope.setup {
        defaults = {
            file_sorter = sorters.get_fzf_sorter,
            prompt_prefix = " >",
            color_devicons = true,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<ESC>"] = actions.close
                }
            }
        },
        pickers = {
            buffers = {
                ignore_current_buffer = true,
                sort_lastused = true,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    }

    telescope.load_extension('fzf')
    telescope.load_extension('dap')
    -- vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
    -- -- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
    -- vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

    -- diagnostics overrides
    pexec.addCall('diagnostics.buffer', function () builtins.diagnostics({ bufnr = 0, prompt_title = "Current file" })  end, 20)
    pexec.addCall('diagnostics.workspace', function () builtins.diagnostics({ prompt_title = "Project" })  end, 20)
end)
