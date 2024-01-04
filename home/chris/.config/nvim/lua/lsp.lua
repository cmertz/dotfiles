local lsp = require("lspconfig")
local cap = require('cmp_nvim_lsp').default_capabilities()

lsp.gopls.setup({
	capabilities = cap
})
