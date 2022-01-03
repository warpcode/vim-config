local packages = require('warpcode.utils.packages')

if not packages.is_loaded('lspkind-nvim') then
    return
end

local lspkind = require("lspkind")
lspkind.init({
    with_text = true,
})
