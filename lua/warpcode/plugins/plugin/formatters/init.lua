local pexec = require 'warpcode.priority-exec'
local servers = require 'warpcode.plugins.plugin.formatters.servers'

return {
    'stevearc/conform.nvim',
    lazy = false,
    -- keys = {
    --   {
    --     '<leader>f',
    --     function()
    --       require('conform').format { async = true, lsp_fallback = true }
    --     end,
    --     mode = '',
    --     desc = '[F]ormat buffer',
    --   },
    -- },
    config = function()
        require('conform').setup {
            notify_on_error = false,
            -- format_on_save = function(bufnr)
            --     -- Disable "format_on_save lsp_fallback" for languages that don't
            --     -- have a well standardized coding style. You can add additional
            --     -- languages here or re-enable it for the disabled ones.
            --     local disable_filetypes = { c = true, cpp = true }
            --     return {
            --         timeout_ms = 500,
            --         lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            --     }
            -- end,
            formatters_by_ft = servers.servers,
            formatters = servers.formatters_override,
        }

        pexec.addCall('lsp.format', function()
            require('conform').format {
                async = true,
                lsp_fallback = true,
                ignore_errors = true,
            }
        end, 50)
    end
}
