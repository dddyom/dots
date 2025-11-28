return {
	-----------------------------------------------------------------------------
	-- Mason + mason-lspconfig: установка LSP-серверов
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"vue_ls",
				"pyright",
				"eslint",
			},
		},
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
