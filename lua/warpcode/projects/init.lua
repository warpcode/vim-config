local projects = {
    martini = require 'warpcode.projects.martini'
}

local initialised_projects = {}

local M = {}

--- Detect a which project (if any) the specified buffer is part of
---@param buffnr number|nil
M.detect = function (buffnr)
    for name, project in pairs(projects) do
        local project = project:new(buffnr)
        if project:is_project() then 
            return project
        end
    end

    return nil
end

--- Get the project for a particular buffer
M.get = function (buffnr)
    -- First cleanup any old instances
    M.cleanup()

    buffnr = buffnr or vim.api.nvim_get_current_buf()

    for i, x in pairs(initialised_projects) do
        if i == buffnr then
            return x
        end
    end
    
    local detected_project = M.detect(buffnr)
    if not detected_project then
        return nil
    end

    initialised_projects[buffnr] = detected_project

    return initialised_projects[buffnr]
end

--- Run through each instance and remove any where the buffer
--- no longer exists
M.cleanup = function ()
    for i, x in pairs(initialised_projects) do
        if not vim.api.nvim_buf_is_loaded(i) then
            initialised_projects[i] = nil
        end
    end
end

M._autocmd_callback = function()
    -- initialise an instance for the buffer
   M.get()

    -- vim.api.nvim_buf_set_var(0, 'project', function() return project end)
end

M._command_autocomplete = function()

end

vim.cmd([[
    au BufRead,BufNewFile * lua warpcode.projects._autocmd_callback()
]])
return M
