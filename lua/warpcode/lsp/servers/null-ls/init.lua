local null_ls_status, null_ls = pcall(require, 'null-ls')

if (not null_ls_status) then
    return
end

local wtables = require('warpcode.utils.tables')
local attachments = require('warpcode.lsp.attachments')

local sources = {
    require 'warpcode.lsp.servers.null-ls.sources.css',
    require 'warpcode.lsp.servers.null-ls.sources.json',
    require 'warpcode.lsp.servers.null-ls.sources.php',
    require 'warpcode.lsp.servers.null-ls.sources.typescript',
}

null_ls.setup({
    debug = false,
    sources = wtables.list_extend(wtables.table_unpack(sources)),
    on_attach = attachments.common,
    -- diagnostics_format = "[#{s}] #{m} [#{c}]"
})
