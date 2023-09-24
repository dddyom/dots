local leader = require("utils.map").leader
local map_n = require("utils.map").n

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"cljoly/telescope-repo.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "benfowler/telescope-luasnip.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_set = require("telescope.actions.set")
		local action_state = require("telescope.actions.state")
		local utils = require("telescope.utils")
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
					n = {
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				help_tags = {
					attach_mappings = function(prompt_bufnr)
						action_set.select:replace(function(_, _)
							local selection = action_state.get_selected_entry()
							if selection == nil then
								utils.__warn_no_selection("builtin.help_tags")
								return
							end

							actions.close(prompt_bufnr)
							vim.cmd("FloatingHelp " .. selection.value)
						end)

						return true
					end,
				},
			},
			extensions = { repo = { list = { search_dirs = { "~/code", "~/WorkGit" } } } },
		})

		telescope.load_extension("repo")
		telescope.load_extension("ui-select")
		telescope.load_extension("luasnip")

		leader("ff", "<cmd>Telescope find_files<cr>", "find file")
		leader("fl", "<cmd>Telescope luasnip<cr>", "find file")
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
}
