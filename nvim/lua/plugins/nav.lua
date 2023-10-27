local map_n = require("utils.map").n
local map_v = require("utils.map").v
local leader = require("utils.map").leader
return {
	{
		"backdround/improved-search.nvim",
		config = function()
			map_n("!", "<cmd>lua require('improved-search').current_word()<CR>", "Search the word under the cursor")
			map_v("!", "<cmd>lua require('improved-search').in_place()<cr>", "Search selected word")
			map_n("*", "g*", "Search a next word that matches the word under the cursor")
			map_v(
				"*",
				"<cmd>lua require('improved-search').forward()<cr>",
				"Search a next text that matches selected text"
			)
			map_n("#", "g#", "Search a previous word that matches the word under the cursor")
			map_v(
				"#",
				"<cmd>lua require('improved-search').backward()<cr>",
				"Search a next text that matches selected text"
			)
			map_n("]", "<cmd>lua require('improved-search').stable_next()<cr>", "Search next searched text")
			map_v("]", "<cmd>lua require('improved-search').stable_next()<cr>", "Search next searched text")
			map_n("[", "<cmd>lua require('improved-search').stable_previous()<cr>", "Search previous searched text")
			map_v("[", "<cmd>lua require('improved-search').stable_previous()<cr>", "Search previous searched text")
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
			map_n("``", "<CMD>lua require('oil').open_float()<CR>", "Oil")
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
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<CR>",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({})
			leader("f", "", "Find")
			leader("ff", "<cmd>lua require('fzf-lua').files()<CR>", "Find files")
			leader("s", "<cmd>lua require('fzf-lua').blines()<CR>", "find in buffer")
			leader("fw", "<cmd>lua require('fzf-lua').live_grep()<CR>", "find by word")
			leader("fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", "find by word")
			leader("fs", "<cmd>lua require('fzf-lua').grep_cword()<CR>", "find by word under cursor")
			leader("fb", "<cmd>lua require('fzf-lua').buffers()<CR>", "find open buffers")
			leader("fd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", "LSP definitions")
			leader("fr", "<cmd>lua require('fzf-lua').lsp_references()<cr>", "LSP references")
			leader("ft", "<cmd>lua require('fzf-lua').lsp_typedefs()<cr>", "LSP type definitions")
			leader("fa", "<cmd>lua require('fzf-lua').lsp_code_actions()<cr>", "LSP code actions")
			map_n("gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", "LSP definitions")
		end,
	},
}
