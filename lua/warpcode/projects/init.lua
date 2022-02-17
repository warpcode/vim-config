local bufstore = require 'warpcode.bufstore'
local buffers = require 'warpcode.utils.buffers'
local wtables = require 'warpcode.utils.tables'
local projects = {
    require 'warpcode.projects.martini',
    require 'warpcode.projects.vim-config',
}

local M = {}

local detect_all = function (buffnr)
    local buf = buffers.get_bufnr(buffnr)

    if not vim.api.nvim_buf_is_valid(buf) then
        return {}
    end
    
    local list = {}

    for _, project in pairs(projects) do
        local p = project(buf)
        if p:is_project() then 
            list[p:get_project_name(true)] = p
        end
    end

    return list
end

local call_all = function (method, ...)
    local projects = M.get_all()

    local return_values = {}
    for i,v in pairs(projects) do
        local status, result = pcall(v[method], v, unpack({...}))
        if status then
            -- if the method doesn't exist, we don't have anything to return
            return_values[i] = result
        end
    end

    return return_values
end

M.get_filetypes = function (filetypes)
    local results = call_all('get_filetypes', filetypes)
    local merged_lists = wtables.list_extend(wtables.table_unpack(results))

    return wtables.list_unique(merged_lists)
end

M.get_all = function (buffnr)
    local buf = buffers.get_bufnr(buffnr)
    local bufconfig = bufstore.get(buf)

    if bufconfig['projects'] == nil then
        local detected_projects = detect_all(buf)
        bufconfig['projects'] = detected_projects
        bufstore.set(bufconfig, buf)
    end

    -- TODO deregister and remove projects that no longer match
    return bufconfig['projects'] or {}
end

M.get_by_slug = function (buffnr, slug)
    local projects = M.get_all(buffnr)

    return projects[slug]
end

--- Callback to run when a buffer opens
M._autocmd_callback = function()
    M.get_all()
end

vim.cmd([[
    au BufRead,BufNewFile * lua require 'warpcode.projects'._autocmd_callback()
]])

return M
