require("plugins")
require("lsp")
require("linter")
require("formatter")
require("completion")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 24bit term colors
vim.o.termguicolors = true

local opt = vim.opt

opt.ttyfast = true

-- disable backup files
opt.backup = false
opt.writebackup = false

-- break on specific chars only
opt.linebreak = true

-- show line numbers
opt.number = true

-- no line wrapping
opt.wrap = false

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

-- nolist
opt.list = false

-- spell checking
opt.spelllang = "en_us"
opt.spell = false

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local map = function(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

local api = require("nvim-tree.api")

map("n", "<C-q>", "<ESC>:qall<cr>")
map("n", "<C-s>", "<ESC>:w<cr>")
map("n", "<C-t>", function() return api.tree.toggle({ focus = false }) end)
map("n", "<C-Tab>", "<ESC>:bn<cr>")
map("n", "<C-S-Tab>", "<ESC>:bp<cr>")

map("n", "<C-r>", vim.lsp.buf.rename)
map("n", "<C-d>", vim.lsp.buf.definition)
map("n", "<C-e>", vim.lsp.buf.references)
