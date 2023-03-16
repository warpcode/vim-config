require 'warpcode.keymaps'.map_list {
    -- Add additional undo breakpoints
    { 'i', ',', ',<c-g>u' },
    { 'i', '.', '.<c-g>u' },
    { 'i', '!', '!<c-g>u' },
    { 'i', '?', '?<c-g>u' },
}
