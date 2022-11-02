local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local M = {}

M.common = function ()
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    if (cmp_nvim_lsp_status) then
        capabilities = capabilities
    end

	return capabilities
end

return M
