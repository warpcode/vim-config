local projects = {
    require 'warpcode.projects.martini',
    require 'warpcode.projects.vim-config',
}

local initialised_projects = {}

local M = {}

--- Detect a which project (if any) the specified buffer is part of
---@param buffnr number|nil
M.detect = function (buffnr)
    for _, project in pairs(projects) do
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

    if type(initialised_projects[buffnr]) == 'table' then
        return initialised_projects[buffnr]
    end
    
    local detected_project = M.detect(buffnr)
    if not detected_project then
        return nil
    end

    initialised_projects[buffnr] = detected_project

    return initialised_projects[buffnr]
end

M.get_all = function()
    M.cleanup()
    return initialised_projects
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

--- Callback to run when a buffer opens
M._autocmd_callback = function()
   local project = M.get()

   if not project then
       return
   end
end

vim.cmd([[
    au BufRead,BufNewFile * lua require 'warpcode.projects'._autocmd_callback()
]])

return M
