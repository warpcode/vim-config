local M = {}

M.merge_tables = function (table1, table2)
    for key, value in pairs(table2) do
        table1[key] = value
    end

    return table1
end

-- Force the provided var to be a list table
M.list_force = function (a)
    if type(a) == 'table' then
        return a
    end

    return {a}
end

M.list_diff = function (a, b)
    local aa = {}
    for k,v in pairs(M.list_force(a)) do 
        aa[v]=true 
    end
    for k,v in pairs(M.list_force(b)) do 
        aa[v]=nil 
    end
    local ret = {}
    local n = 0
    for k,v in pairs(M.list_force(a)) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

M.list_extend = function (a, b)
    local table1 = vim.deepcopy(M.list_force(a))
    local table2 = vim.deepcopy(M.list_force(b))

    vim.list_extend(table1, table2)
    return table1
end

M.list_unique = function(a)
    local hash = {}
    local res = {}

    for _, v in ipairs(M.list_force(a)) do
        if type(v) == 'table' then
            -- Just re-add tables. This function should only be used
            -- for simple lists
            res[#res+1] = v
        elseif (not hash[v]) then
            res[#res+1] = v
            hash[v] = true
        end
    end

    return res
end

M.list_each = function (list, callback)
    if type(callback) ~= 'function' then
        error('Callback is not a function')
    end

    for _, v in pairs(M.list_force(list)) do
        callback(v)
    end
end

M.contains = function (needle, haystack)
    if type(needle) == 'table' then
        for _, value in pairs(needle) do
            if M.contains(value, haystack) then
                return true 
            end
        end

        return false
    end

    for _, value in pairs(M.list_force(haystack)) do
        if value == needle then
            return true 
        end
    end
    return false
end

return M
