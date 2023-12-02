local M = {}

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

M.tmux_session_name = function()
	return vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
end

return M
