local M = {}

--- Run a command
-- @param command Command to run
-- @return Native return of the parent command
M.cmd = function(command)
    if vim.cmd then
        return vim.cmd(command)
    else
        return vim.command(command)
    end
end

--- Check whether we are in neovim
-- @return bool
M.is_nvim = function()
    return vim.fn.has('nvim') == 1
end

--- Check whether we are in vim
-- @return bool
M.is_vim = function()
    return not M.is_nvim()
end

return M
