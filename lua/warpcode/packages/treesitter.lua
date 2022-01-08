local treesitter_configs_status, treesitter_configs = pcall(require, 'nvim-treesitter.configs')

if (not treesitter_configs_status) then
    return
end

treesitter_configs.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        -- false will disable the whole extension
        enable = false
    },
}
