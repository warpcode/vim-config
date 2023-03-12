return {
    -- Whilst in command mode, after doing a search, an extra Carriage return turns
    -- off highlighting
    {'n', '<leader>/', function() vim.cmd(':noh') end},

    {'n', '<leader>fs', ':Telescope live_grep<CR>'},

    -- Search the project for the highlighted keyword
    -- nnoremap <leader>ps :execute 'silent! grep! ' . shellescape(expand("<cword>"))<CR>:cw<CR>
    -- vnoremap <leader>ps :<C-U>execute 'silent! grep! ' . shellescape(warpcode#string#escapeVimCommands(warpcode#util#getSelectedText()))<CR>:cw<CR>

    -- Search the current highlighted word in the buffer
    -- nnoremap <leader>bs :execute '/' . expand("<cword>")<CR>
    -- vnoremap <leader>bs :<C-U>execute '/' .  warpcode#util#getSelectedText()<CR><ESC>

    -- find replace in current buffer
    -- nnoremap <leader>br :%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>
    -- vnoremap <leader>br :<C-U>%s/<C-r>=warpcode#string#escapeVimRegex(warpcode#util#getSelectedText())<CR>/<C-r>=escape(warpcode#util#getSelectedText(), '/')<CR>/gcI<left><left><left><left>

    -- Search vim help of the current word
    -- nnoremap <leader>sh :execute 'h ' . expand("<cword>")<CR><CR>
    -- vnoremap <leader>sh :<C-U>execute 'h ' . warpcode#util#getSelectedText()<CR><CR>
}
