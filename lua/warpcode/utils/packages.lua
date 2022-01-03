local M = {}

M.is_loaded = function (package)
    return vim.fn['warpcode#packages#is_module_loaded'](package) == 1
end

return M
