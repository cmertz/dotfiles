require("plugins")
require("lsp")
require("linter")
require("formatter")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- disable backup files
opt.backup = false
opt.writebackup = false

-- break on specific chars only
opt.linebreak = true

-- show line numbers
opt.number = true

opt.listchars = {
	tab = "▸ ",
	trail = "·",
	extends = "…",
	precedes = "…",
	nbsp = "␣",
	eol = "¬",
}

-- nolist
opt.list = false

-- spell checking
opt.spelllang = "en_us"
opt.spell = true

local map = function(mode, lhs, rhs) 
	vim.keymap.set(mode, lhs, rhs, { silent = true })
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
