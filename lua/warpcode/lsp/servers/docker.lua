local config = require('warpcode.lsp.config')
require"lspconfig".dockerls.setup(config.common({}))
