return {
	-----------------------------------------------------------------------------
	-- Пары скобок в insert-режиме
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	----------------------------------------------------------------------------
	-- Генерация docstring по шаблонам
	{
		"danymat/neogen",
		config = true,
		version = "*",
		keys = {
			{
				"<leader>k",
				function()
					require("neogen").generate()
				end,
				mode = { "n" },
				silent = true,
				desc = "Add docstring",
			},
		},
	},

	-----------------------------------------------------------------------------
	-- mini.surround: работа с окружением текста
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "za",
				delete = "zd",
				find = "zf",
				find_left = "zF",
				highlight = "zh",
				replace = "zr",

				suffix_last = "l",
				suffix_next = "n",
			},
		},
	},

	-----------------------------------------------------------------------------
	-- Быстрый импорт по слову (Python)
	{
		"kiyoon/python-import.nvim",
		build = "uv tool install . --force --reinstall",
		keys = {
			{
				"<C-i>",
				function()
					require("python_import.api").add_import_current_word_and_move_cursor()
				end,
				mode = { "i", "n" },
				silent = true,
				desc = "Add python import",
				ft = "python",
			},
		},
		opts = {
			custom_function = function(winnr, word, ts_node) end,
		},
	},

	-----------------------------------------------------------------------------
	{
		"gisketch/triforce.nvim",
		dependencies = {
			"nvzone/volt",
		},
		config = function()
			require("triforce").setup({
				keymap = { show_profile = "<leader>t" },
			})
		end,
	},
}
