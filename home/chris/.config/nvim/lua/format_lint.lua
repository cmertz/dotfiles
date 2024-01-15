local ft = require('guard.filetype')

ft('go'):fmt('lsp'):lint('golangci_lint')

require('guard').setup({
	fmt_on_save = true,
})
