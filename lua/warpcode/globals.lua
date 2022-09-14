local M = {}

M.P = function (...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end

M.RELOAD = function (...)
    return require 'plenary.reload'.reload_module(...)
end

M.R = function (name)
    RELOAD(name)
    return require(name)
end

_G.warpcode = M
