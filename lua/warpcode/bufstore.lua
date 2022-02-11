local M = {}
local store = {}

M.get = function (buf)
    M.cleanup_all()
    if type(buf) ~= 'number' then
        buf = vim.api.nvim_get_current_buf()
    end

    if store[buf] == nil then
        return {}
    end

    return store[buf]
end

M.get_all = function ()
    M.cleanup_all()
    return store
end

M.set = function (table, buf)
    M.cleanup_all()
    if type(buf) ~= 'number' then
        buf = vim.api.nvim_get_current_buf()
    end

    store[buf] = table or {}
end

M.cleanup = function (buf)
    if type(buf) ~= 'number' then
        buf = vim.api.nvim_get_current_buf()
    end

    if not vim.api.nvim_buf_is_loaded(buf) then
        store[buf] = nil
    end
end

M.cleanup_all = function ()
    for i, _ in pairs(store) do
        M.cleanup(i)
    end
end

return M
