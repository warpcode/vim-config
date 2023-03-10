local config = require('warpcode.lsp.config')
require"lspconfig".jsonls.setup(config.common({}))
