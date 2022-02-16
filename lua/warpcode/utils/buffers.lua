local M = {}

M.get_file_types = function (buf)
    local buffer_filetype = vim.api.nvim_buf_get_option(buf or 0, 'filetype')
    local filetypes = vim.split(buffer_filetype, '.', true)

    return filetypes
end

return M
