require("plugins")
require("lsp")
require("linter")
require("formatter")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- break on specific chars only
vim.opt.linebreak = true

-- show line numbers
vim.opt.number = true

vim.opt.listchars = {
	tab = "▸ ",
	trail = "·",
	extends = "…",
	precedes = "…",
	nbsp = "␣",
	eol = "¬",
}

-- nolist
vim.opt.list = false

-- spell checking
vim.opt.spelllang = "en_us"
vim.opt.spell = true

local map = vim.keymap.set
local api = require("nvim-tree.api")

map("n", "<C-q>", "<ESC>:qall<cr>", { silent = true })
map("n", "<C-s>", "<ESC>:w<cr>", { silent = true })
map("n", '<C-t>', function() return api.tree.toggle({ focus = false }) end)
map("n", '<S-Tab>', "<ESC>:bnext<cr>")
map("n", '<C-S-Tab>', "<ESC>:bnext<cr>")

map("n", "<C-r>", vim.lsp.buf.rename,     { silent = true })
map("n", "<C-d>", vim.lsp.buf.definition, { silent = true })
map("n", "<C-e>", vim.lsp.buf.references, { silent = true })
