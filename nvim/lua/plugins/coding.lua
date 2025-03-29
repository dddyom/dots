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
		"jeangiraldoo/codedocs.nvim",
		keys = {
			{
				"<leader>k",
				function()
					require("codedocs").insert_docs()
				end,
				desc = "Insert a docstring",
			},
		},
	},
	-----------------------------------------------------------------------------
	-- Расширенные операции с окружением текста (замена, удаление, добавление)
	{ "echasnovski/mini.surround", opts = {} },
	-----------------------------------------------------------------------------
	-- AI автодополнение кода
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup({ silent = true })

			-- Принятие предложений
			vim.keymap.set("i", "<C-a>", neocodeium.accept, { desc = "Accept completion" })
			vim.keymap.set("i", "<C-w>", neocodeium.accept_word, { desc = "Accept word" })
			vim.keymap.set("i", "<C-e>", neocodeium.accept_line, { desc = "Accept line" })

			-- Переключение AI-дополнения
			local toggle = function()
				require("neocodeium.commands").toggle()
				local is_enabled = require("neocodeium.options").options.enabled
				local message = "AI completion " .. (is_enabled and "enabled" or "disabled") .. "."
				vim.notify(message, vim.log.levels.INFO, { title = "NeoCodeium" })
			end

			vim.keymap.set("n", "<leader>x", toggle, { desc = "Toggle AI completion" })
		end,
	},
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
