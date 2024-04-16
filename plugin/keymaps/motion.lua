require 'warpcode.keymaps'.map_list {
    -- move vertically by visual line (ie will go into a wrapped line that's
    -- visually on the next line)
    { 'n', 'j',          'gj' },
    { 'n', 'k',          'gk' },
}
