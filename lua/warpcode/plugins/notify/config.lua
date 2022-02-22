
local notify_ok, notify = pcall(require, 'notify')

return {
    run = function()
        if not notify_ok then return end

        local log = require("plenary.log").new {
            plugin = "notify",
            level = "debug",
            use_console = false,
        }

        vim.notify = function(msg, level, opts)
            log.info(msg, level, opts)
            notify(msg, level, opts)
        end
    end
}
