local lspkind_status, lspkind = pcall(require, 'lspkind')

if (not lspkind_status) then  
    return
end

-- lspkind.init({
--     with_text = true,
-- })
