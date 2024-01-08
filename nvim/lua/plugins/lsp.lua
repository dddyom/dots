return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {

			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"emmet_language_server",
					"lua_ls",
					"pyright",
					"sqlls",
					"tsserver",
				},
			})

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)
			lsp.set_sign_icons(require("core.icons").diagnostics)

			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
			lsp.setup()
			require("lspconfig").pyright.setup({
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
							diagnosticSeverityOverrides = {
								reportGeneralTypeIssues = "none",
								reportOptionalMemberAccess = "none",
								reportOptionalSubscript = "none",
								reportPrivateImportUsage = "none",
							},
						},
					},
				},
			})
			vim.keymap.set("n", "z", function()
				vim.diagnostic.goto_next()
			end, { desc = "Next diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "Z", function()
				vim.diagnostic.goto_prev()
			end, { desc = "prev diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "D", function()
				vim.diagnostic.open_float()
			end, { desc = "Diagnostic window", silent = true, nowait = true, noremap = true })
		end,
	},
	-----------------------------------------------------------------------------
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("symbol-usage").setup()
		end,
	},
}
