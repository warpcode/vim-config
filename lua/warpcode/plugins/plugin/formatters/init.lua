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
      -- Set a timeout for formatters to prevent them from hanging indefinitely
      timeout_ms = 5000, -- 5 seconds
    })

    -- Don't add to LSP Attach event as this runs formatters outside of lsp
    p.addCall('lsp.format', function()
      require('conform').format({
        async = true, -- Run formatting asynchronously
        lsp_format = 'fallback', -- Use LSP formatting as a fallback
        timeout_ms = 5000, -- Also apply timeout to manual format calls
      })
    end, 50)
  end,
}
