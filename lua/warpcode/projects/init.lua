local projects = {
    martini = require 'warpcode.projects.martini'
}

local M = {}

M.detect_project = function (file)
    for name, project in pairs(projects) do
        if M.has(name) then
            local project = project:from_file(file)
            
            if project:is_project() then 
                return project
            end
        end
    end

    return nil
end

M.has = function (project, path)
    return projects[project] ~= nil
end

M._autocmd_callback = function()
    -- if vim.bo.filetype == '' or not vim.bo.filetype then 
    --     vim.bo.filetype = 'ruby'
    -- end
end

M._command_autocomplete = function()

end

vim.cmd([[
    au BufRead,BufNewFile * lua warpcode.projects._autocmd_callback()
]])
return M
