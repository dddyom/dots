vim.g.mapleader = " "
local map = vim.keymap.set

map("i", "jk", "<esc>")
map("i", "kj", "<esc>")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "n", "nzzzv")
map("n", "n", "nzzzv")
map("i", "<c-l>", "<esc>la") -- bend over the bracket
map("n", "<esc><esc>", "<esc>:nohlsearch<cr>", { silent = true })

map("c", "<c-a>", "<home>")
map("c", "<c-e>", "<end>")

map('n', '<cr>', '@="m`o<c-v><esc>``"<cr>')
map('n', '<S-cr>', '@="m`o<c-v><esc>``"<cr>')
