local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

local function set_cursorline(show)
	vim.opt_local.cursorline = show
end

-----------------------------------------------------------------------------
-- Авто-подсветка строки курсора (CursorLine)
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = augroup("auto_cursorline_show"),
	callback = function(event)
		if vim.bo[event.buf].buftype == "" then
			set_cursorline(true)
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = augroup("auto_cursorline_hide"),
	callback = function()
		set_cursorline(false)
	end,
})

-----------------------------------------------------------------------------
-- Авто-переключение LSP Inlay Hints
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
	group = augroup("lsp_inlay_hints"),
	callback = function(event)
		local enabled = event.event ~= "InsertEnter"
		vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
	end,
})

-----------------------------------------------------------------------------
-- Авто-отключение подсветки поиска при движении курсора
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("CursorMoved", {
	group = augroup("auto_hlsearch"),
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.searchcount({ exact = true }).total == 0 then
			vim.schedule(function()
				vim.cmd("nohlsearch")
			end)
		end
	end,
})

-----------------------------------------------------------------------------
-- Закрытие определённых типов буферов по `q`
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
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
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-----------------------------------------------------------------------------
-- Keymaps для HTML, Django, Jinja
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("html_django_jinja_keymaps"),
	pattern = "html,htmldjango,jinja",
	callback = function()
		local map = vim.keymap.set
		map("v", "<leader>t", [[c{% trans %}<c-r>"{% endtrans %}<esc>]], { desc = "{% trans %}{% endtrans %}" })
		map("n", "<leader>t", [[i{% trans %}{% endtrans %}<esc>F{i]], { desc = "{% trans %}{% endtrans %}" })
		map("v", "<leader>%", [[c{% <c-r>" %}<esc>]], { desc = "jinja func" })
		map("n", "<leader>%", [[i{%  %}<esc>hhi]], { desc = "jinja func" })
		map("v", "<leader>}", [[c{{ <c-r>" }}<esc>]], { desc = "jinja tag" })
		map("n", "<leader>}", [[i{{  }}<esc>hhi]], { desc = "jinja func" })
	end,
})

-----------------------------------------------------------------------------
-- Установка filetype для Django HTML
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("set_filetype_htmldjango"),
	pattern = { "*.html" },
	command = "set filetype=htmldjango",
})

-----------------------------------------------------------------------------
-- Авто-изменение размеров окон при изменении размеров Neovim
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("auto_resize_windows"),
	command = "tabdo wincmd =",
})

-----------------------------------------------------------------------------
-- Удаление лишних пробелов при сохранении
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("remove_trailing_whitespace"),
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-----------------------------------------------------------------------------
-- Отключение авто-комментирования новой строки
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	group = augroup("no_auto_comment"),
	pattern = "*",
	command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-----------------------------------------------------------------------------
-- Перемещение к последней позиции в файле при открытии
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("jump_to_last_position"),
	pattern = "*",
	command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

-----------------------------------------------------------------------------
-- Подсветка текста при копировании (Yank)
-----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_on_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "Search",
			timeout = 300,
			on_visual = true,
		})
	end,
})

-----------------------------------------------------------------------------
-- Уведомления при записи макросов (`q`)
-----------------------------------------------------------------------------
vim.api.nvim_create_augroup("macro_notifications", { clear = true })

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = "macro_notifications",
	callback = function()
		if vim.v.event.regcontents ~= "" then
			vim.schedule_wrap(vim.notify)("Recorded macro: " .. vim.fn.keytrans(vim.v.event.regcontents))
		else
			vim.schedule_wrap(vim.notify)("Empty macro, previous recording is kept")
			vim.schedule_wrap(function(prev)
				vim.fn.setreg("q", prev)
			end)(vim.fn.getreg("q"))
		end
	end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
	group = "macro_notifications",
	callback = function()
		vim.schedule_wrap(vim.notify)("Recording macro")
	end,
})
