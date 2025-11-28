-----------------------------------------------------------------------------
-- Имя проекта по git-корню
-----------------------------------------------------------------------------
local get_project_name = function(source_path)
	local path = source_path

	while path and path ~= "" do
		local git_dir = path .. "/.git"
		if vim.fn.isdirectory(git_dir) == 1 then
			return vim.fn.fnamemodify(path, ":t")
		end
		path = path:match("(.*)/[^/]*$")
	end

	return vim.fn.fnamemodify(source_path, ":t")
end

return { get_project_name = get_project_name }
