vim.opt.rtp:append('.')
package.loaded['cmp_nvim_lsp'] = { default_capabilities = function() return {} end }
package.loaded['mason'] = { setup = function() end }
package.loaded['mason-tool-installer'] = { setup = function() end }
package.loaded['mason-lspconfig'] = { setup = function() end }

vim.lsp.config = function() end
-- mock vim.lsp.get_client_by_id to return a client without server_capabilities
vim.lsp.get_client_by_id = function() return {} end

local p = require('lua.warpcode.plugins.plugin.lsp.init')

_G.lsp_attach_callback = nil
local orig_create_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(evt, opts)
  if evt == 'LspAttach' and opts.callback and not _G.lsp_attach_callback then
     _G.lsp_attach_callback = opts.callback
  end
end

if p.config then p.config() end

local ok, err = pcall(_G.lsp_attach_callback, {
  buf = 1,
  id = 1,
  data = { client_id = 1 }
})

print("Success: " .. tostring(ok))
if err then print("Error: " .. tostring(err)) end
