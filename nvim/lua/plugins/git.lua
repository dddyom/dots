return {
	-----------------------------------------------------------------------------
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<Leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Diff File" },
			{ "<Leader>g", "", desc = "git" },
			{ "<Leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
		},
		opts = function()
			local actions = require("diffview.actions")
			vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
				group = vim.api.nvim_create_augroup("diffview", {}),
				pattern = "diffview:///panels/*",
				callback = function()
					vim.opt_local.cursorline = true
					vim.opt_local.winhighlight = "CursorLine:WildMenu"
				end,
			})

			return {
				enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
				hooks = {
					diff_buf_win_enter = function(bufnr, winid, ctx)
						if ctx.layout_name:match("^diff2") then
							if ctx.symbol == "a" then
								vim.opt_local.winhl = table.concat({
									"DiffAdd:DiffviewDiffAddAsDelete",
									"DiffDelete:DiffviewDiffDelete",
								}, ",")
							elseif ctx.symbol == "b" then
								vim.opt_local.winhl = table.concat({
									"DiffDelete:DiffviewDiffDelete",
								}, ",")
							end
						end
					end,
				},
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
					use_icons = false,
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
			}
		end,
	},
	-----------------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		-- See: https://github.com/lewis6991/gitsigns.nvim#usage
		opts = {
			signs = require("core.icons").git.signs,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			attach_to_untracked = true,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			preview_config = {
				border = "rounded",
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				---@return string
				map("n", "g]", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Git hunk forward" })

				map("n", "g[", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Git hunk last" })

				map("n", "<leader>gc", function()
					gs.blame_line()
				end, { desc = "Show blame commit" })
				map("n", "<leader>gC", function()
					gs.blame_line({ full = true })
				end, { desc = "Show blame commit for block" })
			end,
		},
	},
	-----------------------------------------------------------------------------
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre ",
		config = true,
		keys = {
			{ "co", "<Plug>(git-conflict-ours)", "ours" },
			{ "ct", "<Plug>(git-conflict-theirs)", "theirs" },
			{ "cb", "<Plug>(git-conflict-both)", "both" },
			{ "c0", "<Plug>(git-conflict-none)", "none" },
			{ "c[", "<Plug>(git-conflict-prev-conflict)", "prev conflict" },
			{ "c]", "<Plug>(git-conflict-next-conflict)", "next conflict" },
		},
	},
}
