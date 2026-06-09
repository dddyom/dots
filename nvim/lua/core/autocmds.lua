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
-- Markdown: <CR> toggle checkbox, <leader>p/e/E, :MdPdf, :MdToVault
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

	local path = vim.api.nvim_buf_get_name(buf)
	local vault = vim.g.obsidian_vault or ""
	local in_vault = vault ~= "" and path:sub(1, #vault) == vault

	if not in_vault then
		vim.keymap.set(
			"n",
			"<leader>om",
			"<cmd>MdToVault<CR>",
			vim.tbl_extend("force", kopts, { desc = "Markdown → Obsidian vault" })
		)
	end

	if in_vault then
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

		local project = require("core.projects").find_by_path(src)
		local subdir = project and ("/projects/" .. project.name) or ""
		local dest_dir = v .. subdir

		local name = (o.args ~= "" and o.args) or vim.fn.fnamemodify(src, ":t")
		if not name:match("%.md$") then
			name = name .. ".md"
		end
		local dest = dest_dir .. "/" .. name
		if vim.fn.filereadable(dest) == 1 then
			vim.notify("MdToVault: " .. dest .. " уже существует", vim.log.levels.ERROR)
			return
		end
		vim.fn.mkdir(dest_dir, "p")

		if vim.bo[buf].modified then
			vim.cmd("write")
		end

		local extra = {}
		if project then
			extra["project"] = project.name
			local src_dir = vim.fn.fnamemodify(src, ":h")
			local remote = vim.fn.systemlist({ "git", "-C", src_dir, "remote", "get-url", "origin" })
			if vim.v.shell_error == 0 and remote[1] and remote[1] ~= "" then
				extra["git_remote"] = remote[1]
			end
			local sha = vim.fn.systemlist({ "git", "-C", src_dir, "rev-parse", "HEAD" })
			if vim.v.shell_error == 0 and sha[1] and sha[1] ~= "" then
				extra["git_commit"] = sha[1]
			end
		end

		local ok, err = vim.uv.fs_rename(src, dest)
		if not ok then
			vim.notify("MdToVault: " .. tostring(err), vim.log.levels.ERROR)
			return
		end

		if next(extra) then
			local lines = vim.fn.readfile(dest)
			local has_fm = lines[1] == "---"
			local insert_at, new_lines = 1, {}
			if has_fm then
				for i = 2, #lines do
					if lines[i] == "---" then
						insert_at = i
						break
					end
				end
				for i = 1, insert_at - 1 do
					table.insert(new_lines, lines[i])
				end
				for k, val in pairs(extra) do
					table.insert(new_lines, k .. ": " .. val)
				end
				for i = insert_at, #lines do
					table.insert(new_lines, lines[i])
				end
			else
				table.insert(new_lines, "---")
				for k, val in pairs(extra) do
					table.insert(new_lines, k .. ": " .. val)
				end
				table.insert(new_lines, "---")
				table.insert(new_lines, "")
				for _, l in ipairs(lines) do
					table.insert(new_lines, l)
				end
			end
			vim.fn.writefile(new_lines, dest)
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

		-- Стиль документа. Главная ручка размера — `font-size` у html.
		local css_path = "/tmp/_mdpdf_style.css"
		local css = [[
@page { size: A4; margin: 1.8cm 2cm; }
html { font-size: 10.5pt; }
body { font-family: "DejaVu Sans", "Liberation Sans", sans-serif; color: #1f1f1f; line-height: 1.45; }
h1 { font-size: 1.55em; margin: 0 0 0.4em; border-bottom: 1px solid #ddd; padding-bottom: 0.15em; }
h2 { font-size: 1.28em; margin: 1em 0 0.3em; }
h3 { font-size: 1.12em; margin: 0.85em 0 0.25em; }
h4, h5, h6 { font-size: 1em; margin: 0.7em 0 0.2em; }
p { margin: 0.4em 0; }
ul, ol { margin: 0.3em 0; padding-left: 1.5em; }
li { margin: 0.1em 0; }
code { font-family: "DejaVu Sans Mono", "Liberation Mono", monospace; font-size: 0.9em; background: #f3f3f3; padding: 0 0.25em; border-radius: 3px; }
pre { background: #f6f8fa; padding: 0.6em 0.8em; border-radius: 4px; font-size: 0.85em; line-height: 1.4; overflow-x: auto; white-space: pre-wrap; }
pre code { background: transparent; padding: 0; font-size: 1em; }
blockquote { margin: 0.5em 0; padding: 0.2em 0.8em; border-left: 3px solid #d0d0d0; color: #555; }
table { border-collapse: collapse; font-size: 0.95em; margin: 0.5em 0; }
th, td { border: 1px solid #ccc; padding: 0.25em 0.55em; vertical-align: top; }
th { background: #f0f0f0; text-align: left; }
img { max-width: 100%; }
a { color: #0366d6; text-decoration: none; }
hr { border: none; border-top: 1px solid #ddd; margin: 1em 0; }
]]
		local f = io.open(css_path, "w")
		if f then
			f:write(css)
			f:close()
		end

		vim.system({
			"pandoc",
			src,
			"-o", out,
			"--pdf-engine=weasyprint",
			"--standalone",
			"--css=" .. css_path,
		}, { text = true }, function(res)
			vim.schedule(function()
				if res.code ~= 0 then
					vim.notify("MdPdf не удался:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
					return
				end
				vim.fn.setreg("+", out)
				vim.notify("MdPdf готов: " .. out .. "\n(путь в +)")
				if o.bang then
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
