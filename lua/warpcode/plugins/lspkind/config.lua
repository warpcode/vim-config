local ok, lspkind = pcall(require, 'lspkind')

return function()
    if not ok then return end

    -- lspkind.init({
    --     with_text = true,
    -- })
end
