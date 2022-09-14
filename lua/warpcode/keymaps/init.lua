
local default = { silent = true }
local maps = {
    -- Add additional undo breakpoints
    {'i', ',', ',<c-g>u', default},
    {'i', '.', '.<c-g>u', default},
    {'i', '!', '!<c-g>u', default},
    {'i', '?', '?<c-g>u', default},

    -- Insert mode easy escape
    {'i', 'jk', '<ESC>', default},
    {'i', 'kj', '<ESC>', default},
}

for _, v in ipairs(maps) do
    vim.keymap.set(unpack(v))
end
