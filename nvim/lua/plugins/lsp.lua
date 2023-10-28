local map_n = require("utils.map").n

return {
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
				"ruff_lsp",
				"sqlls",
				"tsserver",
			},
		})

		lsp.on_attach(function(_, bufnr)
			lsp.default_keymaps({ buffer = bufnr })
		end)
		lsp.set_sign_icons({ error = "", warn = "", hint = "", info = "פֿ" })

		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
		lsp.setup()
		require("utils.utils").set_cmp_icons()
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
		require("lspconfig").ruff_lsp.setup({
			settings = {
				organizeImports = false,
			},
			on_attach = function(client)
				client.server_capabilities.hoverProvider = false
			end,
		})
		map_n("z", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
		map_n("Z", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev diagnostic")
		map_n("D", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show all diagnostic")
	end,
}
