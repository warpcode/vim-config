local buffers = require 'warpcode.utils.buffers'
local M = {}
local store = {}

M.get = function (bufnr)
    M.cleanup_all()
    local buf = buffers.get_bufnr(bufnr)
    if store[buf] == nil then
        return {}
    end

    return store[buf]
end

M.get_all = function ()
    M.cleanup_all()
    return store
end

M.set = function (table, bufnr)
    M.cleanup_all()
    local buf = buffers.get_bufnr(bufnr)
    store[buf] = table or {}
end

M.cleanup = function (bufnr)
    local buf = buffers.get_bufnr(bufnr)
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
