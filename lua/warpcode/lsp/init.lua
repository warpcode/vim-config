require('warpcode.lsp.servers.null-ls')
require('warpcode.lsp.servers.ansible')
require('warpcode.lsp.servers.bash')
require('warpcode.lsp.servers.css')
require('warpcode.lsp.servers.docker')
require('warpcode.lsp.servers.emmet')
require('warpcode.lsp.servers.html')
require('warpcode.lsp.servers.json')
require('warpcode.lsp.servers.lua')
require('warpcode.lsp.servers.php')
require('warpcode.lsp.servers.sql')
require('warpcode.lsp.servers.typescript')
require('warpcode.lsp.servers.vim')

local format_diagnostic = function (diagnostic)
    return string.format('[%s] %s', diagnostic.source, diagnostic.message)
end

vim.diagnostic.config({
    float = {
        format = format_diagnostic,
    },
    virtual_text = {
        format = format_diagnostic,
    },
})
