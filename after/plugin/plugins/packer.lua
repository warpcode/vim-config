pcall(function()
    require "packer"

    -- Recompile when plugins are edited
    local packer_group = vim.api.nvim_create_augroup('packer', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
        command = 'PackerCompile',
        pattern = 'init.lua',
        group = packer_group
    })
end)
