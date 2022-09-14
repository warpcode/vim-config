local lib_prefix = 'warpcode.keymaps.'
local default_opt = { silent = true }
local maps = {
    require(lib_prefix .. 'history'),
    require(lib_prefix .. 'misc'),
}

for _, x in ipairs(maps) do
    for _, v in ipairs(x) do
        local mode, lhs, rhs, opt = unpack(v)
        opt = opt or default_opt

        vim.keymap.set(mode, lhs, rhs, opt)
    end
end
