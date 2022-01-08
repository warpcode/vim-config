local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local M = {}

M.common = function ()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    if (cmp_nvim_lsp_status) then  
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    end

	return capabilities
end

return M
