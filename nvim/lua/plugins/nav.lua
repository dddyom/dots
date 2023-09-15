local map_n = require("utils.map").n
return {
	{
		"stevearc/oil.nvim",
		config = true,
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
		"ghillb/cybu.nvim",
		branch = "main",
		config = function()
			require("cybu").setup()
			vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
			vim.keymap.set("n", "L", "<Plug>(CybuNext)")
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()

			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

			vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
		end,
	},
}
