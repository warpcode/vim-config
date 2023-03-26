pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'intelephense',
        lspconfig = 'intelephense',
        config = function()
            local conf = {
                init_options = {}
            }

            local licenceKeyFile = vim.fn.expand('~/intelephense/licence.key')
            local f = io.open(licenceKeyFile, "rb")
            if f ~= nil then
                -- Read a single line to get the key
                conf.init_options.licenceKey = f:read "*l"
                f:close()
            end

            return conf
        end
    }
end)
