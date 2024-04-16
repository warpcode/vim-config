local M = {}

M.get_plugin_name_from_path = function (path)
    local new_name = vim.fn.matchstr(path, '[/\\\\]\\zs[^/\\\\]\\+$')
    return vim.fn.substitute(new_name, '\\C\\.git$', '', '')
end

M.get_plugin_path = function (plugin)
    for _,p in pairs(vim.api.nvim_list_runtime_paths()) do
        if M.get_plugin_name_from_path(p) == plugin then
            return p
        end
    end

    return nil
end

return M
