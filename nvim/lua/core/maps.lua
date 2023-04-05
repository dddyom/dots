vim.g.mapleader = " "
local opts = { silent = true }
local map = vim.keymap.set
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "n", "nzzzv")
map("n", "n", "nzzzv")
map("i", "<c-l>", "<esc>la") -- bend over the bracket
map("n", "<esc><esc>", "<esc>:nohlsearch<cr>", opts)

map("c", "<c-a>", "<home>", {})
map("c", "<c-e>", "<end>", {})

map('n', '<cr>', '@="m`o<c-v><esc>``"<cr>')
map('n', '<S-cr>', '@="m`o<c-v><esc>``"<cr>')

