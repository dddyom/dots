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
-- Markdown: :MdPdf (pandoc+xelatex), toggle checkbox на <CR>, <leader>p/<leader>e
-----------------------------------------------------------------------------
local function md_toggle_checkbox(linenr)
	local line = vim.api.nvim_buf_get_lines(0, linenr - 1, linenr, false)[1] or ""
	-- порядок важен: сначала пробуем «есть [ ]» / «есть [x]», потом «голый маркер списка»
	local rules = {
		{ "^(%s*[-*+]%s+)%[ %]", "%1[x]" },
		{ "^(%s*[-*+]%s+)%[[xX]%]", "%1[ ]" },
		{ "^(%s*[-*+]%s+)", "%1[ ] " },
		{ "^(%s*%d+%.%s+)%[ %]", "%1[x]" },
		{ "^(%s*%d+%.%s+)%[[xX]%]", "%1[ ]" },
		{ "^(%s*%d+%.%s+)", "%1[ ] " },
	}
	for _, r in ipairs(rules) do
		local new, n = line:gsub(r[1], r[2], 1)
		if n > 0 then
			vim.api.nvim_buf_set_lines(0, linenr - 1, linenr, false, { new })
			return true
		end
	end
	return false
end

au("FileType", "markdown", function(event)
	local buf = event.buf
	local kopts = { buffer = buf, silent = true }

	-- range-команда для toggle (используется visual-мапом)
	vim.api.nvim_buf_create_user_command(buf, "MdCheckbox", function(o)
		for l = o.line1, o.line2 do
			md_toggle_checkbox(l)
		end
	end, { range = true, desc = "Toggle markdown checkbox(es)" })

	-- <CR>: toggle на текущей строке; если строка не похожа на список — фолбэк к дефолту
	vim.keymap.set("n", "<CR>", function()
		if not md_toggle_checkbox(vim.fn.line(".")) then
			vim.cmd("normal! j^")
		end
	end, vim.tbl_extend("force", kopts, { desc = "Toggle md checkbox / next line" }))

	-- <CR> в visual: toggle всех выделенных строк
	vim.keymap.set("x", "<CR>", ":MdCheckbox<CR>", vim.tbl_extend("force", kopts, { desc = "Toggle md checkboxes" }))

	-- <leader>p — live preview в браузере
	vim.keymap.set(
		"n",
		"<leader>p",
		"<cmd>MarkdownPreviewToggle<CR>",
		vim.tbl_extend("force", kopts, { desc = "Markdown preview toggle" })
	)

	-- <leader>e — экспорт в PDF (открыть в default viewer)
	vim.keymap.set(
		"n",
		"<leader>e",
		"<cmd>MdPdf<CR>",
		vim.tbl_extend("force", kopts, { desc = "Markdown → PDF" })
	)

	-- <leader>E — экспорт в PDF и открыть Thunar с выделением (для drag-в-мессенджер)
	vim.keymap.set(
		"n",
		"<leader>E",
		"<cmd>MdPdf!<CR>",
		vim.tbl_extend("force", kopts, { desc = "Markdown → PDF + reveal in Thunar" })
	)

	-- Obsidian-команды, активные только для md внутри vault'а
	local path = vim.api.nvim_buf_get_name(buf)
	local vault = vim.g.obsidian_vault or ""
	if vault ~= "" and path:sub(1, #vault) == vault then
		vim.keymap.set(
			"n",
			"<leader>ob",
			"<cmd>ObsidianBacklinks<CR>",
			vim.tbl_extend("force", kopts, { desc = "Obsidian: backlinks" })
		)
		vim.keymap.set(
			"n",
			"<leader>or",
			"<cmd>ObsidianRename<CR>",
			vim.tbl_extend("force", kopts, { desc = "Obsidian: rename" })
		)
		vim.keymap.set(
			"n",
			"<leader>os",
			"<cmd>ObsidianSearch<CR>",
			vim.tbl_extend("force", kopts, { desc = "Obsidian: search in vault" })
		)
	end

	-- :MdToVault [имя] — переместить текущий md в vault, открыть на новом месте
	vim.api.nvim_buf_create_user_command(buf, "MdToVault", function(o)
		local src = vim.api.nvim_buf_get_name(buf)
		if src == "" or vim.bo[buf].buftype ~= "" then
			vim.notify("MdToVault: буфер не привязан к файлу", vim.log.levels.ERROR)
			return
		end
		local v = vim.g.obsidian_vault or ""
		if v == "" then
			vim.notify("MdToVault: vim.g.obsidian_vault не задан", vim.log.levels.ERROR)
			return
		end
		if src:sub(1, #v) == v then
			vim.notify("MdToVault: уже внутри vault'а", vim.log.levels.INFO)
			return
		end
		local name = (o.args ~= "" and o.args) or vim.fn.fnamemodify(src, ":t")
		if not name:match("%.md$") then
			name = name .. ".md"
		end
		local dest = v .. "/" .. name
		if vim.fn.filereadable(dest) == 1 then
			vim.notify("MdToVault: " .. dest .. " уже существует", vim.log.levels.ERROR)
			return
		end
		if vim.bo[buf].modified then
			vim.cmd("write")
		end
		local ok, err = vim.uv.fs_rename(src, dest)
		if not ok then
			vim.notify("MdToVault: " .. tostring(err), vim.log.levels.ERROR)
			return
		end
		vim.cmd("edit " .. vim.fn.fnameescape(dest))
		pcall(vim.api.nvim_buf_delete, buf, { force = false })
		vim.notify("MdToVault: " .. dest)
	end, { nargs = "?", desc = "Move current md to Obsidian vault" })

	vim.api.nvim_buf_create_user_command(buf, "MdPdf", function(o)
		if vim.fn.executable("pandoc") == 0 then
			vim.notify(
				"MdPdf: pandoc не найден. Установи:\nsudo pacman -S pandoc-cli python-weasyprint",
				vim.log.levels.ERROR
			)
			return
		end
		if vim.fn.executable("weasyprint") == 0 then
			vim.notify(
				"MdPdf: weasyprint не найден. Установи:\nsudo pacman -S python-weasyprint",
				vim.log.levels.ERROR
			)
			return
		end
		local src = vim.api.nvim_buf_get_name(event.buf)
		if src == "" or vim.bo[event.buf].buftype ~= "" then
			vim.notify("MdPdf: буфер не привязан к файлу", vim.log.levels.ERROR)
			return
		end
		if vim.bo[event.buf].modified then
			vim.cmd("write")
		end
		-- PDF всегда в /tmp — не загрязняем рабочую директорию / vault
		local stem = vim.fn.fnamemodify(src, ":t:r")
		local out = "/tmp/" .. stem .. ".pdf"
		vim.notify("MdPdf: " .. vim.fn.fnamemodify(out, ":t") .. " …")
		-- weasyprint = HTML/CSS → PDF, без TeX. Кириллица и шрифты — через системный font config.
		vim.system({
			"pandoc",
			src,
			"-o", out,
			"--pdf-engine=weasyprint",
			"-V", "margin-left=2cm",
			"-V", "margin-right=2cm",
			"-V", "margin-top=2cm",
			"-V", "margin-bottom=2cm",
		}, { text = true }, function(res)
			vim.schedule(function()
				if res.code ~= 0 then
					vim.notify("MdPdf не удался:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
					return
				end
				vim.fn.setreg("+", out)
				vim.notify("MdPdf готов: " .. out .. "\n(путь в +)")
				if o.bang then
					-- :MdPdf! — открыть файл-менеджер (Thunar) с выделением PDF
					vim.system({
						"dbus-send",
						"--session",
						"--dest=org.freedesktop.FileManager1",
						"--type=method_call",
						"/org/freedesktop/FileManager1",
						"org.freedesktop.FileManager1.ShowItems",
						"array:string:file://" .. out,
						"string:",
					}, { detach = true })
				else
					vim.system({ "xdg-open", out }, { detach = true })
				end
			end)
		end)
	end, { bang = true, desc = "Markdown → PDF (+ reveal в Thunar с !)" })
end, augroup("mdpdf_command"))

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
