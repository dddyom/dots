local M = {}

M.get_project_name = function(source_path)
	local path = source_path
	while path and path ~= "" do
		local git_dir = path .. "/.git"
		local is_directory = vim.fn.isdirectory(git_dir)
		if is_directory == 1 then
			return vim.fn.fnamemodify(path, ":t")
		end
		path = path:match("(.*)/[^/]*$")
	end
	return vim.fn.fnamemodify(source_path, ":t")
end

M.tmux_session_name = function()
	return vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
end

local get_print_text = function(filetype)
	if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
		or filetype == "html"
		or filetype == "htmldjango"
	then
		return {
			print_text = [[console.warn()]],
			start_insert = "%(",
		}
	elseif filetype == "python" then
		return {
			print_text = [[print(f'\033[93m{}\033[0m')]],
			start_insert = "{",
		}
	elseif filetype == "lua" then
		return {
			print_text = [[vim.print()]],
			start_insert = "%(",
		}
	else
		return
	end
end

local modify_line = function(buf, line, cursor_pos, print_text, start_insert)
	local modified_line = line:sub(1, cursor_pos[2]) .. print_text .. line:sub(cursor_pos[2] + 1)

	modified_line = modified_line:gsub("%s+$", "")

	vim.api.nvim_buf_set_lines(buf, cursor_pos[1] - 1, cursor_pos[1], false, { modified_line })

	local start_pos, _ = modified_line:find(start_insert)

	if start_pos then
		vim.api.nvim_win_set_cursor(0, { cursor_pos[1], start_pos })
	end
end

M.log_print = function(mode)
	local print = get_print_text(vim.bo.filetype)

	if not print then
		return
	end

	if mode == "v" then
		vim.cmd("normal! d")
	end

	local buf = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(buf, cursor[1] - 1, cursor[1], false)[1]
	modify_line(buf, current_line, cursor, print.print_text, print.start_insert)

	if mode == "v" then
		vim.cmd("normal! P")
		vim.cmd("normal! I ")
	else
		vim.cmd("startinsert")
	end
end

local api = vim.api
M.toggle_log = function()
  local wins = api.nvim_list_wins()

  for _, id in pairs(wins) do
    local bufnr = api.nvim_win_get_buf(id)
    if api.nvim_buf_get_name(bufnr):match '.*/([^/]+)$' == '__FLUTTER_DEV_LOG__' then
      return vim.api.nvim_win_close(id, true)
    end
  end

  pcall(function()
    vim.api.nvim_command 'sb + __FLUTTER_DEV_LOG__ | resize 15'
  end)
end

return M


