return {
	-----------------------------------------------------------------------------
	-- Автоматическое закрытие парных скобок
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	-----------------------------------------------------------------------------
	-- Автодополнение с поддержкой сниппетов
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v1.0.0",
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },

				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },

				["<Up>"] = { "snippet_backward", "fallback" },
				["<Down>"] = { "snippet_forward", "fallback" },

				["<C-p>"] = {},
				["<C-n>"] = {},

				["<C-b>"] = {},
				["<C-f>"] = {},
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			signature = { enabled = true },
		},
	},
	----------------------------------------------------------------------------
	-- Генерация документации (Docstrings)
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
	-- Расширенные операции с окружением текста (замена, удаление, добавление)
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "za", -- Add surrounding in Normal and Visual modes
				delete = "zd", -- Delete surrounding
				find = "zf", -- Find surrounding (to the right)
				find_left = "zF", -- Find surrounding (to the left)
				highlight = "zh", -- Highlight surrounding
				replace = "zr", -- Replace surrounding

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		},
	},
	-----------------------------------------------------------------------------
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
}
