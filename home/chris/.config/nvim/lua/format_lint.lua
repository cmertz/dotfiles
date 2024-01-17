local ft = require('guard.filetype')

ft('go'):fmt('lsp'):lint('golangci_lint')
ft('sh'):fmt('shfmt'):lint('shellcheck')
ft('dockerfile'):lint('hadolint')

require('guard').setup({
	fmt_on_save = true,
})
