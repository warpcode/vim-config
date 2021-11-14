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

--- Wrapper to get a variable from vim/nvim
-- @param var Variable name
-- @param scope Variable scope
M.get_var = function(var, scope)
    if M.is_nvim() then
        return vim[scope][var]
    else
        return vim.eval(scope .. ':' .. var)
    end
end

--- Check if an executable is accessible
-- @param executable Executable to check if exists
M.has_executable = function(executable)
    return vim.fn.executable(executable) == 1
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
