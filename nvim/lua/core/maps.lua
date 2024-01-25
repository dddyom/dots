vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<Up>", "<cmd>resize +1<cr>", { desc = "Resize Window" })
map("n", "<Down>", "<cmd>resize -1<cr>", { desc = "Resize Window" })
map("n", "<Left>", "<cmd>vertical resize +1<cr>", { desc = "Resize Window" })
map("n", "<Right>", "<cmd>vertical resize -1<cr>", { desc = "Resize Window" })

map("n", "]", "n")
map("n", "[", "N")
map("n", ";", ":")
map({ "n", "x" }, "$", "g_")

map({ "i", "x" }, "kj", "<esc>")
map({ "i", "x" }, "jk", "<esc>")

map("c", "<C-h>", "<Home>")
map("c", "<C-l>", "<End>")
map("c", "<C-f>", "<Right>")
map("c", "<C-b>", "<Left>")

map("n", "L", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "H", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "bl", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "bh", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "b]", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "b[", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "<m-q>", "<cmd>lua require('core.utils').close()<cr>", { desc = "close current buffer" })

map("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "split window horisontally" })

map("n", '<leader>"', [[i""""""<esc>hhi<cr><esc>kA<cr>]], { desc = "triple quotes" })
map("v", '<leader>"', [[c""""""<esc>hhi<cr><esc>i<c-r>"<esc>k$]], { desc = "triple quotes" })
map("v", "<leader>d", [[:s/^[ \t]*$\n//<CR>]], { desc = "delete empty lines" })

map("n", "<Leader>y", function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, { title = "Yanked relative path" })
end, { silent = true, desc = "Yank relative path" })

-- Yank absolute path
map("n", "<Leader>Y", function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, { title = "Yanked absolute path" })
end, { silent = true, desc = "Yank absolute path" })

map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste" })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste In-place" })

map("x", "<Tab>", ">gv|", { desc = "Indent Left" })
map("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

map("n", "<TAB>", "<C-^>", { desc = "Prev buffer" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })
map("n", "\\", "m", { desc = "set mark" })

map({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

map("n", "!", ":sp term://", { desc = "Execute Shell Command" })

map("c", "<Up>", "<C-p>")
map("c", "<Down>", "<C-n>")

-- Allow misspellings
vim.cmd.cnoreabbrev("qw", "wq")
vim.cmd.cnoreabbrev("Wq", "wq")
vim.cmd.cnoreabbrev("WQ", "wq")
vim.cmd.cnoreabbrev("Qa", "qa")
vim.cmd.cnoreabbrev("Bd", "bd")
vim.cmd.cnoreabbrev("bD", "bd")
