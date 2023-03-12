-- vim.lsp.set_log_level("debug")

local format_diagnostic = function(diagnostic)
    return string.format('[%s] %s', diagnostic.source, diagnostic.message)
end

vim.diagnostic.config({
    float = {
        format = format_diagnostic,
    },
    virtual_text = {
        format = format_diagnostic,
    },
})

