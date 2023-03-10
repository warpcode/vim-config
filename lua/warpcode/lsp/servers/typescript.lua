local config = require('warpcode.lsp.config')
require"lspconfig".tsserver.setup(config.common({}))
