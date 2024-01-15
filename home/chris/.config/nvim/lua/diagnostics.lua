vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = {"n:i", "v:s"},
	desc = "Disable diagnostics in insert and select mode",
	callback = function(e) vim.diagnostic.disable(e.buf) end
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "i:n",
	desc = "Enable diagnostics when leaving insert mode",
	callback = function(e) vim.diagnostic.enable(e.buf) end
})

vim.diagnostic.config({
	-- suppress text for errors / warnings
	virtual_text =  false,

	float = {
		header = false,
		border = "single",
		-- only makes sense as long as the contents of
		-- the `float`s are reasonably short - we won't
		-- have means to scroll through otherwise
		focusable = false,
		focus = false,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})
