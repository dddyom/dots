local leader = require("utils.map").leader
local leader_v = require("utils.map").leader_v

return {
	"mg979/vim-visual-multi",
	"wintermute-cell/gitignore.nvim",
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
	-- {
	-- 	"AckslD/swenv.nvim",
	-- 	config = function()
	-- 		require("swenv").setup()
	-- 	end,
	-- },

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
				"gg",
				"<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true }):toggle()<cr>",
				"lazygit"
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
	{
		"sindrets/diffview.nvim",
		config = function()
			local actions = require("diffview.actions")
			vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
				group = vim.api.nvim_create_augroup("rafi_diffview", {}),
				pattern = "diffview:///panels/*",
				callback = function()
					vim.opt_local.cursorline = true
					vim.opt_local.winhighlight = "CursorLine:WildMenu"
				end,
			})
			require("diffview").setup({
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
				keymaps = {
					view = {
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "<c-e>", actions.toggle_files },
					},
					file_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "o", actions.focus_entry },
						{ "n", "gf", actions.goto_file },
						{ "n", "<C-r>", actions.refresh_files },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "o", actions.focus_entry },
					},
				},
			})
			leader("gd", "<cmd>DiffviewOpen<cr>", "Diffview open")
			leader("gh", "<cmd>DiffviewFileHistory %<cr>", "File history")
		end,
	},
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"FabijanZulj/blame.nvim",
		config = function()
			leader("gc", "<cmd>ToggleBlame window<cr>", "Show commits")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
			require("telescope").load_extension("projects")
			leader("fp", "<cmd>lua require'telescope'.extensions.projects.projects{}<cr>", "Find project")
		end,
	},
	-- DEBUG
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			-- DAP Configuration
			require("dap").virtual_text = true
			require("dap").virtual_text_max_length = 100
			require("dap").virtual_text_on_right = true
			require("dap-python").setup(vim.fn.system("which python")) -- Replace with your Python executable path

			-- Keybindings (customize as needed)
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg" })
			leader("dc", '<cmd>lua require"dap".continue()<CR>', "continue")
			leader("dn", '<cmd>lua require"dap".step_over()<CR>', "step over")
			leader("di", '<cmd>lua require"dap".step_into()<CR>', "step into")
			leader("do", '<cmd>lua require"dap".step_out()<CR>', "step out")
			leader("db", '<cmd>lua require"dap".toggle_breakpoint()<CR>', "toggle breakpoint")
			leader("dl", '<cmd>lua require"dap".list_breakpoints()<CR>', "list breakpoints")
			leader("dr", '<cmd>lua require"dap".repl.open()<CR>', "open repl")
		end,
	},
}
