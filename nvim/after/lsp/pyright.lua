-- 	root_markers = {
-- 		"pyproject.toml",
-- 		"poetry.lock",
-- 		"setup.cfg",
-- 		"setup.py",
-- 		".git",
-- 	},

-----------------------------------------------------------------------------
-- Путь до python для LSP (venv / poetry / venv в проекте)
-----------------------------------------------------------------------------
local get_python_path = function(workspace)
	local function join(...)
		return vim.fs.joinpath(...)
	end

	local function exists(path)
		return (vim.uv or vim.loop).fs_stat(path) ~= nil
	end

	-- 1) активированный venv
	if vim.env.VIRTUAL_ENV then
		return join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- 2) poetry-окружение
	local poetry_lock = join(workspace, "poetry.lock")
	if exists(poetry_lock) then
		local venv = vim.fn.trim(vim.fn.system("poetry env info -p 2>/dev/null")):gsub("\n", "")
		return join(venv, "bin", "python")
	end

	-- 3) venv в корне проекта
	local venv = join(workspace, "venv", "bin", "python")
	if exists(venv) then
		return venv
	end

	return "python"
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },

	-- Маркеры корня проекта для pyright
	root_markers = {
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},

	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},

	-- Прокинуть корректный pythonPath в LSP
	before_init = function(_, cfg)
		cfg.settings.python.pythonPath = get_python_path(cfg.root_dir or vim.loop.cwd())
	end,
}
