local function get_python_path(workspace)
	local util = require("lspconfig.util")
	local path = util.path

	-- 1. if venv is activated
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- 2. poetry
	local poetry_lock = path.join(workspace, "poetry.lock")
	if util.path.exists(poetry_lock) then
		local venv = vim.fn.trim(vim.fn.system("poetry env info -p 2>/dev/null")):gsub("\n", "")
		return path.join(venv, "bin", "python")
	end

	-- 3. venv in workspace
	local venv = path.join(workspace, "venv", "bin", "python")
	if util.path.exists(venv) then
		return venv
	end

	-- local venv = path.join(workspace, ".venv", "bin", "python")
	-- if util.path.exists(venv) then
	-- 	return venv
	-- end
	--
	return "python"
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"emmet_language_server",
					"lua_ls",
					"pyright",
					"ts_ls",
				},
				automatic_enable = true,
			})

			local icons = require("core.icons").diagnostics
			vim.diagnostic.config({
				signs = {
					enable = true,
					text = {
						[vim.diagnostic.severity.ERROR] = icons.error,
						[vim.diagnostic.severity.WARN] = icons.warn,
						[vim.diagnostic.severity.INFO] = icons.info,
						[vim.diagnostic.severity.HINT] = icons.hint,
					},
				},
			})

			vim.lsp.config("pyright", {
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
				before_init = function(_, cfg)
					cfg.settings.python.pythonPath = get_python_path(cfg.root_dir or vim.loop.cwd())
				end,
				root_markers = {
					"pyproject.toml",
					"poetry.lock",
					"setup.cfg",
					"setup.py",
					".git",
				},
			})
			vim.lsp.enable("pyright")
			vim.lsp.config("ts_ls", {
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = "/home/d/.npm-packages/lib/node_modules/@vue/typescript-plugin",
							languages = { "vue" },
						},
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
			})
			vim.lsp.enable("ts_ls")
		end,
	},
	-----------------------------------------------------------------------------
	-- Предпросмотр определения, типа и реализации LSP
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		config = true,
		opts = {
			post_open_hook = function(buf, _)
				vim.keymap.set("n", "q", function()
					vim.cmd("close")
				end, { buffer = buf, silent = true })
			end,
		},
		keys = {
            -- stylua: ignore start
			{ "gD", function() require("goto-preview").goto_preview_definition() end, desc = "Preview definition" },
			{ "gt", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview type definition" },
			{ "gi", function() require("goto-preview").goto_preview_implementation() end, desc = "Preview implementation" },
			{ "gpq", function() require("goto-preview").close_all_win() end, desc = "Close all LSP previews" },
			-- stylua: ignore end
		},
	},
	-----------------------------------------------------------------------------
	{ "benomahony/uv.nvim", opts = { picker_integration = true } },
}
