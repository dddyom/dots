local map_n = require("utils.map").n

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		"hinell/lsp-timeout.nvim",
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
		map_n("<c-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
		map_n("<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev diagnostic")
	end,
}
