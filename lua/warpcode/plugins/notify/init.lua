local M = {
    source = 'rcarriga/nvim-notify',
    config = function()
        require 'warpcode.plugins.notify.config'.run()
    end
}

return M
