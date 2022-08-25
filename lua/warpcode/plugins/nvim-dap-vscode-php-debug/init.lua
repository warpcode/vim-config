-- Basic git repo where the vscode php debugger lives
-- It simply downloads and builds.
-- This is not a genuine nvim plugin, just a js library

local M = {
    source = 'xdebug/vscode-php-debug',
    run = 'npm i && npm run build',
}

return M
