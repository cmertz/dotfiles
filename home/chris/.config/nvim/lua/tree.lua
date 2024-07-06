vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
	update_focused_file = {
		enable = true,
	}
}

local api = require("nvim-tree.api")
vim.keymap.set("n", "<C-t>", function() return api.tree.toggle({ focus = false }) end, { noremap = true, silent = true })

-- make sure nvim-tree does not stay
-- as last and only window when quitting
vim.api.nvim_create_autocmd({"QuitPre"}, {
	callback = function() vim.cmd("NvimTreeClose") end,
})


-- focus node for currently open
-- file in tree if we can find one
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function(data)
		if vim.fn.filereadable(data.file) ~= 1 then
			return
		end

		if data.file == "" and vim.bo[data.buf].buftype == "" then
			return
		end

		require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
	end,
})

