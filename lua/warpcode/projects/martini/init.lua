local path = require('warpcode.utils.path')
local M = {}

M.get_project_root = function (file)
    return path.root_pattern({'initMartini.sh'}, file or vim.fn.expand('%:p'))
end

return M
