-- time it takes to trigger the `CursorHold` event
vim.opt.updatetime = 400

-- lsp log seems to grow unbounded
-- we can still turn it on when actually
-- needed
vim.lsp.set_log_level("off")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		vim.keymap.set("i", "<C-Space>", "<C-x><C-o>",       { buffer = event.buf })
		vim.keymap.set("n", "<C-d>", vim.lsp.buf.definition, { buffer = event.buf })
		vim.keymap.set("n", "<C-r>", vim.lsp.buf.rename,     { buffer = event.buf })
		vim.keymap.set("n", "<C-e>", vim.lsp.buf.references, { buffer = event.buf })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover,      { buffer = event.buf })
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Setup lsp highlights",
	callback = function(event)
		vim.api.nvim_set_hl(0, "LspReferenceRead",  {link = "Search"})
		vim.api.nvim_set_hl(0, "LspReferenceText",  {link = "Search"})
		vim.api.nvim_set_hl(0, "LspReferenceWrite", {link = "Search"})
	end
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
	}
)

-- actual lsp client setup
local lsp = require("lspconfig")
local caps = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())

lsp.gopls.setup({
	capabilities = caps
})

lsp.marksman.setup({
	capabilities = caps
})

lsp.pyright.setup({
	capabilities = caps
})

lsp.terraformls.setup({
	capabilities = caps
})
