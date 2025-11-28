return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- bigfile: урезать фичи на больших файлах
		bigfile = { enabled = true },

		-- аккуратное удаление буферов
		bufdelete = {
			force = false,
			preserve_layout = true,
		},

		-- gitbrowse: открыть файл/ветку/коммит в браузере
		gitbrowse = {
			notify = true,
			what = "file",
		},

		-- визуальные отступы и блоки
		indent = {
			enabled = true,
			animate = { enabled = false },
			chunk = { enabled = true },
		},

		-- система уведомлений Snacks
		notifier = {
			enabled = true,
			top_down = false,
			style = "compact",
		},

		-- общий picker (files, grep, lsp, и т.п.)
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
			},
			win = {
				preview = {
					wo = {
						relativenumber = false,
						number = false,
					},
				},
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

		-- буферы
		{ "<leader>b",  "", desc = "Buffers" },
		{ "<M-q>",      function() Snacks.bufdelete.delete() end, desc = "Close current buffer" },
		{ "<leader>bq", function() Snacks.bufdelete.delete() end, desc = "Close current buffer" },
		{ "<leader>bQ", function() Snacks.bufdelete.all() end,    desc = "Close all buffers" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end,  desc = "Close other buffers" },

		-- git / browser
		{ "<leader>go", function() Snacks.gitbrowse() end, desc = "Open in browser" },

		-- уведомления
		{ "<leader>n",  "", desc = "Notifications" },
		{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Show notifications history" },
		{ "<leader>nd", function() Snacks.notifier.hide() end,          desc = "Close all notifications" },

		-- поиск / picker
		{ "ff",         function() Snacks.picker.files() end,  desc = "Find files" },
		{ "fw",         function() Snacks.picker.grep() end,   desc = "Find by word" },
		{ "fc",         function() Snacks.picker.command_history({ layout = { preset = "vscode" } }) end, desc = "Command history" },
		{ "<c-space>",  function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "fh",         function() Snacks.picker.help() end,    desc = "Find in help tags" },

		-- git / GitHub
		{ "<leader>gm", function() Snacks.picker.gh_pr() end, desc = "Github merge requests" },

		-- LSP
		{ "gd",         function() Snacks.picker.lsp_definitions({ jump_to_single_result = true }) end,        desc = "Go to definition" },
		{ "gr",         function() Snacks.picker.lsp_references({ jump_to_single_result = true }) end,         desc = "Find LSP references" },
		{ "fa",         function() vim.lsp.buf.code_action({ apply = true }) end,                              desc = "Apply LSP code actions" },
		{ "fs",         function() Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } }) end,          desc = "LSP Symbols" },
		{ "fS",         function() Snacks.picker.lsp_workspace_symbols({ layout = { preset = "vscode", preview = "main" } }) end, desc = "LSP Workspace Symbols" },

		---@diagnostic enable: undefined-global
		-- stylua: ignore end
	},
}
