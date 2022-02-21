local M = {
    source = 'vim-airline/vim-airline',
    config = function()
        require 'warpcode.plugins.airline.config'.run()
    end
}

return M
