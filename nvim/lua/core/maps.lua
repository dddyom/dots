vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<Up>", "<cmd>resize +1<cr>", { desc = "Resize Window" })
map("n", "<Down>", "<cmd>resize -1<cr>", { desc = "Resize Window" })
map("n", "<Left>", "<cmd>vertical resize +1<cr>", { desc = "Resize Window" })
map("n", "<Right>", "<cmd>vertical resize -1<cr>", { desc = "Resize Window" })

map({ "n", "x" }, "$", "g_")

map({ "x" }, "kj", "<esc>")
map({ "x" }, "jk", "<esc>")

map("c", "<C-^>", "<Home>")
map("c", "<C-4>", "<End>")
map("c", "<C-l>", "<Right>")
map("c", "<C-f>", "<C-Right>")
map("c", "<C-h>", "<Left>")
map("c", "<C-b>", "<C-Left>")
map("c", "<C-k>", "<Up>")
map("c", "<C-j>", "<Down>")

map("n", "L", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "H", "<cmd>bprevious<cr>", { desc = "previous buffer" })
map("n", "<m-q>", "<cmd>bd<cr>", { desc = "close current buffer" })

map("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "split window horisontally" })

map("n", "<Leader>y", function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, { title = "Yanked relative path" })
end, { silent = true, desc = "Yank relative path" })

map("n", "<Leader>Y", function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, { title = "Yanked absolute path" })
end, { silent = true, desc = "Yank absolute path" })

map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste" })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste In-place" })

map("x", "<Tab>", ">gv|", { desc = "Indent Left" })
map("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

map("c", "<Up>", "<C-p>")
map("c", "<Down>", "<C-n>")

vim.cmd.cnoreabbrev("qw", "wq")
vim.cmd.cnoreabbrev("Wq", "wq")
vim.cmd.cnoreabbrev("WQ", "wq")
vim.cmd.cnoreabbrev("Qa", "qa")
vim.cmd.cnoreabbrev("Bd", "bd")
vim.cmd.cnoreabbrev("bD", "bd")
-- stylua: ignore
map("n", "<leader>p", "<cmd>lua require('core.utils').log_print()<CR>", { noremap = true, silent = true, desc = "Print" })
-- stylua: ignore
map("v", "<leader>p", "<cmd>lua require('core.utils').log_print('v')<CR>", { noremap = true, silent = true, desc = "Print" })
