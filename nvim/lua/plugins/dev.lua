local leader = require("utils.map").leader
local leader_v = require("utils.map").leader_v

return {
	"mg979/vim-visual-multi",
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<c-a>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			leader("/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment")
			leader_v("/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Comment")
		end,
	},

	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("venv-selector").setup()
			leader("v", "<cmd>VenvSelect<cr>", "select venv")
		end,
		opts = { parents = 4 },
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		config = function()
			vim.g.dbs = require("utils.utils").get_dbs()
			vim.db_ui_save_location = "~/.queries"
		end,
	},

	{
		"rest-nvim/rest.nvim",
		config = function()
			require("rest-nvim").setup()
			leader("h", "", "rest")
			leader("hh", "<cmd>lua require('rest-nvim').run()<cr>", "run current line http request")
			leader("hp", "<cmd>lua require('rest-nvim').preview()<cr>", "curl preview")
			leader("hl", "<cmd>lua require('rest-nvim').last()<cr>", "run last http request")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({ direction = "float" })
			leader("t", "<cmd>ToggleTerm<cr>", "TERMINAL")
			leader(
				"g",
				"<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true }):toggle()<cr>",
				"GIT"
			)
		end,
	},

	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
	{ -- macros
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify",
		opts = {
			slots = { "a", "b" },
			lessNotifications = true,
		},
	},

	-- GIT
	"sindrets/diffview.nvim",
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"FabijanZulj/blame.nvim",
		config = function()
			leader("a", "<cmd>ToggleBlame window<cr>", "Git blame")
		end,
	},
}
