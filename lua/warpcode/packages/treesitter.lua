local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-treesitter') then
    return
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        -- false will disable the whole extension
        enable = false
    },
}
