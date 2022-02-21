local M = {
    source = 'tzachar/cmp-tabnine',
    config = function()
        require 'warpcode.plugins.cmp-tabnine.config'.run()
    end,
    run = './install.sh',
}

return M
