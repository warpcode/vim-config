local p = require('warpcode.utils.keymap-actions')
local lbuf = vim.lsp.buf
local lsp_servers = require('warpcode.plugins.plugin.lsp.servers')
local lint_servers = require('warpcode.plugins.plugin.linters.servers')
local format_servers = require('warpcode.plugins.plugin.formatters.servers')

return {
  'neovim/nvim-lspconfig',
  priority = 50,
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- `neodev` configures Lua LSP for your Neovim config development
    { 'folke/neodev.nvim', opts = {} },

    {
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({
          mode = 'symbol_text',
        })

        --https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
        vim.cmd([[
          " gray
          highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
          " blue
          highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
          highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
          " light blue
          highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
          highlight! link CmpItemKindInterface CmpItemKindVariable
          highlight! link CmpItemKindText CmpItemKindVariable
          " pink
          highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
          highlight! link CmpItemKindMethod CmpItemKindFunction
          " front
          highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
          highlight! link CmpItemKindProperty CmpItemKindKeyword
          highlight! link CmpItemKindUnit CmpItemKindKeyword
        ]])
      end,
    },
    {
      'glepnir/lspsaga.nvim',
      config = function()
        require('lspsaga').setup({})

        -- LSP overrides
        -- pexec.addCall('lsp.code_action', function() vim.cmd [[ Lspsaga code_action ]] end, 10)
        p.addCall('lsp.rename', function()
          vim.cmd([[ Lspsaga rename ]])
        end, 10)

        -- diagnostics overrides
        -- pexec.addCall('diagnostics.next', function() require("lspsaga.diagnostic"):goto_next() end, 10)
        -- pexec.addCall('diagnostics.prev', function() require("lspsaga.diagnostic"):goto_prev() end, 10)
        -- pexec.addCall('diagnostics.buffer', function() vim.cmd [[ Lspsaga show_buf_diagnostics ]] end, 10)
        -- pexec.addCall('diagnostics.workspace', function() vim.cmd [[ Lspsaga show_workspace_diagnostics ]] end, 10)
      end,
    },
    {
      'ray-x/lsp_signature.nvim',
      opts = {
        bind = false,
        floating_window = true,
        floating_window_off_x = 1, -- adjust float windows x position.
        floating_window_off_y = 1000, -- adjust float windows y position.
        hint_enable = true,
        -- hi_parameter = "Search",
        handler_opts = {
          border = 'shadow', -- double, rounded, single, shadow, none
        },
        fix_pos = function(signatures, _) -- second argument is the client
          local activeParameter = signatures.activeParameter or 0
          local signatureParameters = signatures.parameters or {}

          return activeParameter >= 0 and #signatureParameters > 1
        end,
      },
    },
    -- { "jose-elias-alvarez/null-ls.nvim" },
  },

  config = function()
    -- On LSP Attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('warpcode-lsp-attach', { clear = true }),
      callback = function(event)
        p.addCall('lsp.code_action', lbuf.code_action, 10, event.buf, event, event.id)
        p.addCall('lsp.declaration', lbuf.declaration, 10, event.buf, event, event.id)
        p.addCall('lsp.definition', lbuf.definition, 10, event.buf, event, event.id)
        p.addCall('lsp.format', lbuf.format, 10, event.buf, event, event.id)
        p.addCall('lsp.hover', lbuf.hover, 10, event.buf, event, event.id)
        p.addCall('lsp.implementation', lbuf.implementation, 10, event.buf, event, event.id)
        p.addCall('lsp.references', lbuf.references, 10, event.buf, event, event.id)
        p.addCall('lsp.rename', lbuf.rename, 10, event.buf, event, event.id)
        p.addCall('lsp.signature_help', lbuf.signature_help, 10, event.buf, event, event.id)
        p.addCall('lsp.type_definition', lbuf.type_definition, 10, event.buf, event, event.id)
        p.addCall('lsp.add_workspace_folder', lbuf.add_workspace_folder, 10, event.buf, event, event.id)
        p.addCall('lsp.list_workspace_folders', lbuf.list_workspace_folders, 10, event.buf, event, event.id)
        p.addCall('lsp.remove_workspace_folder', lbuf.remove_workspace_folder, 10, event.buf, event, event.id)

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason').setup()
    require('mason-tool-installer').setup({
      ensure_installed = (function()
        local ensure_installed = vim.tbl_keys(lsp_servers or {})

        -- Linters
        vim.list_extend(ensure_installed, lint_servers.get_mason_tool_names())

        -- Formatters
        vim.list_extend(ensure_installed, format_servers.get_mason_tool_names())

        return ensure_installed
      end)(),
      auto_update = false,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      -- debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = lsp_servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
}
