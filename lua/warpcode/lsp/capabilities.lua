local packages = require('warpcode.utils.packages')
local M = {}

M.common = function ()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    if packages.is_loaded('nvim-cmp') then
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    end

	return capabilities
end

return M
