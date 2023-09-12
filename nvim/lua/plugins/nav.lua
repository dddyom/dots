local leader = require("utils.map").leader
local map_n = require("utils.map").n

return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		config = function()
			map_n("<m-h>", ":<c-u>TmuxNavigateLeft<cr>", "tmux left")
			map_n("<m-l>", ":<c-u>TmuxNavigateRight<cr>", "tmux right")
			map_n("<m-j>", ":<c-u>TmuxNavigateDown<cr>", "tmux down")
			map_n("<m-k>", ":<c-u>TmuxNavigateUp<cr>", "tmux up")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup()
			map_n("<m-m>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "marks menu")
			map_n("M", '<cmd>lua require("harpoon.mark").add_file()<CR>', "add mark")
			map_n("<m-p>", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "prev mark")
			map_n("<m-n>", '<cmd>lua require("harpoon.ui").nav_next()<CR>', "next mark")
			map_n("<m-1>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', "harpoon file 1")
			map_n("<m-2>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', "harpoon file 2")
			map_n("<m-3>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', "harpoon file 3")
			map_n("<m-4>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', "harpoon file 4")
			map_n("<m-5>", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', "harpoon file 5")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"cljoly/telescope-repo.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = { prompt_position = "top" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<esc>"] = actions.close,
							["<c-q>"] = actions.close,
						},
					},
				},
				extensions = { repo = { list = { search_dirs = { "~/code", "~/WorkGit" } } } },
			})

			telescope.load_extension("repo")
			telescope.load_extension("ui-select")

			leader("ff", "<cmd>Telescope find_files<cr>", "find file")
			leader("fF", "<cmd>Telescope find_files hidden=true<cr>", "find file with hidden")
			leader("fw", "<cmd>Telescope live_grep<cr>", "find by word")
			leader("fs", "<cmd>Telescope grep_string<cr>", "find by word under cursor")
			leader("fb", "<cmd>Telescope buffers<cr>", "find in open buffers")
			leader("fh", "<cmd>Telescope help_tags<cr>", "help tags")
			leader("fd", "<cmd>Telescope lsp_definitions<cr>", "LSP definitions")
			leader("fr", "<cmd>Telescope lsp_references<cr>", "LSP references")
			leader("ft", "<cmd>Telescope lsp_type_definitions<cr>", "LSP type definitions")
			leader("fv", "<cmd>Telescope lsp_document_symbols<cr>", "LSP variables in file")
			leader("fV", "<cmd>Telescope lsp_workspace_symbols<cr>", "LSP variables in project")
			leader("fa", "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP code actions")
			leader("fd", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show all diagnostic")
			map_n("gd", "<cmd>Telescope lsp_definitions<CR>", "Go to definition")
		end,
	},
	{
		"ghillb/cybu.nvim",
		branch = "main",
		config = function()
			require("cybu").setup()
			vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
			vim.keymap.set("n", "L", "<Plug>(CybuNext)")
		end,
	},
	{
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
			vim.keymap.set(
				{ "n", "o", "x" },
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				{ desc = "Spider-ge" }
			)
		end,
	},
}
