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

			require("mason").setup()
			require("mason-lspconfig").setup({ ensure_installed = { "emmet_language_server", "lua_ls", "basedpyright", "ts_ls" } })
			lsp.on_attach(function(_, bufnr) lsp.default_keymaps({ buffer = bufnr }) end)
			lsp.set_sign_icons(require("core.icons").diagnostics)
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
			lspconfig.basedpyright.setup({ settings = { basedpyright = { typeCheckingMode = "basic" } } })
			lspconfig.dartls.setup({})

			lsp.setup()
            -- stylua: ignore
			vim.keymap.set("n", "z[", function() vim.diagnostic.goto_prev() end, { desc = "prev diagnostic", silent = true, nowait = true, noremap = true })
            -- stylua: ignore
			vim.keymap.set("n", "z]", function() vim.diagnostic.goto_next() end, { desc = "next diagnostic", silent = true, nowait = true, noremap = true })
            -- stylua: ignore
			vim.keymap.set("n", "D", function() vim.diagnostic.open_float() end, { desc = "Diagnostic float", silent = true, nowait = true, noremap = true })
		end,
	},
	-----------------------------------------------------------------------------
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		config = true,
		opts = {
			post_open_hook = function(buf, _)
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
			end,
		},
        -- stylua: ignore
		keys = {
			{ "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition", },
			{ "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition", },
			{ "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview implementation", },
			{ "gpq", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "close all lsp previews", },
		},
	},
}
