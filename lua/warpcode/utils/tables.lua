local M = {}

M.merge_tables = function (table1, table2)
    for key, value in pairs(table2) do
        table1[key] = value
    end

    return table1
end

M.list_diff = function (a, b)
    local aa = {}
    for k,v in pairs(a) do aa[v]=true end
    for k,v in pairs(b) do aa[v]=nil end
    local ret = {}
    local n = 0
    for k,v in pairs(a) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

M.contains = function(needle, haystack)
    if type(needle) == 'table' then
        for _, value in pairs(needle) do
            if M.contains(value, haystack) then
                return true 
            end
        end

        return false
    end

    for _, value in pairs(haystack) do
        if value == needle then
            return true 
        end
    end
    return false
end

return M
