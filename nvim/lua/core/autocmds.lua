local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

local function set_cursorline(show)
	vim.opt_local.cursorline = show
end

local group = augroup("OoO")

local function au(typ, pattern, cmdOrFn, group_override)
	local grp = group_override or group
	if type(cmdOrFn) == "function" then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = grp })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = grp })
	end
end

-----------------------------------------------------------------------------
-- Авто-подсветка строки курсора (CursorLine)
-----------------------------------------------------------------------------
au({ "InsertLeave", "WinEnter" }, "*", function(event)
	if vim.bo[event.buf].buftype == "" then
		set_cursorline(true)
	end
end, augroup("auto_cursorline_show"))

au({ "InsertEnter", "WinLeave" }, "*", function()
	set_cursorline(false)
end, augroup("auto_cursorline_hide"))

-----------------------------------------------------------------------------
-- Авто-переключение LSP Inlay Hints
-----------------------------------------------------------------------------
au({ "LspAttach", "InsertEnter", "InsertLeave" }, "*", function(event)
	local enabled = event.event ~= "InsertEnter"
	vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
end, augroup("lsp_inlay_hints"))

au({ "LspAttach" }, "*", function(args)
	local opts = { buffer = args.buf, noremap = true, silent = true }
	local map = vim.keymap.set

	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	map("n", "z[", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)
	map("n", "z]", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)
	map("n", "D", function()
		local _, win = vim.diagnostic.open_float()
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_set_current_win(win)
		end
	end, opts)
end, augroup("lsp_maps"))

-----------------------------------------------------------------------------
-- Авто-отключение подсветки поиска при движении курсора
-----------------------------------------------------------------------------
au("CursorMoved", "*", function()
	if vim.v.hlsearch == 1 and vim.fn.searchcount({ exact = true }).total == 0 then
		vim.schedule(function()
			vim.cmd("nohlsearch")
		end)
	end
end, augroup("auto_hlsearch"))

-----------------------------------------------------------------------------
-- Закрытие определённых типов буферов по `q`
-----------------------------------------------------------------------------
au("FileType", {
	"grug-far",
	"toggleterm",
	"blame",
	"checkhealth",
	"fugitive",
	"fugitiveblame",
	"help",
	"httpResult",
	"lspinfo",
	"notify",
	"PlenaryTestPopup",
	"qf",
	"startuptime",
	"tsplayground",
	"oil",
}, function(event)
	vim.bo[event.buf].buflisted = false
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
end, augroup("close_with_q"))

-----------------------------------------------------------------------------
-- Keymaps для HTML, Django, Jinja
-----------------------------------------------------------------------------
au("FileType", { "html", "htmldjango", "jinja" }, function()
	local map = vim.keymap.set
	map("v", "<leader>t", [[c{% trans %}<c-r>"{% endtrans %}<esc>]], { desc = "{% trans %}{% endtrans %}" })
	map("n", "<leader>t", [[i{% trans %}{% endtrans %}<esc>F{i]], { desc = "{% trans %}{% endtrans %}" })
	map("v", "<leader>%", [[c{% <c-r>" %}<esc>]], { desc = "jinja func" })
	map("n", "<leader>%", [[i{%  %}<esc>hhi]], { desc = "jinja func" })
	map("v", "<leader>}", [[c{{ <c-r>" }}<esc>]], { desc = "jinja tag" })
	map("n", "<leader>}", [[i{{  }}<esc>hhi]], { desc = "jinja func" })
end, augroup("html_django_jinja_keymaps"))

-----------------------------------------------------------------------------
-- Установка filetype для Django HTML
-----------------------------------------------------------------------------
au({ "BufRead", "BufNewFile" }, "*.html", "set filetype=htmldjango", augroup("set_filetype_htmldjango"))

-----------------------------------------------------------------------------
-- Авто-изменение размеров окон при изменении размеров Neovim
-----------------------------------------------------------------------------
au("VimResized", "*", "tabdo wincmd =", augroup("auto_resize_windows"))

-----------------------------------------------------------------------------
-- Удаление лишних пробелов при сохранении
-----------------------------------------------------------------------------
au("BufWritePre", "*", "%s/\\s\\+$//e", augroup("remove_trailing_whitespace"))

-----------------------------------------------------------------------------
-- Отключение авто-комментирования новой строки
-----------------------------------------------------------------------------
au(
	{ "BufEnter", "FileType" },
	"*",
	"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
	augroup("no_auto_comment")
)

-----------------------------------------------------------------------------
-- Перемещение к последней позиции в файле при открытии
-----------------------------------------------------------------------------
au(
	"BufWinEnter",
	"*",
	[[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
	augroup("jump_to_last_position")
)

-----------------------------------------------------------------------------
-- Подсветка текста при копировании (Yank)
-----------------------------------------------------------------------------
au("TextYankPost", "*", function()
	vim.highlight.on_yank({
		higroup = "Search",
		timeout = 300,
		on_visual = true,
	})
end, augroup("highlight_on_yank"))

-----------------------------------------------------------------------------
-- Уведомления при записи макросов (`q`)
-----------------------------------------------------------------------------
local macro_group = augroup("macro_notifications")

au("RecordingLeave", "*", function()
	if vim.v.event.regcontents ~= "" then
		vim.schedule_wrap(vim.notify)("Recorded macro: " .. vim.fn.keytrans(vim.v.event.regcontents))
	else
		vim.schedule_wrap(vim.notify)("Empty macro, previous recording is kept")
		vim.schedule_wrap(function(prev)
			vim.fn.setreg("q", prev)
		end)(vim.fn.getreg("q"))
	end
end, macro_group)

au("RecordingEnter", "*", function()
	vim.schedule_wrap(vim.notify)("Recording macro")
end, macro_group)

-----------------------------------------------------------------------------
-- Показ float-окна при наведении курсора
-----------------------------------------------------------------------------
au({ "CursorHold", "InsertLeave" }, "*", function()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		scope = "cursor",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
	})
end)

-----------------------------------------------------------------------------
-- Вкл/выкл диагностику при вставке
-----------------------------------------------------------------------------
au("InsertEnter", "*", function()
	vim.diagnostic.enable(false)
end)

au("InsertLeave", "*", function()
	vim.diagnostic.enable(true)
end)
