require 'warpcode.keymaps'.map_list {
    -- When pasting, send the highlighted text to a black hole register
    -- This stops the replaced text from going into the normal clipboard registers
    { 'v', '<leader>p', '"_dP' },

    -- Delete text and send to the black hole register
    -- This stops the deleted text going into the normal clipboard registers
    { 'n', '<leader>d', '"_d' },
    { 'v', '<leader>d', '"_d' },

    -- Yank to system clipboard
    { 'n', '<leader>y', '"+y' },
    { 'v', '<leader>y', '"+y' },

    -- Yank entire buffer to system clipboard
    -- And then return to the last cursor position
    { 'n', '<leader>Y', 'gg"+yG<C-o>' },

    -- Make Y behave like C and D
    { 'n', 'Y',         'yg_' },
}
