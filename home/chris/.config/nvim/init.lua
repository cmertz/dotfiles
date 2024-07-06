require("plugins")
require("tree")
require("diagnostics")
require("lsp")
require("format_lint")
require("completion")

local opt = vim.opt

opt.clipboard = "unnamedplus"

-- 24bit term colors
vim.o.termguicolors = true

-- give `hover` floats a border so
-- they are distinguishable from the rest
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single",
	focus = false,
  }
)

-- column for signs at the left
opt.signcolumn = 'yes'
-- TODO figure out why this is ignored
vim.cmd[[highlight SignColumn guibg=NONE]]

opt.ttyfast = true

-- disable backup and swap files
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- show line numbers
-- TODO adapt color of numbers column
opt.number = true

-- break on specific chars only
opt.linebreak = true

-- nolist
opt.list = false

-- adapt list chars
opt.listchars = {
	tab = "▸ ",
	trail = "·",
	extends = "…",
	precedes = "…",
	nbsp = "␣",
	eol = "¬",
}

-- tabs
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.tabstop = 4 -- the visible width of tabs
opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- remove the pesky `~` chars used
-- as separators
opt.fillchars = {eob = " "}

-- spell checking
opt.spelllang = "en_us"
opt.spell = false

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local map = function(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

map("n", "<C-q>", "<ESC>:qall<cr>")
map("n", "<C-s>", "<ESC>:w<cr>")
map("n", "<C-Tab>", "<ESC>:bn<cr>")
map("n", "<C-S-Tab>", "<ESC>:bp<cr>")
map("v", "<C-/>", "<ESC>:'<,'>CommentToggle<cr>")
map("n", "<C-/>", "<ESC>:CommentToggle<cr>")

-- i keep hitting `F1` by accident on some keyboards ...
map("n", "<F1>", "<nop>")
