require 'warpcode.keymaps'.map_list {
    -- Preseve visual mode when indenting
    { 'v', '<', '<gv' },
    { 'v', '>', '>gv' },
}
