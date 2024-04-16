local M = {}

M.is_headless = function ()
    return #vim.api.nvim_list_uis() == 0
end

return M
