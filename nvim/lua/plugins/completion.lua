-----------------------------------------------------------------------------
-- Автодополнение (blink.cmp)
return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v1.0.0",
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },

				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },

				["<Up>"] = { "snippet_backward", "fallback" },
				["<Down>"] = { "snippet_forward", "fallback" },

				["<C-p>"] = {},
				["<C-n>"] = {},

				["<C-b>"] = {},
				["<C-f>"] = {},
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				menu = {
					auto_show = true,
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},
			signature = { enabled = true },
			sources = {
				default = function(ctx)
					local success, node = pcall(vim.treesitter.get_node)
					if
						success
						and node
						and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
					then
						return { "buffer", "path" }
					else
						return { "lsp", "path", "snippets", "buffer" }
					end
				end,
			},
		},
	},
}
