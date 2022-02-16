local M = {}

M.get_bufnr = function(bufnr)
    if type(buffnr) == 'number' and buffnr > 0 then
        return buffnr
    else
        return vim.api.nvim_get_current_buf()
    end
end

M.get_file_types = function (buf)
    local buffer_filetype = vim.api.nvim_buf_get_option(buf or 0, 'filetype')
    local filetypes = vim.split(buffer_filetype, '.', true)

    return filetypes
end

return M
