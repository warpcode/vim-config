local bufstore = require 'warpcode.bufstore'
local projects = {
    require 'warpcode.projects.martini',
    require 'warpcode.projects.vim-config',
}

local M = {}

--- Detect a which project (if any) the specified buffer is part of
---@param buffnr number|nil
M.detect = function (buffnr)
    for _, project in pairs(projects) do
        local project = project(buffnr)
        if project:is_project() then 
            return project
        end
    end

    return nil
end

--- Get the project for a particular buffer
M.get = function (buffnr)
    buffnr = buffnr or vim.api.nvim_get_current_buf()

    local bufconfig = bufstore.get(buffnr)

    if bufconfig['detect_project'] == nil then
        local detected_project = M.detect(buffnr)

        if not detected_project then
            return nil
        end

        bufconfig['detect_project'] = detected_project

        bufstore.set(bufconfig, buffnr)
    end
    
    return bufconfig['detect_project']
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
