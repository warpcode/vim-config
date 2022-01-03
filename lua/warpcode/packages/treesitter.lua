if vim.fn['warpcode#packages#is_module_loaded']('nvim-treesitter') == 0 then
    return
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        -- false will disable the whole extension
        enable = false
    },
}
