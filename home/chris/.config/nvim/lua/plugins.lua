local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- lsp client config snippets
	-- for common lsp servers
	{
		"neovim/nvim-lspconfig",
	},

	-- format+lint - has a really nice
	-- way of configuring (i.e. fluent interface api)
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
	},

	-- smallest plugin i've found to drive
	-- autocomplete while typing
	{
		"nvimdev/epo.nvim",
	},

	-- colorscheme
	{
		"calind/selenized.nvim",
		config = function()
			vim.cmd.colorscheme("selenized")
		end,
	},

	-- bar with tabs for open buffers
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
							separator = true
						}
					}
				}
			})
		end,
	},

	-- tree navigator plugin
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- finder plugin
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<C-f>", ":Telescope<CR>", { noremap = true, silent = true })
		end
	},
})
