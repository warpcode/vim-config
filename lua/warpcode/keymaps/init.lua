local default_opt = { noremap = true, silent = true }

local M = {}

---Map a list of keymaps
---@param list table A list of keymaps { {mode, lhs, rhs, opt:table} }
M.map_list = function(list)
    if #list == 0 then
        return
    end

    for _, v in ipairs(list) do
        M.map(v)
    end
end

---Map a list to a keymap
---@param map table Keymap is table format {mode, lhs, rhs, opt:table}
M.map = function(map)
    local mode, lhs, rhs, opt = unpack(map)

    vim.keymap.set(mode, lhs, rhs, opt or default_opt)
end

---Use the default opt as a base for a custom opt
---@param opt table
---@return table
M.extend_default_opt = function(opt)
    return vim.tbl_deep_extend("force", default_opt, opt)
end

return M
