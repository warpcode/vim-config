return {
    -- Resize verticle pane split incrementally
    {'n', '<Leader>+ :vertical resize', '+5<CR>'},
    {'n', '<Leader>- :vertical resize', '-5<CR>'},

    -- Maximise verticle split
    {'n', '<Leader>rp :resize', '100<CR>'},

    -- Switching windows
    {'', '<A-j>', '<C-w>j'},
    {'', '<A-k>', '<C-w>k'},
    {'', '<A-l>', '<C-w>l'},
    {'', '<A-h>', '<C-w>h'},
    {'', '<A-w>', '<C-w>w'},

    -- highlight last inserted text
    {'n', 'gV', '`[v`]'},

    -- Move visual block
    {'v', '<c-j> :m', '\'>+1<CR>gv=gv'},
    {'v', '<c-k> :m', '\'<-2<CR>gv=gv'},
    {'i', '<c-j> <esc>:m', '.+1<CR>==gi'},
    {'i', '<c-k> <esc>:m', '.-2<CR>==gi'},
    {'n', '<c-j> :m', '.+1<CR>=='},
    {'n', '<c-k> :m', '.-2<CR>=='},
}
