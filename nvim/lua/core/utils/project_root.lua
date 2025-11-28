-----------------------------------------------------------------------------
-- Корень проекта: git root или cwd
-----------------------------------------------------------------------------
local get_project_root = function()
	local project_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")

	if project_root:match("fatal: not a git repository") then
		project_root = vim.fn.getcwd()
	end

	return project_root
end

return { get_project_root = get_project_root }
