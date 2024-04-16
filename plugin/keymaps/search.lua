local pexec = require 'warpcode.priority-exec'
local maps = require "warpcode.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('search.file_contents', function() vim.api.nvim_input(':vimgrep //j ** <BAR> cw' .. string.rep('<left>', 10)) end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { 'n', '<leader>/',  function() vim.cmd(':noh') end , maps.extend_default_opt({ desc = 'Search: Clear Buffer Search' }) },
    { "n", "<leader>ss", function() pexec.exec('search.file_contents') end, maps.extend_default_opt({ desc = 'Search: Search File Contents' }) },
}

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
