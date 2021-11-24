if vim.fn['warpcode#packages#is_module_loaded']('lspkind-nvim') == 0 then
    return
end

local lspkind = require("lspkind")
lspkind.init({
    with_text = true,
})
