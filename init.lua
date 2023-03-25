-- Get the folder where this init.lua lives
local base_dir = (function()
    local init_path = debug.getinfo(1, "S").source
    return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
end)()

-- Add the config to the rtp
if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
    vim.opt.rtp:prepend(base_dir)
    vim.opt.rtp:append(base_dir .. '/after')
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.vim_home = vim.fn.stdpath('config')
vim.g.vim_source = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.stdpath('config') .. '/init.lua'), ':h')

pcall(vim.cmd, [[ packadd vim-config ]])

pcall(function()
    vim.cmd [[ packadd packer.nvim ]]
    require 'packer'.init {
        display = {
            open_fn = function()
                return require "packer.util".float { border = 'rounded' }
            end,
        }
    }
end)

require('warpcode')
