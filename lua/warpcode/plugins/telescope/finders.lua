local actions = require('telescope.actions')
local builtins = require("telescope.builtin")
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
