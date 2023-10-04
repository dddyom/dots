local leader = require("utils.map").leader
local leader_v = require("utils.map").leader_v

return {
	"mg979/vim-visual-multi",
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup()
		end,
	},
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
		"rest-nvim/rest.nvim",
		config = function()
			require("rest-nvim").setup()
			leader("h", "", "Http request")
			leader("hh", "<cmd>lua require('rest-nvim').run()<cr>", "run current line http request")
			leader("hp", "<cmd>lua require('rest-nvim').preview()<cr>", "curl preview")
			leader("hl", "<cmd>lua require('rest-nvim').last()<cr>", "run last http request")
		end,
	},
	{
		"chrisgrieser/nvim-recorder",
		opts = {
			slots = { "a", "b" },
			lessNotifications = true,
			mapping = {
				startStopRecording = "<leader>q",
			},
		},
	},
	{
		"Dhanus3133/LeetBuddy.nvim",
		config = function()
			require("leetbuddy").setup({})
      leader("l", "", "LeetCode")
			leader("lq", "<cmd>LBQuestions<cr>", "List Questions")
			leader("ll", "<cmd>LBQuestion<cr>", "View Question")
			leader("lr", "<cmd>LBReset<cr>", "Reset Code")
			leader("lt", "<cmd>LBTest<cr>", "Run Code")
			leader("ls", "<cmd>LBSubmit<cr>", "Submit Code")
		end,
	},
}
