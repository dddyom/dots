return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Оптимизация работы с большими файлами
		bigfile = { enabled = true },

		-- Настройки удаления буферов
		bufdelete = {
			force = false, -- Запрет принудительного удаления несохраненных буферов
			preserve_layout = true, -- Сохранение текущей раскладки окон при удалении буфера
		},

		-- Открытие текущего файла, коммита или репозитория в браузере
		gitbrowse = {
			notify = true,
			what = "file", -- Определение открываемого объекта: "repo", "branch", "file", "commit" или "permalink"
		},

		-- Визуализация отступов
		indent = {

			enabled = true,
			animate = { enabled = false }, -- Отключение анимации
			chunk = { enabled = true }, -- Включение подсветки логических блоков кода
		},

		-- Настройки системы уведомлений
		notifier = {
			enabled = true, -- Включение кастомных уведомлений
			icons = require("core.icons").notifier,
			top_down = false, -- Размещение уведомлений снизу
			style = "compact", -- Определение стиля уведомлений: "compact", "fancy", "minimal"
		},

		-- Настройки встроенного поиска
		picker = {
			enabled = true, -- Включение поиска через `snacks.picker`
			matcher = {
				frecency = true, -- Использование частоты открытия файлов для приоритезации результатов
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
		},
	},

	keys = {
		-- stylua: ignore start
		---@diagnostic disable: undefined-global

		{ "<leader>b", "", desc = "Buffers" },
		{ "<M-q>", function() Snacks.bufdelete.delete() end, desc = "Close current buffer" },
		{ "<leader>bq", function() Snacks.bufdelete.delete() end, desc = "Close current buffer" },
		{ "<leader>bQ", function() Snacks.bufdelete.all() end, desc = "Close all buffers" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Close other buffers" },

		{ "<leader>go", function() Snacks.gitbrowse() end, desc = "Open in browser" },

		{ "<leader>n", "", desc = "Notifications" },
		{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Show notifications history" },
		{ "<leader>nd", function() Snacks.notifier.hide() end, desc = "Close all notifications" },

		{ "<leader>f", "", desc = "Find" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
		{ "<leader>fw", function() Snacks.picker.grep() end, desc = "Find by word" },
		{ "<leader>fc", function() Snacks.picker.command_history() end, desc = "Find by word" },

		-- { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Find opened buffers" },

		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Find in help tags" },

		{ "gd", function() Snacks.picker.lsp_definitions({ jump_to_single_result = true }) end, desc = "Go to definition" },
		{ "gr", function() Snacks.picker.lsp_references({ jump_to_single_result = true }) end, desc = "Find LSP references" },
		{ "<leader>fa", function() vim.lsp.buf.code_action({ apply = true }) end, desc = "Apply LSP code actions" },

        { "<leader>fs", function() Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } }) end, desc = "LSP Symbols" },
        { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols({ layout = { preset = "vscode", preview = "main" } }) end, desc = "LSP Workspace Symbols" },

		---@diagnostic enable: undefined-global
		-- stylua: ignore end
	},
}
