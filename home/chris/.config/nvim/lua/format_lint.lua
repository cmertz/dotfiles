local ft = require('guard.filetype')

ft('go'):fmt({
	cmd = 'goimports',
	stdin = true
}):append('gofumpt')
ft('sh'):fmt('shfmt'):lint('shellcheck')
ft('dockerfile'):lint('hadolint')
ft('python'):fmt('ruff'):lint('ruff')

vim.g.guard_config = {
	fmt_on_save = true,
	save_on_fmt = true,
	lsp_as_default_formatter = true,
}

vim.api.nvim_create_autocmd({ "BufWrite" }, {
  pattern = { "go", "sh", "dockerfile", "python" },
  callback = function(args)
    require('guard.format').do_fmt(args.buf)
  end
})
