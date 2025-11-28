return {
	-----------------------------------------------------------------------------
	-- Пары скобок в insert-режиме
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-----------------------------------------------------------------------------
	-- Автодополнение (blink.cmp)
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
				menu = {
					auto_show = true,
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},
			signature = { enabled = true },
		},
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
