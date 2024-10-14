-- Set leader key
vim.g.mapleader = " "

local map = vim.keymap.set

-- Window Resizing Mappings
local resize_mappings = {
	{ "<Up>", "<cmd>resize +1<cr>" },
	{ "<Down>", "<cmd>resize -1<cr>" },
	{ "<Left>", "<cmd>vertical resize +1<cr>" },
	{ "<Right>", "<cmd>vertical resize -1<cr>" },
}
for _, keymap in ipairs(resize_mappings) do
	map("n", keymap[1], keymap[2], { desc = "Resize Window" })
end

-- Navigation Enhancements
map({ "n", "x" }, "$", "g_")

-- Visual Mode Escape Sequences
map("x", "kj", "<esc>")
map("x", "jk", "<esc>")

-- Command Mode Navigation Enhancements
local command_mode_mappings = {
	{ "<C-^>", "<Home>" },
	{ "<C-4>", "<End>" },
	{ "<C-l>", "<Right>" },
	{ "<C-f>", "<C-Right>" },
	{ "<C-h>", "<Left>" },
	{ "<C-b>", "<C-Left>" },
	{ "<C-k>", "<Up>" },
	{ "<C-j>", "<Down>" },
}
for _, keymap in ipairs(command_mode_mappings) do
	map("c", keymap[1], keymap[2])
end

-- Smooth Scrolling
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Buffer Navigation
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "H", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<m-q>", "<cmd>bd<cr>", { desc = "Close Current Buffer" })

-- Window Splitting
map("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Window Horizontally" })

-- Yank Path Mappings
local function yank_path(mode, title, fmt)
	map("n", mode, function()
		local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), fmt)
		vim.fn.setreg("+", path)
		vim.notify(path, vim.log.levels.INFO, { title = title })
	end, { silent = true, desc = title })
end

yank_path("<Leader>y", "Yanked Relative Path", ":~:.")
yank_path("<Leader>Y", "Yanked Absolute Path", ":p")

-- Enhanced Paste in Visual Mode
local paste_command = 'p:let @+=@0<CR>:let @"=@0<CR>'
map("x", "p", paste_command, { silent = true, desc = "Paste" })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste In-place" })

-- Retain Visual Mode Selection on Indentation
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
map("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Clear Search Highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

-- Smart Delete in Normal Mode
map("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end, { noremap = true, expr = true })

-- Command-line History Navigation
map("c", "<Up>", "<C-p>")
map("c", "<Down>", "<C-n>")

-- Command Abbreviations
local abbreviations = {
	{ "W", "w" },
	{ "qw", "wq" },
	{ "Wq", "wq" },
	{ "WQ", "wq" },
	{ "Qa", "qa" },
	{ "Bd", "bd" },
	{ "bD", "bd" },
}
for _, abbr in ipairs(abbreviations) do
	vim.cmd.cnoreabbrev(abbr[1], abbr[2])
end

-- Log Print Mappings
map(
	"n",
	"<leader>p",
	"<cmd>lua require('core.utils').log_print()<CR>",
	{ noremap = true, silent = true, desc = "Print" }
)
map(
	"v",
	"<leader>p",
	"<cmd>lua require('core.utils').log_print('v')<CR>",
	{ noremap = true, silent = true, desc = "Print" }
)
