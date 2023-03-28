vim.g.mapleader = " "
local opts = { silent = true }
local map = vim.keymap.set

-- map("v", "k", ":m '<-2<cr>gv=gv")-- move selected
-- map("v", "j", ":m '>+1<cr>gv=gv") -- move selected

map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "n", "nzzzv")
map("n", "n", "nzzzv")

map("i", "<c-l>", "<esc>la") -- bend over the bracket
map("n", "<esc><esc>", "<esc>:nohlsearch<cr>", opts)
-- map("n", "x", '"_x') -- drop symbol without copy to clipboard


map("n", "<s-h>", ':bprevious<cr>', opts) -- go to previous buffer 
map("n", "<s-l>", ':bnext<cr>', opts) -- go to next buffer

map("c", "<c-a>", "<home>", {})
map("c", "<c-e>", "<end>", {})

map('n', '<cr>', '@="m`o<c-v><esc>``"<cr>')
map('n', '<s-cr>', '@="m`o<c-v><esc>``"<cr>')

