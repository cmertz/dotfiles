local ft = require('guard.filetype')

ft('go'):fmt('gofumpt'):append('golines'):lint('golangci_lint')
ft('sh'):fmt('shfmt'):lint('shellcheck')
ft('dockerfile'):lint('hadolint')
ft('python'):fmt('ruff'):lint('ruff')

vim.g.guard_config = {
    fmt_on_save = true,
    lsp_as_default_formatter = true,
    save_on_fmt = true,
}

vim.api.nvim_create_autocmd({ "BufWrite" }, {
  pattern = { "go" , "sh", "dockerfile", "python" },
  callback = function(args)
    require('guard.format').do_fmt(args.buf)
  end
})
