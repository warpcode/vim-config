local M = {}

M.merge_tables = function (table1, table2)
    for key, value in pairs(table2) do
        table1[key] = value
    end

    return table1
end

return M
