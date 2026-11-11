local assert = require('luassert')

describe("LSP attach callback", function()
  it("does not crash when client.server_capabilities is nil", function()
    -- Ensure required packages exist (mocked) for lsp init script
    package.loaded['cmp_nvim_lsp'] = { default_capabilities = function() return {} end }
    package.loaded['mason'] = { setup = function() end }
    package.loaded['mason-tool-installer'] = { setup = function() end }
    package.loaded['mason-lspconfig'] = { setup = function() end }

    vim.lsp.config = function() end
    -- mock vim.lsp.get_client_by_id to return a client without server_capabilities
    vim.lsp.get_client_by_id = function() return {} end

    -- Load module which sets up the LspAttach event
    local p = require('warpcode.plugins.plugin.lsp.init')

    _G.lsp_attach_callback = nil
    local orig_create_autocmd = vim.api.nvim_create_autocmd
    vim.api.nvim_create_autocmd = function(evt, opts)
      if evt == 'LspAttach' and opts.callback and not _G.lsp_attach_callback then
        _G.lsp_attach_callback = opts.callback
      end
    end

    if p.config then p.config() end

    -- Verify callback triggers successfully without throwing nil index exception
    local ok, err = pcall(_G.lsp_attach_callback, {
      buf = 1,
      id = 1,
      data = { client_id = 1 }
    })

    assert.is_true(ok, "LspAttach callback threw an error: " .. tostring(err))

    -- Restore
    vim.api.nvim_create_autocmd = orig_create_autocmd
  end)
end)
