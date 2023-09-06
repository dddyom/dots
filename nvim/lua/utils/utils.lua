local M = {}

M.set_cmp_icons = function()
	require("cmp").setup({
		formatting = {
			format = function(entry, vim_item)
				local icons = require("utils.icons")
				vim_item.kind = icons[vim_item.kind]
				vim_item.menu = icons[entry.source.name]
				if entry.source.name == "cmp_tabnine" then
					local detail = (entry.completion_item.labelDetails or {}).detail
					vim_item.kind = ""
					if detail and detail:find(".*%%.*") then
						vim_item.kind = vim_item.kind .. " " .. detail
					end

					if (entry.completion_item.data or {}).multiline then
						vim_item.kind = vim_item.kind .. " " .. "[ML]"
					end
				end
				return vim_item
			end,
		},
	})
end

local read_env_file = function(filename)
	local env_vars = {}
	local file = io.open(filename, "r")
	if file then
		for line in file:lines() do
			local key, value = line:match("([^=]+)=(.+)")
			if key and value then
				env_vars[key] = value
			end
		end
		file:close()
	end
	return env_vars
end

local drop_quotes = function(str)
	return str:gsub("['\"]", "")
end

M.get_dbs = function()
	local dbs = {}
	local centers = os.getenv("CENTERS")
	local conn_dir = os.getenv("CONNECTIONS_ROOT_DIR")
	if centers ~= nil and conn_dir ~= nil then
		for center in centers:gmatch("[^,]+") do
			local env_file = conn_dir .. "/" .. center .. "/.env"

			local cur_conn = read_env_file(env_file)

			table.insert(dbs, {
				name = center,
				url = string.format(
					"jdbc:sqlserver://%s:%s@%s:%s;database=%s",
					drop_quotes(cur_conn["DB_USER"]),
					drop_quotes(cur_conn["DB_PASSWORD"]),
					drop_quotes(cur_conn["DB_HOST"]),
					drop_quotes(cur_conn["DB_PORT"]),
					drop_quotes(cur_conn["DB_NAME"])
				),
			})
		end
	end
	return dbs
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

return M
