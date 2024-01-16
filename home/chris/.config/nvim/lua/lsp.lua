-- time it takes to trigger the `CursorHold` event
vim.opt.updatetime = 400

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		vim.keymap.set("i", "<C-Space>", "<C-x><C-o>",       { buffer = event.buf })
		vim.keymap.set("n", "<C-d>", vim.lsp.buf.definition, { buffer = event.buf })
		vim.keymap.set("n", "<C-r>", vim.lsp.buf.rename,     { buffer = event.buf })
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Setup highlight symbol",
	callback = function(event)
		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil or not client.supports_method("textDocument/documentHighlight") then
			return
		end

		local group = vim.api.nvim_create_augroup("highlight_symbol", {clear = false})

		vim.api.nvim_clear_autocmds({buffer = event.buf, group = group})

		vim.api.nvim_create_autocmd("CursorHold", {
			group = group,
			buffer = event.buf,
			callback = function()
				vim.lsp.buf.document_highlight()
				vim.lsp.buf.hover()
			end,
		})

		vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
			group = group,
			buffer = event.buf,
			callback = vim.lsp.buf.clear_references,
		})
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

-- actual lsp client setup
local lsp = require("lspconfig")
local caps = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())

lsp.gopls.setup({
	capabilities = caps
})
