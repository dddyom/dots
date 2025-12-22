return {
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
				end

				map("g[", gs.prev_hunk, "Prev hunk")
				map("g]", gs.next_hunk, "Next hunk")
				map("gr", gs.reset_hunk, "Reset hunk")
				map("gb", function()
					gs.blame_line()
				end, "Blame line")
				map("gp", gs.preview_hunk, "Preview hunk")
			end,
		},
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			local gc = require("git-conflict")

			gc.setup({
				default_mappings = false,
			})

			local group = vim.api.nvim_create_augroup("GitConflictLocalMaps", { clear = true })

			local function attach(bufnr)
				local opts = { buffer = bufnr, silent = true, remap = true }

				vim.keymap.set("n", "ch", "<Plug>(git-conflict-ours)", opts)
				vim.keymap.set("n", "cl", "<Plug>(git-conflict-theirs)", opts)
				vim.keymap.set("n", "cb", "<Plug>(git-conflict-both)", opts)
				vim.keymap.set("n", "c0", "<Plug>(git-conflict-none)", opts)
				vim.keymap.set("n", "cj", "<Plug>(git-conflict-prev-conflict)", opts)
				vim.keymap.set("n", "ck", "<Plug>(git-conflict-next-conflict)", opts)

				vim.keymap.set("n", "cs", function()
					vim.cmd("silent! wall")

					local first_buf_with_conflict, cnt = nil, 0
					for _, b in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(b) then
							local ok, n = pcall(gc.conflict_count, b)
							if ok and type(n) == "number" and n > 0 then
								first_buf_with_conflict, cnt = b, n
								break
							end
						end
					end

					if first_buf_with_conflict then
						vim.api.nvim_set_current_buf(first_buf_with_conflict)
						vim.notify(
							("Остались конфликты в файле: %d"):format(cnt),
							vim.log.levels.WARN
						)
						pcall(vim.cmd, "GitConflictNextConflict")
						return
					end

					vim.cmd("wqa")
				end, { buffer = bufnr, silent = true })

				vim.keymap.set("n", "cq", function()
					vim.cmd("silent! wall")
					vim.cmd("cquit")
				end, { buffer = bufnr, silent = true })
			end

			local function detach(bufnr)
				local keys = { "ch", "cl", "cb", "c0", "cj", "ck", "cs", "cq" }
				for _, lhs in ipairs(keys) do
					pcall(vim.keymap.del, "n", lhs, { buffer = bufnr })
				end
			end

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "GitConflictDetected",
				callback = function(args)
					attach(args.buf ~= 0 and args.buf or vim.api.nvim_get_current_buf())
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "GitConflictResolved",
				callback = function(args)
					detach(args.buf ~= 0 and args.buf or vim.api.nvim_get_current_buf())
				end,
			})
		end,
	},
}
