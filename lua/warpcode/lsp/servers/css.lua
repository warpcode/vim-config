local config = require('warpcode.lsp.config')
require"lspconfig".cssls.setup(config.common({}))
