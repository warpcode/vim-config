-- if bin_phpactor then 
--     lspconfig.phpactor.setup(config.common({
--         cmd = {bin_phpactor, 'language-server'},
--     }))
-- end

local config = require('warpcode.lsp.config')
require"lspconfig".intelephense.setup(config.common({}))
