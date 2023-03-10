local config = require('warpcode.lsp.config')
require"lspconfig".vimls.setup(config.common({}))
