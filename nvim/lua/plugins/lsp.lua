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
					"basedpyright",
					"tsserver",
				},
			})
			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)
			lsp.set_sign_icons(require("core.icons").diagnostics)
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
			lspconfig.basedpyright.setup({
				settings = {
					basedpyright = {
						typeCheckingMode = "basic",
					},
				},
			})
			lsp.setup()
            -- stylua: ignore
			vim.keymap.set("n", "z[", function() vim.diagnostic.goto_prev() end, { desc = "prev diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "z]", function()
				vim.diagnostic.goto_next()
			end, { desc = "next diagnostic", silent = true, nowait = true, noremap = true })
			vim.keymap.set("n", "D", function()
				local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
				if #diagnostics > 0 then
					vim.diagnostic.open_float()
				else
					vim.diagnostic.goto_next()
				end
			end, { desc = "Diagnostic float or next diagnostic", silent = true, nowait = true, noremap = true })
		end,
	},
	-----------------------------------------------------------------------------
	{ "Wansmer/symbol-usage.nvim", event = "LspAttach", config = true },
	-----------------------------------------------------------------------------
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		config = true,
		opts = {

			post_open_hook = function(buf, _)
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
				vim.keymap.set("n", "go", function()
					vim.api.nvim_buf_attach(buf, true, {})
				end, { buffer = buf, silent = true })
			end,
		},
        -- stylua: ignore
		keys = {
			{ "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition", },
			{ "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition", },
			{ "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview implementation", },
			{ "gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "Preview declaration", },
			{ "gpq", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "close all lsp previews", },
		},
	},
}
