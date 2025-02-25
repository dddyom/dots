return {
	-----------------------------------------------------------------------------
	-- LSP (Language Server Protocol)
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			"neovim/nvim-lspconfig", -- Базовая конфигурация LSP
			"williamboman/mason-lspconfig.nvim", -- Интеграция Mason с lspconfig
			{
				"williamboman/mason.nvim", -- Установка LSP серверов и инструментов
				version = "v1.10.0",
				build = function()
					pcall(function()
						vim.cmd("MasonUpdate")
					end)
				end,
			},
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "emmet_language_server", "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
			})

			-- Установка базовых клавиш при подключении LSP
			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			-- Установка кастомных значков для диагностики
			lsp.set_sign_icons(require("core.icons").diagnostics)

			local lspconfig = require("lspconfig")

			-- Настройки для Lua
			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

			-- Настройки для Python (pyright)
			lspconfig.pyright.setup({
				settings = {
					pyright = {
						typeCheckingMode = "basic",
					},
				},
				on_init = function(client)
					local venv_path = vim.fn.trim(vim.fn.system("poetry env info -p"))
					local python_path = venv_path .. "/bin/python"

					if vim.fn.filereadable(python_path) == 1 then
						client.config.settings.python = {
							pythonPath = python_path,
						}
						client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					end
				end,
			})

			-- Настройки для Dart
			lspconfig.dartls.setup({})

			-- Применение настроек LSP
			lsp.setup()

			-- Навигация по диагностике
            -- stylua: ignore start
			vim.keymap.set("n", "z[", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Go to previous diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "z]", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Go to next diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "D", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic popup", silent = true, nowait = true, noremap = true })
			-- stylua: ignore end
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
			{ "gd", function() require("goto-preview").goto_preview_definition() end, desc = "Preview definition" },
			{ "gt", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview type definition" },
			{ "gi", function() require("goto-preview").goto_preview_implementation() end, desc = "Preview implementation" },
			{ "gpq", function() require("goto-preview").close_all_win() end, desc = "Close all LSP previews" },
			-- stylua: ignore end
		},
	},
}
