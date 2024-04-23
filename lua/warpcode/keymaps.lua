local pexec = require('warpcode.utils.priority-exec')
local opt = { noremap = true, silent = true }
local m = vim.keymap.set
local e = function (...)
  return vim.tbl_deep_extend('force', ...)
end


-- [[ Buffers ]]
pexec.addCall('buffers.browse', function() vim.api.nvim_input ':buffers<CR>' end, 0)
pexec.addCall('buffers.next', function() vim.api.nvim_input ':bn<CR>' end, 0)
pexec.addCall('buffers.previous', function() vim.api.nvim_input ':bp<CR>' end, 0)
pexec.addCall('buffers.close', function() vim.api.nvim_input ':bp <BAR> bd #<cr>' end, 0)

-- { "n", "<leader>ds", vim.diagnostic.open_float },
m('n', '[b',         function() pexec.exec('buffers.previous') end, e(opt, { desc = 'Buffers: Previous Buffer' }))
m('n', ']b',         function() pexec.exec('buffers.next') end,     e(opt, { desc = 'Buffers: Next Buffer' }))
m('n', '<leader>bb', function() pexec.exec('buffers.browse') end,   e(opt, { desc = 'Buffers: Browse Buffers' }))
m('n', "<leader>bq", function() pexec.exec('buffers.close') end,    e(opt, { desc = 'Buffers: Close Buffer' }) )

-- [[ Clipboard ]]
m('v',          '<leader>p', '"_dP',        e(opt, { desc = 'Clipboard: Paste (no copy)' }))
m({ 'n', 'v' }, '<leader>d', '"_d',         e(opt, { desc = 'Clipboard: Delete (no copy)' }))
m('n',          '<leader>Y', 'gg"+yG<C-o>', e(opt, { desc = 'Clipboard: Copy buffer contents' }))
m('n',          'Y',         'yg_',         e(opt, { desc = 'Clipboard: Copy to endof line'}))
m('n',          'gV',        '`[v`]',       e(opt, { desc = 'Clipboard: Copy last paste'}))

-- [[ Debug ]]
pexec.addCall('debug.breakpoint_toggle', function() end)
pexec.addCall('debug.breakpoint_conditional', function() end)
pexec.addCall('debug.continue', function() end)
pexec.addCall('debug.terminate', function() end)
pexec.addCall('debug.step_over', function() end)
pexec.addCall('debug.step_into', function() end)
pexec.addCall('debug.step_out', function() end)

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

m("n", "<leader>dt", function() pexec.exec('debug.breakpoint_toggle') end,      e(opt, { desc = 'Debug: Breaktpoint Toggle' }))
m("n", "<leader>dT", function() pexec.exec('debug.breakpoint_conditional') end, e(opt, { desc = 'Debug: Breakpoint Conditional' }))
m("n", "<leader>dc", function() pexec.exec('debug.continue') end,               e(opt, { desc = 'Debug: Continue' }))
m("n", "<leader>dC", function() pexec.exec('debug.terminate') end,              e(opt, { desc = 'Debug: Terminate' }))
m("n", "<leader>do", function() pexec.exec('debug.step_over') end,              e(opt, { desc = 'Debug: Step Over' }))
m("n", "<leader>di", function() pexec.exec('debug.step_into') end,              e(opt, { desc = 'Debug: Step Into' }))
m("n", "<leader>dI", function() pexec.exec('debug.step_out') end,               e(opt, { desc = 'Debug: Step Out' }))

-- [[ Diagnostics ]]
pexec.addCall('diagnostics.next', function() vim.diagnostic.goto_next() end, 0)
pexec.addCall('diagnostics.prev', function() vim.diagnostic.goto_prev() end, 0)
pexec.addCall('diagnostics.buffer', function() vim.diagnostic.setloclist() end, 0)
pexec.addCall('diagnostics.workspace', function() vim.diagnostic.setqflist() end, 0)

-- { "n", "<leader>ds", vim.diagnostic.open_float },
m("n", "[d",         function() pexec.exec('diagnostics.prev') end,      e(opt, { desc = 'Diagnostics: Previous' }))
m("n", "]d",         function() pexec.exec('diagnostics.next') end,      e(opt, { desc = 'Diagnostics: Next' }))
m("n", "<leader>db", function() pexec.exec('diagnostics.buffer') end,    e(opt, { desc = 'Diagnostics: Show Buffer' }))
m("n", "<leader>dw", function() pexec.exec('diagnostics.workspace') end, e(opt, { desc = 'Diagnostics: Show Workspace' }))

-- [[ Filesystem ]]
pexec.addCall('fs.file_tree', function() vim.cmd 'Lexplore' end, 0)
pexec.addCall('fs.find_buffer', function() vim.api.nvim_input ':let @/=expand("%:t") <Bar> execute \'Lexplore\' expand("%:h") <Bar> normal n<CR>' end, 0)
pexec.addCall('fs.find_files', function() vim.api.nvim_input ':find ' end, 0)
pexec.addCall('fs.find_recent_files', function() vim.api.nvim_input ":oldfiles<CR>" end, 0)

m("n", "<leader>ft", function() pexec.exec('fs.file_tree') end,         e(opt, { desc = 'FS: File Tree' }))
m("n", "<leader>fb", function() pexec.exec('fs.find_buffer') end,       e(opt, { desc = 'FS: Find Buffer in File Tree' }))
m("n", "<leader>ff", function() pexec.exec('fs.find_files') end,        e(opt, { desc = 'FS: Find Files' }))
m("n", "<leader>fr", function() pexec.exec('fs.find_recent_files') end, e(opt, { desc = 'FS: Find Recent Files' }))

-- [[ History ]]
-- Add additional undo breakpoints
m('i', ',', ',<c-g>u', opt)
m('i', '.', '.<c-g>u', opt)
m('i', '!', '!<c-g>u', opt)
m('i', '?', '?<c-g>u', opt)

-- [[ LSP ]]
m({ 'n', 'v' }, '<leader>ca', function() pexec.exec('lsp.code_action') end,             e(opt, { desc = 'LSP: Code Actions'}))
m("n",          "gD",         function() pexec.exec('lsp.declaration') end,             e(opt, { desc = 'LSP: Go to Declaration'}))
m("n",          "gd",         function() pexec.exec('lsp.definition') end,              e(opt, { desc = 'LSP: Go to Definition'}))
m({ "n", 'x' }, "<leader>=",  function() pexec.exec('lsp.format') end,                  e(opt, { desc = 'LSP: Format'}))
m("n",          "K",          function() pexec.exec('lsp.hover') end,                   e(opt, { desc = 'LSP: Hover Documentation'}))
m("n",          "gi",         function() pexec.exec('lsp.implementation') end,          e(opt, { desc = 'LSP: Go to Implementation'}))
m("n",          "gr",         function() pexec.exec('lsp.references') end,              e(opt, { desc = 'LSP: Go to References'}))
m("n",          "<leader>rn", function() pexec.exec('lsp.rename') end,                  e(opt, { desc = 'LSP: Rename'}))
m("n",          "<C-k>",      function() pexec.exec('lsp.signature_help') end,          e(opt, { desc = 'LSP: Signature Help'}))
m('n',          '<leader>D',  function() pexec.exec('lsp.type_definition') end,         e(opt, { desc = 'LSP: Type Definition'}))
m("n",          "<space>wa",  function() pexec.exec('lsp.add_workspace_folder') end,    e(opt, { desc = 'LSP: Add Workspace Folder'}))
m("n",          "<space>wr",  function() pexec.exec('lsp.remove_workspace_folder') end, e(opt, { desc = 'LSP: Remove Workspace Folder'}))
m("n",          "<space>wl",  function() pexec.exec('lsp.list_workspace_folders') end,  e(opt, { desc = 'LSP: List Workspace folders'}))


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
pexec.addCall('search.file_contents', function() vim.api.nvim_input(':vimgrep //j ** <BAR> cw' .. string.rep('<left>', 10)) end, 0)

m('n', '<leader>/',  function() vim.cmd(':noh') end ,                   e(opt, { desc = 'Search: Clear Buffer Search' }))
m("n", "<leader>ss", function() pexec.exec('search.file_contents') end, e(opt, { desc = 'Search: Search File Contents' }))
