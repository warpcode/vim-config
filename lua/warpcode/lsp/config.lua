local attachments = require('warpcode.lsp.attachments')
local capabilities = require('warpcode.lsp.capabilities')

local M = {}

M.common = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities.common(),
        on_attach = attachments.common,
	}, _config or {})
end

return M
