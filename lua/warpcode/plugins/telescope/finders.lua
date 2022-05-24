local actions = require('telescope.actions')
local builtins = require("telescope.builtin")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
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

M.git_changed_files = function(opts)
    -- Retrieve untracked and modified files
	local command = "git ls-files --others --exclude-standard -m"
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for token in string.gmatch(result, "[^%s]+") do
	   table.insert(files, token)
	end

	opts = opts or {}

	pickers.new(opts, {
		prompt_title = "changed files",
		finder = finders.new_table {
			results = files
		},
		sorter = conf.generic_sorter(opts),
	}):find()
end

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtins.git_files, opts)
  if not ok then builtins.find_files(opts) end
end

return M
