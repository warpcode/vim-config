local p = require('warpcode.utils.keymap-actions')
local opt = { noremap = true, silent = true }
local m = vim.keymap.set
local e = function (...)
  return vim.tbl_deep_extend('force', ...)
end

-- [[ AI ]]
-- p.addCall('ai.previous', function() end)
-- p.addCall('ai.next', function() end)
-- p.addCall('ai.suggest', function() end)
-- p.addCall('ai.accept', function() end)
-- p.addCall('ai.accept_line', function() end)
-- p.addCall('ai.chat', function() end)
m('i', '<C-s>[',      p.getAction('ai.previous'),    e(opt, { desc = 'AI: Previous Suggestion' }))
m('i', '<C-s>]',      p.getAction('ai.next'),        e(opt, { desc = 'AI: Next Suggestion' }))
m('i', "<C-s>s",      p.getAction('ai.suggest'),     e(opt, { desc = 'AI: Request Suggestions' }) )
m('i', "<C-s>a",      p.getAction('ai.accept'),      e(opt, { desc = 'AI: Accept Suggestion' }) )
m('i', "<C-s>l",      p.getAction('ai.accept_line'), e(opt, { desc = 'AI: Accept Line of Suggestion' }) )
m('n', '<leader>ai>', p.getAction('ai.chat'),        e(opt, { desc = 'AI: Open Chat' }))

-- [[ Buffers ]]
p.addCall('buffers.browse', function() vim.api.nvim_input ':buffers<CR>' end)
p.addCall('buffers.next', function() vim.api.nvim_input ':bn<CR>' end)
p.addCall('buffers.previous', function() vim.api.nvim_input ':bp<CR>' end)
p.addCall('buffers.close', function() vim.api.nvim_input ':bp <bar> if buflisted(bufnr("#")) == 0 | enew | endif <bar> bd! #<cr>' end)

-- { "n", "<leader>ds", vim.diagnostic.open_float },
m('n', '[b',         p.getAction('buffers.previous'), e(opt, { desc = 'Buffers: Previous Buffer' }))
m('n', ']b',         p.getAction('buffers.next'),     e(opt, { desc = 'Buffers: Next Buffer' }))
m('n', '<leader>bb', p.getAction('buffers.browse'),   e(opt, { desc = 'Buffers: Browse Buffers' }))
m('n', "<leader>bq", p.getAction('buffers.close'),    e(opt, { desc = 'Buffers: Close Buffer' }) )

-- [[ Clipboard ]]
m('v',          '<leader>p',  '"_dP',                                  e(opt, { desc = 'Clipboard: Paste (no copy)' }))
m({ 'n', 'v' }, '<leader>dd', '"_d',                                   e(opt, { desc = 'Clipboard: Delete (no copy)' }))
m('n',          '<leader>Y',  'gg"+yG<C-o>',                           e(opt, { desc = 'Clipboard: Copy buffer contents' }))
m('n',          'Y',          'yg_',                                   e(opt, { desc = 'Clipboard: Copy to endof line'}))
m('n',          'gV',         '`[v`]',                                 e(opt, { desc = 'Clipboard: Copy last paste'}))
m('n',          '<leader>yp', ':let @+=expand("%")<CR>',               e(opt, { desc = 'Clipboard: Copy the relative filepath to the clipboard'}))
m('n',          '<leader>yr', ':let @+=expand("%").":".line(".")<CR>', e(opt, { desc = 'Clipboard: Copy the current file path and line number reference'}))

-- [[ Debug ]]
p.addCall('debug.breakpoint_toggle', function() end)
p.addCall('debug.breakpoint_conditional', function() end)
p.addCall('debug.continue', function() end)
p.addCall('debug.terminate', function() end)
p.addCall('debug.step_over', function() end)
p.addCall('debug.step_into', function() end)
p.addCall('debug.step_out', function() end)

--     vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
--     vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
--     -- vim.keymap.set('n', '<leader>dn', function() dap.run_to_cursor() end)
--     -- vim.keymap.set('n', '<leader>dR', function() dap.clear_breakpoints() end)
--     -- vim.keymap.set('n', '<leader>de', function() dap.set_exception_breakpoints({"all"}) end)
--     vim.keymap.set('n', '<leader>da', function() debug.attach() end)
--     vim.keymap.set('n', '<leader>dA', function() debug.attachToRemote() end)
--     vim.keymap.set('n', '<leader>dh', function() widgets.hover() end)
--     vim.keymap.set('n', '<leader>d?', function() widgets.centered_float(widgets.scopes) end)
--     vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

m("n", "<leader>dt", p.getAction('debug.breakpoint_toggle'),      e(opt, { desc = 'Debug: Breaktpoint Toggle' }))
m("n", "<leader>dT", p.getAction('debug.breakpoint_conditional'), e(opt, { desc = 'Debug: Breakpoint Conditional' }))
m("n", "<leader>dc", p.getAction('debug.continue'),               e(opt, { desc = 'Debug: Continue' }))
m("n", "<leader>dC", p.getAction('debug.terminate'),              e(opt, { desc = 'Debug: Terminate' }))
m("n", "<leader>do", p.getAction('debug.step_over'),              e(opt, { desc = 'Debug: Step Over' }))
m("n", "<leader>di", p.getAction('debug.step_into'),              e(opt, { desc = 'Debug: Step Into' }))
m("n", "<leader>dI", p.getAction('debug.step_out'),               e(opt, { desc = 'Debug: Step Out' }))

-- [[ Diagnostics ]]
p.addCall('diagnostics.next', function() vim.diagnostic.goto_next() end)
p.addCall('diagnostics.prev', function() vim.diagnostic.goto_prev() end)
p.addCall('diagnostics.buffer', function() vim.diagnostic.setloclist() end)
p.addCall('diagnostics.workspace', function() vim.diagnostic.setqflist() end)

-- { "n", "<leader>ds", vim.diagnostic.open_float },
m("n", "[d",         p.getAction('diagnostics.prev'),      e(opt, { desc = 'Diagnostics: Previous' }))
m("n", "]d",         p.getAction('diagnostics.next'),      e(opt, { desc = 'Diagnostics: Next' }))
m("n", "<leader>db", p.getAction('diagnostics.buffer'),    e(opt, { desc = 'Diagnostics: Show Buffer' }))
m("n", "<leader>dw", p.getAction('diagnostics.workspace'), e(opt, { desc = 'Diagnostics: Show Workspace' }))

-- [[ Filesystem ]]
p.addCall('fs.file_tree', function() vim.cmd 'Lexplore' end)
p.addCall('fs.find_buffer', function() vim.api.nvim_input ':let @/=expand("%:t") <Bar> execute \'Lexplore\' expand("%:h") <Bar> normal n<CR>' end)
p.addCall('fs.find_files', function() vim.api.nvim_input ':find ' end)
p.addCall('fs.find_recent_files', function() vim.api.nvim_input ":oldfiles<CR>" end)

m("n", "<leader>ft", p.getAction('fs.file_tree'),         e(opt, { desc = 'FS: File Tree' }))
m("n", "<leader>fb", p.getAction('fs.find_buffer'),       e(opt, { desc = 'FS: Find Buffer in File Tree' }))
m("n", "<leader>ff", p.getAction('fs.find_files'),        e(opt, { desc = 'FS: Find Files' }))
m("n", "<leader>fr", p.getAction('fs.find_recent_files'), e(opt, { desc = 'FS: Find Recent Files' }))

-- [[ History ]]
-- Add additional undo breakpoints
m('i', ',', ',<c-g>u', opt)
m('i', '.', '.<c-g>u', opt)
m('i', '!', '!<c-g>u', opt)
m('i', '?', '?<c-g>u', opt)

-- [[ LSP ]]
m({ 'n', 'v' }, '<leader>ca', p.getAction('lsp.code_action'),             e(opt, { desc = 'LSP: Code Actions'}))
m('n',          'gD',         p.getAction('lsp.declaration'),             e(opt, { desc = 'LSP: Go to Declaration'}))
m('n',          'gd',         p.getAction('lsp.definition'),              e(opt, { desc = 'LSP: Go to Definition'}))
m({ 'n', 'x' }, '<leader>=',  p.getAction('lsp.format'),                  e(opt, { desc = 'LSP: Format'}))
m('n',          'K',          p.getAction('lsp.hover'),                   e(opt, { desc = 'LSP: Hover Documentation'}))
m('n',          'gi',         p.getAction('lsp.implementation'),          e(opt, { desc = 'LSP: Go to Implementation'}))
m('n',          'gr',         p.getAction('lsp.references'),              e(opt, { desc = 'LSP: Go to References'}))
m('n',          '<leader>rn', p.getAction('lsp.rename'),                  e(opt, { desc = 'LSP: Rename'}))
m('n',          '<C-k>',      p.getAction('lsp.signature_help'),          e(opt, { desc = 'LSP: Signature Help'}))
m('n',          '<leader>D',  p.getAction('lsp.type_definition'),         e(opt, { desc = 'LSP: Type Definition'}))
m('n',          '<space>wa',  p.getAction('lsp.add_workspace_folder'),    e(opt, { desc = 'LSP: Add Workspace Folder'}))
m('n',          '<space>wr',  p.getAction('lsp.remove_workspace_folder'), e(opt, { desc = 'LSP: Remove Workspace Folder'}))
m('n',          '<space>wl',  p.getAction('lsp.list_workspace_folders'),  e(opt, { desc = 'LSP: List Workspace folders'}))


-- [[ Quickfix / Loclist ]]
m('n', ']q', function() vim.cmd('cnext') end, e(opt, { desc = 'Quickfix: Next' }))
m('n', '[q', function() vim.cmd('cprev') end, e(opt, { desc = 'Quickfix: Previous' }))
m('n', ']Q', function() vim.cmd('clast') end, e(opt, { desc = 'Quickfix: Last' }))
m('n', '[Q', function() vim.cmd('cfirst') end, e(opt, { desc = 'Quickfix: First' }))
m('n', '<leader>qo', function() vim.cmd('copen') end, e(opt, { desc = 'Quickfix: Open' }))
m('n', '<leader>qc', function() vim.cmd('cclose') end, e(opt, { desc = 'Quickfix: Close' }))

m('n', ']l', function() vim.cmd('lnext') end, e(opt, { desc = 'Loclist: Next' }))
m('n', '[l', function() vim.cmd('lprev') end, e(opt, { desc = 'Loclist: Previous' }))
m('n', ']L', function() vim.cmd('llast') end, e(opt, { desc = 'Loclist: Last' }))
m('n', '[L', function() vim.cmd('lfirst') end, e(opt, { desc = 'Loclist: First' }))
m('n', '<leader>lo', function() vim.cmd('lopen') end, e(opt, { desc = 'Loclist: Open' }))
m('n', '<leader>lc', function() vim.cmd('lclose') end, e(opt, { desc = 'Loclist: Close' }))


-- [[ Misc ]]
-- Map semicolon to colon to write commands without needing to hit shift
m({'n', 'v'}, ';', ':', opt)

vim.cmd([[
  " Common abbreviation for typos
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qa qa
  cnoreabbrev Qall qall
]])


  -- Preseve visual mode when indenting
m('v', '<', '<gv', opt)
m('v', '>', '>gv', opt)

-- Insert mode easy escape
m('i', 'jk', '<ESC>', opt)
m('i', 'kj', '<ESC>', opt)

-- Move visual block
m('v', '<c-j> :m', "'>+1<CR>gv=gv", opt)
m('v', '<c-k> :m', "'<-2<CR>gv=gv", opt)
m('i', '<c-j> <esc>:m', '.+1<CR>==gi', opt)
m('i', '<c-k> <esc>:m', '.-2<CR>==gi', opt)
m('n', '<c-j> :m', '.+1<CR>==', opt)
m('n', '<c-k> :m', '.-2<CR>==', opt)

-- [[ Motion ]]
  -- move vertically by visual line (ie will go into a wrapped line that's
  -- visually on the next line)
m('n', 'j', 'gj', opt)
m('n', 'k', 'gk', opt)

  -- Switching windows
m('', '<A-j>', '<C-w>j', opt)
m('', '<A-k>', '<C-w>k', opt)
m('', '<A-l>', '<C-w>l', opt)
m('', '<A-h>', '<C-w>h', opt)
m('', '<A-w>', '<C-w>w', opt)

-- [[ Search ]]
p.addCall('search.file_contents', function() vim.api.nvim_input(':vimgrep //j ** <BAR> cw' .. string.rep('<left>', 10)) end)

m('n', '<leader>/',  function() vim.cmd(':noh') end ,     e(opt, { desc = 'Search: Clear Buffer Search' }))
m("n", "<leader>ss", p.getAction('search.file_contents'), e(opt, { desc = 'Search: Search File Contents' }))

-- [[ Version Control ]]
m('n', '<leader>vl', p.getAction('vcs.show_status'),       e(opt, { desc = 'Version Control: Show Status' }))
m('n', '[C',         p.getAction('vcs.hunk_first'),        e(opt, { desc = 'Version Control: Hunk: First' }))
m('n', '[c',         p.getAction('vcs.hunk_previous'),     e(opt, { desc = 'Version Control: Hunk: Previous' }))
m('n', ']c',         p.getAction('vcs.hunk_next'),         e(opt, { desc = 'Version Control: Hunk: Next' }))
m('n', ']C',         p.getAction('vcs.hunk_last'),         e(opt, { desc = 'Version Control: Hunk: Last' }))
m('n', '<leader>vs', p.getAction('vcs.hunk_stage'),        e(opt, { desc = 'Version Control: Hunk: Stage' }))
m('v', '<leader>vs', p.getAction('vcs.hunk_stage_lines'),  e(opt, { desc = 'Version Control: Hunk: Stage' }))
m('n', '<leader>vr', p.getAction('vcs.hunk_reset'),        e(opt, { desc = 'Version Control: Hunk: Reset' }))
m('v', '<leader>vr', p.getAction('vcs.hunk_reset_lines'),  e(opt, { desc = 'Version Control: Hunk: Reset Lines' }))
m('n', '<leader>vu', p.getAction('vcs.hunk_stage_undo'),   e(opt, { desc = 'Version Control: Hunk: Stage Undo' }))
m('n', '<leader>vp', p.getAction('vcs.hunk_preview'),      e(opt, { desc = 'Version Control: Hunk: Preview' }))
m('n', '<leader>vb', p.getAction('vcs.hunk_blame'),        e(opt, { desc = 'Version Control: Hunk: Blame' }))
m('n', '<leader>vS', p.getAction('vcs.buffer_stage'),      e(opt, { desc = 'Version Control: Buffer: Stage' }))
m('n', '<leader>vR', p.getAction('vcs.buffer_reset'),      e(opt, { desc = 'Version Control: Buffer: Reset' }))
m('n', '<leader>vb', p.getAction('vcs.toggle_blame_line'), e(opt, { desc = 'Version Control: Blame: Toggle' }))
m('n', '<leader>vd', p.getAction('vcs.diff'),              e(opt, { desc = 'Version Control: Diff: Working Tree' }))
m('n', '<leader>vD', p.getAction('vcs.diff_head'),         e(opt, { desc = 'Version Control: Diff: HEAD (last commit)' }))
m('n', '<leader>vt', p.getAction('vcs.show_deleted'),      e(opt, { desc = 'Version Control: Toggle Show Deleted' }))
