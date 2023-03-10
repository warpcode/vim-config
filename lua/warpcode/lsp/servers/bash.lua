local config = require('warpcode.lsp.config')
require"lspconfig".bashls.setup(config.common({}))
