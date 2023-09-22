local M = {}

M.set_cmp_icons = function()
	require("cmp").setup({
		formatting = {
			format = function(entry, vim_item)
				local icons = require("utils.icons")
				vim_item.kind = icons[vim_item.kind]
				vim_item.menu = icons[entry.source.name]
				return vim_item
			end,
		},
	})
end

M.get_project_name = function(path)
	while path and path ~= "" do
		local git_dir = path .. "/.git"
		local is_directory = vim.fn.isdirectory(git_dir)
		if is_directory == 1 then
			return vim.fn.fnamemodify(path, ":t")
		end
		path = path:match("(.*)/[^/]*$") -- Move up one directory level
	end
	return path
end

local get_commit_time = function(commit_hash)
	local command = "git show --quiet --date=iso-strict --format=%cd " .. commit_hash
	local success, git_output = pcall(vim.fn.systemlist, command)
	if not success or vim.v.shell_error ~= 0 then
		return nil
	end
	if not git_output or #git_output == 0 then
		return nil
	end
	local raw_time = git_output[1]
	return os.date(
		"%y/%m/%d %H:%M",
		os.time({
			year = raw_time:sub(1, 4),
			month = raw_time:sub(6, 7),
			day = raw_time:sub(9, 10),
			hour = raw_time:sub(12, 13),
			min = raw_time:sub(15, 16),
		})
	)
end

M.is_show_diffview_title = function()
	local buffer_path = vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr("%")), ":p") or ""
	if string.find(buffer_path, "panels") then
		return false
	end
	for _, keyword in ipairs({ "_BASE", "_LOCAL", "_REMOTE", "_BACKUP", "diffview" }) do
		if string.find(buffer_path, keyword) then
			return true
		end
	end
	return false
end

M.get_diffview_title = function()
	local bufnr = vim.fn.bufnr("%")
	local buffer_path = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":p") or ""
	if string.match(buffer_path, "_LOCAL") then
		return "Local branch (from)"
	end
	if string.match(buffer_path, "_REMOTE") then
		return "Remote branch (to)"
	end
	if string.match(buffer_path, "_BASE") then
		return "Base branch (result)"
	end
	if string.match(buffer_path, "_BACKUP") then
		return "Backup"
	end

	if string.match(buffer_path, "diffview") then
		if string.match(buffer_path, ".git") then
			local commit_hash = string.match(buffer_path, "%.git/(.-)/")
			if commit_hash == ":0:" then
				return "Old version"
			end

			local success, commit_time = pcall(get_commit_time, commit_hash)
			if success and commit_time ~= nil then
				return "Commit hash " .. commit_hash .. " (" .. commit_time .. ")"
			else
				return "Commit hash " .. commit_hash
			end
		end
	end
end

local floating_window = function(content, winWidth, winHeight, ft)
	local ui = vim.api.nvim_list_uis()[1]

	local width = winWidth or 100
	local height = winHeight or 10

	local opts = {
		relative = "editor",
		style = "minimal",
		width = width,
		height = height,
		row = math.ceil((ui.height - height) / 2) - 1,
		col = math.ceil((ui.width - width) / 2),
		border = "rounded",
	}

	local buf = vim.api.nvim_create_buf(false, true)
	if ft then
		vim.api.nvim_buf_set_option(buf, "filetype", ft)
	end

	local win = vim.api.nvim_open_win(buf, true, opts)
	for index, line in ipairs(content) do
		vim.fn.setbufline(buf, index, { line })
	end
	return { buf = buf, win = win }
end

M.floating_window = floating_window

local git_blame_current_line = function()
	local current_line = vim.fn.line(".")
	local file_path = vim.fn.expand("%")
	local git_log = {}

	local raw_log = vim.fn.system(string.format("git log -L %d,%d:%s", current_line, current_line, file_path))

	if not raw_log or raw_log:match("^fatal:") then
		return
	end

	for line in raw_log:gmatch("[^\r\n]+") do
		line = line:gsub("^%s+", "")
		if line:match("^diff") then
			break
		end
		table.insert(git_log, line)
	end
	return git_log
end

M.git_blame_current_line = git_blame_current_line

M.blame = function()
	local git_log = git_blame_current_line()
	if git_log then
		floating_window(git_log, 50, 4, "git")
	end
end

return M
