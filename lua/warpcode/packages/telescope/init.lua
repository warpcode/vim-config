local telescope_status, telescope = pcall(require, 'telescope')

if (not telescope_status) then  
    return
end

local actions = require('telescope.actions')
local builtins = require("telescope.builtin")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

telescope.setup{
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
      fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }

telescope.load_extension('fzf')

local M = {}

M.search_dotfiles = function()
    builtins.find_files({
        prompt_title = "< VimRC >",
        cwd = vim.g.vim_source,
        hidden = true,
    })
end

M.git_branches = function()
    builtins.git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtins.git_files, opts)
  if not ok then builtins.find_files(opts) end
end

return M
