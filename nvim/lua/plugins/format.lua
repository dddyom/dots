local leader = require("utils.map").leader
local map_n = require("utils.map").n

return {

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "VeryLazy",
		config = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			map_n("zR", "lua require('ufo').openAllFolds<cr>", "open all folds")
			map_n("zC", "lua require('ufo').closeAllFolds<cr>", "close all folds")
		end,
	},
	{
		"Wansmer/treesj",
		config = function()
			require("treesj").setup({ use_default_keymaps = true })
			leader("j", "<cmd>lua require('treesj').toggle()<cr>", "toggle args split")
		end,
	},

	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },

	{
		"roobert/search-replace.nvim",
		config = function()
			require("search-replace").setup()
			vim.o.inccommand = "split"
			leader("rr", "<cmd>SearchReplaceSingleBufferCWord<cr>", "Replace in current buffer (word under cursor)")
			leader("rR", "<cmd>SearchReplaceMultiBufferCWord<cr>", "Replace in all buffers")
			leader(
				"re",
				"<cmd>SearchReplaceSingleBufferCExpr<cr>",
				"Replace in current buffer (expession under cursor)"
			)
			leader("rE", "<cmd>SearchReplaceMultiBufferCExpr<cr>", "Replace in current buffer")
		end,
	},

	{
		"elentok/format-on-save.nvim",
		config = function()
			require("format-on-save").setup({})
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<c-f>",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},

	{
		"andrewferrier/debugprint.nvim",
		config = function()
			local my_filetypes = {}
			my_filetypes.python = {
				left = 'print("\x1b[30;42m" + f"',
				right = '" + "\033[0m")',
				mid_var = "{",
				right_var = '}" + "\x1b[0m")',
			}
			require("debugprint").setup({ filetypes = my_filetypes })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"jeetsukumaran/vim-pythonsense",
			"RRethy/nvim-treesitter-textsubjects",
		},
		build = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"rust",
					"python",
					"lua",
					"http",
					"json",
					"jq",
					"html",
					"htmldjango",
					"javascript",
					"typescript",
					"css",
					"vim",
					"markdown",
					"yaml",
					"sql",
					"regex",
					"bash",
					"dockerfile",
					"markdown_inline",
				},
				textsubjects = {
					enable = true,
					prev_selection = ",",
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
				markid = { enable = true },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				rainbow = {
					enable = true,
					disable = { "html" },
					extended_mode = false,
					max_file_lines = nil,
				},
				autotag = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },
			})
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
}
