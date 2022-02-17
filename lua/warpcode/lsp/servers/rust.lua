local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end
-- -- who even uses this?
-- require("lspconfig").rust_analyzer.setup(config({}))

