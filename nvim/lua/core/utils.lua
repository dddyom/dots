local M = {}

-----------------------------------------------------------------------------
-- Получение корневой папки проекта
-----------------------------------------------------------------------------
M.get_project_root = function()
	local project_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")

	-- Если текущая директория не является git-репозиторием, используем `cwd`
	if project_root:match("fatal: not a git repository") then
		project_root = vim.fn.getcwd()
	end

	return project_root
end

-----------------------------------------------------------------------------
-- Получение имени проекта (поиск `git`-корня)
-----------------------------------------------------------------------------
M.get_project_name = function(source_path)
	local path = source_path

	while path and path ~= "" do
		local git_dir = path .. "/.git"
		if vim.fn.isdirectory(git_dir) == 1 then
			return vim.fn.fnamemodify(path, ":t")
		end
		path = path:match("(.*)/[^/]*$") -- Переход на уровень выше
	end

	return vim.fn.fnamemodify(source_path, ":t") -- Если `git` не найден, вернуть имя папки
end

-----------------------------------------------------------------------------
-- Получение имени текущей `tmux`-сессии
-----------------------------------------------------------------------------
M.tmux_session_name = function()
	return vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
end

-----------------------------------------------------------------------------
-- Определение команды для `print` в зависимости от типа файла
-----------------------------------------------------------------------------
local get_print_text = function(filetype)
	local print_commands = {
		javascript = { print_text = [[console.warn()]], start_insert = "%(" },
		typescript = { print_text = [[console.warn()]], start_insert = "%(" },
		javascriptreact = { print_text = [[console.warn()]], start_insert = "%(" },
		typescriptreact = { print_text = [[console.warn()]], start_insert = "%(" },
		html = { print_text = [[console.warn()]], start_insert = "%(" },
		htmldjango = { print_text = [[console.warn()]], start_insert = "%(" },
		python = { print_text = [[print(f'\033[93m{}\033[0m')]], start_insert = "{" },
		lua = { print_text = [[vim.print()]], start_insert = "%(" },
		dart = { print_text = [[print();]], start_insert = "%(" },
	}

	return print_commands[filetype]
end

-----------------------------------------------------------------------------
-- Вставка `print` в текущую строку
-----------------------------------------------------------------------------
local modify_line = function(buf, line, cursor_pos, print_text, start_insert)
	-- Вставка `print` в позицию курсора
	local modified_line = line:sub(1, cursor_pos[2]) .. print_text .. line:sub(cursor_pos[2] + 1)

	-- Удаление лишних пробелов в конце строки
	modified_line = modified_line:gsub("%s+$", "")

	-- Обновление строки в буфере
	vim.api.nvim_buf_set_lines(buf, cursor_pos[1] - 1, cursor_pos[1], false, { modified_line })

	-- Перемещение курсора в нужную позицию (после `(` или `{`)
	local start_pos = modified_line:find(start_insert)
	if start_pos then
		vim.api.nvim_win_set_cursor(0, { cursor_pos[1], start_pos })
	end
end

-----------------------------------------------------------------------------
-- Вставка `print` в зависимости от режима (нормальный или визуальный)
-----------------------------------------------------------------------------
M.log_print = function(mode)
	local print_cmd = get_print_text(vim.bo.filetype)
	if not print_cmd then
		return
	end

	-- Если вызвано в визуальном режиме, удалить выделенный текст
	if mode == "v" then
		vim.cmd("normal! d")
	end

	local buf = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(buf, cursor[1] - 1, cursor[1], false)[1]

	-- Вставка `print`
	modify_line(buf, current_line, cursor, print_cmd.print_text, print_cmd.start_insert)

	-- Вставка скобок и перемещение в режим вставки
	if mode == "v" then
		vim.cmd("normal! P")
		vim.cmd("normal! I ")
	else
		vim.cmd("startinsert")
	end
end

return M
