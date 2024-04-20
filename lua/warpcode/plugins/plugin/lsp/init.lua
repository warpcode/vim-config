local pexec = require('warpcode.utils.priority-exec')
local maps = require('warpcode.utils.keymaps')
local lbuf = vim.lsp.buf
local lsp_servers = require('warpcode.plugins.plugin.lsp.servers')
local lint_servers = require('warpcode.plugins.plugin.linters.servers')
local format_servers = require('warpcode.plugins.plugin.formatters.servers')

return {
  'neovim/nvim-lspconfig',
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
        pexec.addCall('lsp.rename', function()
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
          return signatures.activeParameter >= 0 and #signatures.parameters > 1
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
        pexec.addCall('lsp.code_action', function()
          lbuf.code_action()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.declaration', function()
          lbuf.declaration()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.definition', function()
          lbuf.definition()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.format', function()
          lbuf.format()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.hover', function()
          lbuf.hover()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.implementation', function()
          lbuf.implementation()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.references', function()
          lbuf.references()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.rename', function()
          lbuf.rename()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.signature_help', function()
          lbuf.signature_help()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.type_definition', function()
          lbuf.type_definition()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.add_workspace_folder', function()
          lbuf.add_workspace_folder()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.list_workspace_folders', function()
          lbuf.list_workspace_folders()
        end, 0, event.buf, event, event.id)
        pexec.addCall('lsp.remove_workspace_folder', function()
          lbuf.remove_workspace_folder()
        end, 0, event.buf, event, event.id)

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

        -- DAP
        vim.list_extend(ensure_installed, {
          'php-debug-adapter',
        })

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
