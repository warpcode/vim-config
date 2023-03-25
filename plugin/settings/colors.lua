local ok = pcall(function()
    vim.api.nvim_exec([[colorscheme base16-gruvbox-dark-hard]], false)
end)

if not ok then
    vim.api.nvim_exec([[colorscheme warpcode-default]], false)
end
