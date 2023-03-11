local M = {
    source = 'rcarriga/nvim-notify',
    config = function()
        local notify_ok, notifylib = pcall(require, 'notify')

        if not notify_ok then return end

        local log = require("plenary.log").new {
            plugin = "notify",
            level = "debug",
            use_console = false,
        }

        vim.notify = function(msg, level, opts)
            log.info(msg, level, opts)
            return notifylib(msg, level, opts)
        end
    end
}

return M
