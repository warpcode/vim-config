-- Get the folder where this init.lua lives
-- local base_dir = (function()
--     local init_path = debug.getinfo(1, "S").source
--     return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
-- end)()

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.vim_home = vim.fn.stdpath('config')
vim.g.vim_source = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.stdpath('config') .. '/init.lua'), ':h')

require('warpcode')
