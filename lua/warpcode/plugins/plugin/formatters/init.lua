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
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 5000, lsp_format = 'fallback' }
      end,
    })

    vim.api.nvim_create_user_command('FormatToggle', function(args)
      if args.bang then
        -- Toggle buffer local autoformat
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false
          vim.notify('Format on save enabled for this buffer', vim.log.levels.INFO)
        else
          vim.b.disable_autoformat = true
          vim.notify('Format on save disabled for this buffer', vim.log.levels.INFO)
        end
      else
        -- Toggle global autoformat
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify('Format on save globally enabled', vim.log.levels.INFO)
        else
          vim.g.disable_autoformat = true
          vim.notify('Format on save globally disabled', vim.log.levels.INFO)
        end
      end
    end, {
      desc = 'Toggle format on save (use ! for buffer-local)',
      bang = true,
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
