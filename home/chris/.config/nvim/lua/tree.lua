vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
	update_focused_file = {
		enable = true,
	}
}

local api = require("nvim-tree.api")
vim.keymap.set("n", "<C-t>", function() return api.tree.toggle({ focus = false }) end, { noremap = true, silent = true })

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
  nested = false,
  callback = function(e)
    local tree = require('nvim-tree.api').tree

    -- Nothing to do if tree is not opened
    if not tree.is_visible() then
      return
    end

    -- How many focusable windows do we have? (excluding e.g. incline status window)
    local winCount = 0
    for _,winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then
        winCount = winCount + 1
      end
    end

    -- We want to quit and only one window besides tree is left
    if e.event == 'QuitPre' and winCount == 2 then
      vim.api.nvim_cmd({cmd = 'qall'}, {})
    end

    -- :bd was probably issued an only tree window is left
    -- Behave as if tree was closed (see `:h :bd`)
    if e.event == 'BufEnter' and winCount == 1 then
      -- Required to avoid "Vim:E444: Cannot close last window"
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last buffer used before closing
        tree.toggle({find_file = true, focus = true})
        -- re-open nivm-tree
        tree.toggle({find_file = true, focus = false})
      end, 10)
    end
  end
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

