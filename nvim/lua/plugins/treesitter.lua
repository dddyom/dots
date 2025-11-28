return {
	-----------------------------------------------------------------------------
	-- Treesitter: подсветка, indent, парсеры
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		main = "nvim-treesitter.configs",
		build = ":TSUpdate",
		dependencies = {
			-- контекст (заголовок функции/блока)
			{ "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
			-- комментарии на базе treesitter
			{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
		},
		opts = {
			highlight = { enable = true, disable = { "markdown" } },
			indent = { enable = true, disable = { "markdown" } },
            -- stylua: ignore start
			ensure_installed = {
				"python", "bash", "css", "html", "json", "htmldjango", "http",
				"javascript", "lua", "make", "regex", "rust", "tsx", "typescript",
				"dockerfile",
			},
			-- stylua: ignore end
		},
	},

	-----------------------------------------------------------------------------
	-- Авто-закрытие HTML/XML-тегов через treesitter
	{ "tronikelis/ts-autotag.nvim", opts = {}, event = "VeryLazy" },
}
