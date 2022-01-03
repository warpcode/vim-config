local packages = require('warpcode.utils.packages')
local M = {}

M.config = function(_config)
    local new_capabilities = vim.lsp.protocol.make_client_capabilities()

    if packages.is_loaded('nvim-cmp') then
        new_capabilities = require("cmp_nvim_lsp").update_capabilities(new_capabilities)
    end

	return vim.tbl_deep_extend("force", {
		capabilities = new_capabilities,
	}, _config or {})
end

return M
