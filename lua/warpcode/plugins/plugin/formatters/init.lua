local p = require('warpcode.utils.keymap-actions')
local servers = require('warpcode.plugins.plugin.formatters.servers')

return {
  'stevearc/conform.nvim',
  lazy = false,
  config = function()
    require('conform').setup({
      notify_on_error = false,
      formatters_by_ft = servers.servers,
      formatters = servers.formatters_override,
    })

    -- Don't add to LSP Attach event as this runs formatters outside of lsp
    p.addCall('lsp.format', function()
      require('conform').format({
        async = true,
        lsp_fallback = true,
        ignore_errors = true,
      })
    end, 50)
  end,
}
