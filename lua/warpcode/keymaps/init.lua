local lib_prefix = 'warpcode.keymaps.'
local default_opt = { noremap = true, silent = true }

local M = {}

---Map a list of keymaps
---@param list table A list of keymaps { {mode, lhs, rhs, opt:table} }
M.map_list = function(list)
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

M.map_list(require(lib_prefix .. 'clipboard'))
M.map_list(require(lib_prefix .. 'history'))
M.map_list(require(lib_prefix .. 'misc'))
M.map_list(require(lib_prefix .. 'navigation'))
M.map_list(require(lib_prefix .. 'search'))
M.map_list(require(lib_prefix .. 'text'))
M.map_list(require(lib_prefix .. 'ui'))

return M
