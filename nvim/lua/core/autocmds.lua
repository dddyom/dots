local augroup = require("core.utils.au").augroup
local au = require("core.utils.au").au

-----------------------------------------------------------------------------
-- CursorLine только в активном okне / normal-режиме
-----------------------------------------------------------------------------
au({ "InsertLeave", "WinEnter" }, "*", function(event)
	if vim.bo[event.buf].buftype == "" then
		vim.opt_local.cursorline = true
	end
end, augroup("auto_cursorline_show"))

au({ "InsertEnter", "WinLeave" }, "*", function()
	vim.opt_local.cursorline = false
end, augroup("auto_cursorline_hide"))

-----------------------------------------------------------------------------
-- Сброс hlsearch, когда больше нет совпадений
-----------------------------------------------------------------------------
au("CursorMoved", "*", function()
	if vim.v.hlsearch == 1 and vim.fn.searchcount({ exact = true }).total == 0 then
		vim.schedule(function()
			vim.cmd("nohlsearch")
		end)
	end
end, augroup("auto_hlsearch"))

-----------------------------------------------------------------------------
-- Вспомогательные буферы: закрывать по q, не светить в списке
-----------------------------------------------------------------------------
au("FileType", {
	"grug-far",
	"checkhealth",
	"help",
	"lspinfo",
	"notify",
	"qf",
	"oil",
}, function(event)
	vim.bo[event.buf].buflisted = false
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
end, augroup("close_with_q"))
-----------------------------------------------------------------------------
-- *.html по умолчанию считаем Django-шаблонами
-----------------------------------------------------------------------------
au({ "BufRead", "BufNewFile" }, "*.html", "set filetype=htmldjango", augroup("set_filetype_htmldjango"))

-----------------------------------------------------------------------------
-- Срезать хвостовые пробелы перед сохранением
-----------------------------------------------------------------------------
au("BufWritePre", "*", "%s/\\s\\+$//e", augroup("remove_trailing_whitespace"))

-----------------------------------------------------------------------------
-- Не тянуть комментарий на новую строку
-----------------------------------------------------------------------------
au(
	{ "BufEnter", "FileType" },
	"*",
	"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
	augroup("no_auto_comment")
)

-----------------------------------------------------------------------------
-- Переход к последней позиции курсора при открытии буфера
-----------------------------------------------------------------------------
au(
	"BufWinEnter",
	"*",
	[[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
	augroup("jump_to_last_position")
)

-----------------------------------------------------------------------------
-- Краткая подсветка выделенного yank
-----------------------------------------------------------------------------
au("TextYankPost", "*", function()
	vim.highlight.on_yank({
		higroup = "Search",
		timeout = 300,
		on_visual = true,
	})
end, augroup("highlight_on_yank"))

-----------------------------------------------------------------------------
-- Макросы в q: нотификации и защита от пустой записи
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
-- Диагностика: float-окно под курсором по hover
-----------------------------------------------------------------------------
au({ "CursorHold", "InsertLeave" }, "*", function()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		scope = "cursor",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
	})
end)

-----------------------------------------------------------------------------
-- Диагностика: выключать в insert, включать в normal
-----------------------------------------------------------------------------
au("InsertEnter", "*", function()
	vim.diagnostic.enable(false)
end)

au("InsertLeave", "*", function()
	vim.diagnostic.enable(true)
end)
