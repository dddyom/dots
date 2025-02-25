-----------------------------------------------------------------------------
-- Установка клавиши `<Leader>`
-----------------------------------------------------------------------------
vim.g.mapleader = " "
local map = vim.keymap.set

-----------------------------------------------------------------------------
-- Изменение размеров окон
-----------------------------------------------------------------------------
local resize_mappings = {
	{ "<C-Up>", "<cmd>resize +1<cr>" },
	{ "<C-Down>", "<cmd>resize -1<cr>" },
	{ "<C-Left>", "<cmd>vertical resize +1<cr>" },
	{ "<C-Right>", "<cmd>vertical resize -1<cr>" },
}
for _, keymap in ipairs(resize_mappings) do
	map("n", keymap[1], keymap[2], { desc = "Resize Window" })
end

-----------------------------------------------------------------------------
-- Улучшенная навигация
-----------------------------------------------------------------------------
map({ "n", "x" }, "$", "g_") -- Двигаться до последнего символа, а не до конца строки
map("x", "kj", "<esc>") -- Альтернативный выход из визуального режима
map("x", "jk", "<esc>")

-----------------------------------------------------------------------------
-- Улучшенная навигация в командном режиме
-----------------------------------------------------------------------------
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

-----------------------------------------------------------------------------
-- Плавный скроллинг
-----------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-----------------------------------------------------------------------------
-- Разделение окон
-----------------------------------------------------------------------------
map("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Window Horizontally" })

-----------------------------------------------------------------------------
-- Копирование пути текущего файла
-----------------------------------------------------------------------------
local function yank_path(mode, title, fmt)
	map("n", mode, function()
		local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), fmt)
		vim.fn.setreg("+", path)
		vim.notify(path, vim.log.levels.INFO, { title = title })
	end, { silent = true, desc = title })
end

yank_path("<Leader>y", "Yanked Relative Path", ":~:.")
yank_path("<Leader>Y", "Yanked Absolute Path", ":p")

-----------------------------------------------------------------------------
-- Улучшенное поведение вставки в визуальном режиме
-----------------------------------------------------------------------------
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste" })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste In-place" })

-----------------------------------------------------------------------------
-- Сохранение выделения при изменении отступов
-----------------------------------------------------------------------------
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
map("v", "<Tab>", ">gv", { noremap = true, silent = true })

-----------------------------------------------------------------------------
-- Очищение подсветки поиска
-----------------------------------------------------------------------------
map("n", "<Esc><Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

-----------------------------------------------------------------------------
-- Умное удаление строк
-----------------------------------------------------------------------------
map("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end, { noremap = true, expr = true })

-----------------------------------------------------------------------------
-- История команд в командном режиме
-----------------------------------------------------------------------------
map("c", "<Up>", "<C-p>")
map("c", "<Down>", "<C-n>")

-----------------------------------------------------------------------------
-- Автоматические сокращения команд
-----------------------------------------------------------------------------
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

-----------------------------------------------------------------------------
-- Логирование и печать через `core.utils`
-----------------------------------------------------------------------------
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

-----------------------------------------------------------------------------
-- Улучшенные команды для записи и исполнения макросов
-----------------------------------------------------------------------------
vim.keymap.set("n", "q", '(reg_recording()==""?"qq":"q")', { expr = true })
vim.keymap.set("n", "Q", '(reg_recording()==""&&reg_executing()==""?":norm! @q\r":"")', { expr = true })

-- stylua: ignore
vim.keymap.set(
	"n",
	"cq",
	':let b:_t=input(">",keytrans(@q))|let @q=(trim(b:_t)!=""?nvim_replace_termcodes(b:_t,1,1,1):@q)\r'
)
