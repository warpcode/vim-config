local config = require('warpcode.lsp.config')
require"lspconfig".rust_analyzer.setup(config.common({}))
