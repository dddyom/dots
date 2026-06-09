-- Реестр проектов. По cwd определяем, к какому проекту относится буфер,
-- и куда в Obsidian vault класть импортируемый md. Используется в :MdToVault.
-- root — корневая папка проекта. Если cwd начинается с root — это проект.
local M = {}

M.list = {
	{
		name = "uki",
		root = vim.fn.expand("~/code/silent_soft/uki"),
		repos = {
			backend = "git@github.com:SilentSoft-LLP/ukiplay-backend.git",
			frontend = "git@github.com:SilentSoft-LLP/ukiplay-frontend.git",
		},
	},
	{
		name = "aproduct",
		root = vim.fn.expand("~/code/silent_soft/aproduct"),
		repos = {
			backend = "git@github.com:KKazachenko/aproduct-erp-backend.git",
			frontend = "git@github.com:KKazachenko/aproduct-erp-frontend.git",
		},
	},
	{
		name = "alat",
		root = vim.fn.expand("~/code/silent_soft/alat"),
		repos = {
			backend = "git@github.com:SilentSoft-LLP/alataukus-backend.git",
		},
	},
	{
		name = "atrucks",
		root = vim.fn.expand("~/code/atrucks"),
		repos = {
			web = "git@git.atrucks.su:atrucks/docker-local.git",
		},
	},
	{
		name = "vtour",
		root = vim.fn.expand("~/code/vtour"),
		repos = {
			vtours = "git@github.com:Rusachok/vtours.git",
		},
	},
}

-- Найти проект, в чьём root лежит path. Возвращает запись или nil.
function M.find_by_path(path)
	if not path or path == "" then
		return nil
	end
	-- нормализуем: убираем двойные / и trailing /
	path = vim.fn.fnamemodify(path, ":p")
	local best = nil
	for _, p in ipairs(M.list) do
		local root = p.root
		if path:sub(1, #root) == root then
			-- более длинный root выигрывает (на случай вложенных)
			if not best or #p.root > #best.root then
				best = p
			end
		end
	end
	return best
end

return M
