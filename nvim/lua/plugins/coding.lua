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
		version = "v0.12.4",
		opts = {
			keymap = {
				preset = "default",
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
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
}
