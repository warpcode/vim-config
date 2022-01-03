local M = {}

M.config = function(_config)
    local new_capabilities = vim.lsp.protocol.make_client_capabilities()

    if vim.fn['warpcode#packages#is_module_loaded']('nvim-cmp') == 1 then
        new_capabilities = require("cmp_nvim_lsp").update_capabilities(new_capabilities)
    end

	return vim.tbl_deep_extend("force", {
		capabilities = new_capabilities,
	}, _config or {})
end

return M
