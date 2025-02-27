return {
	-----------------------------------------------------------------------------
	-- Подсветка синтаксиса, работа с AST и улучшенные отступы
	{

		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		main = "nvim-treesitter.configs",
		build = ":TSUpdate",
		dependencies = {

			-- Фиксирование контекста текущего кода (например, заголовки функций)
			{ "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
			-- Улучшенные комментарии через Treesitter
			{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
		},
		opts = {
			highlight = { enable = true, disable = { "markdown" } }, -- Подсветка синтаксиса
			indent = { enable = true, disable = { "markdown" } }, -- Автоматическое выравнивание кода
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
	-- Навигация по AST-древу с использованием стрелок
	{
		"aaronik/treewalker.nvim",
		config = function()
			require("treewalker").setup({ { highlight = true } })
            -- stylua: ignore start
			vim.keymap.set("n", "<Down>", function() vim.cmd("Treewalker Down") end, { noremap = true, desc = "Move Down in AST" })
			vim.keymap.set("n", "<Up>", function() vim.cmd("Treewalker Up") end, { noremap = true, desc = "Move Up in AST" })
			vim.keymap.set("n", "<Left>", function() vim.cmd("Treewalker Left") end, { noremap = true, desc = "Move Left in AST" })
			vim.keymap.set("n", "<Right>", function() vim.cmd("Treewalker Right") end, { noremap = true, desc = "Move Right in AST" })
			-- stylua: ignore end
		end,
	},

	-----------------------------------------------------------------------------

	-- Автоматическое закрытие HTML/XML тегов
	{ "tronikelis/ts-autotag.nvim", opts = {}, event = "VeryLazy" },
}
