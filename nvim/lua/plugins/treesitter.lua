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
			-- Для выделения блоков
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
				},
				{
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
						},
					},
				},
			},
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
	-- Автоматическое закрытие HTML/XML тегов
	{ "tronikelis/ts-autotag.nvim", opts = {}, event = "VeryLazy" },
}
