return {
	-----------------------------------------------------------------------------
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "vidocqh/auto-indent.nvim", opts = {}, event = "VimEnter" },
	-----------------------------------------------------------------------------
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.3.0",
		opts = {
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			nerd_font_variant = "mono",
			keymap = {
				show = "<C-space>",
				hide = "<C-e>",
				accept = "<Enter>",
				select_prev = { "<S-Tab>" },
				select_next = { "<Tab>" },
				show_documentation = "<C-space>",
				hide_documentation = "<C-space>",
				scroll_documentation_up = "<C-b>",
				scroll_documentation_down = "<C-f>",

				snippet_forward = "<C-n>",
				snippet_backward = "<C-p>",
			},
			accept = { auto_brackets = { enable = true } },
			trigger = {
				signature_help = {
					enable = true,
					show_on_insert_on_trigger_character = false,
				},
				completion = {
					show_on_insert_on_trigger_character = false,
				},
			},
			kind_icons = require("core.icons").kinds,
		},
	},
	----------------------------------------------------------------------------
	{
		"chrisgrieser/nvim-recorder",
		event = "VimEnter",
		opts = {
			mapping = {
				startStopRecording = "<leader>q",
				playMacro = "<S-q>",
				switchSlot = "<C-q>",
				editMacro = "cq",
				deleteAllMacros = "dq",
				yankMacro = "yq",
			},
		},
	},
	{ "akinsho/flutter-tools.nvim", lazy = false, config = true },
	-----------------------------------------------------------------------------
	{
		"danymat/neogen",
		event = "BufEnter",
		-- stylua: ignore
		keys = {
			{ "<leader>c", "", desc = "neogen" },
			{ "<leader>cc", function() require("neogen").generate({}) end, desc = "doc string" },
		},
		opts = { snippet_engine = "luasnip", enabled = true },
	},
	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.surround",
		event = "VimEnter",
		-- stylua: ignore
		keys = function(_, keys)
			local plugin = require('lazy.core.config').spec.plugins['mini.surround']
			local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
			local mappings = {
				{ opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'x' } },
				{ opts.mappings.delete, desc = 'Delete surrounding' },
				{ opts.mappings.find, desc = 'Find right surrounding' },
				{ opts.mappings.find_left, desc = 'Find left surrounding' },
				{ opts.mappings.highlight, desc = 'Highlight surrounding' },
				{ opts.mappings.replace, desc = 'Replace surrounding' },
				{ opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "cs", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
	},
	-----------------------------------------------------------------------------
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup({ silent = true })
			vim.keymap.set("i", "<c-a>", neocodeium.accept)
			vim.keymap.set("i", "<c-w>", neocodeium.accept_word)
			vim.keymap.set("i", "<c-e>", neocodeium.accept_line)
			local toggle = function()
				require("neocodeium.commands").toggle()
				local is_enabled = require("neocodeium.options").options.enabled
				local message = "AI completion " .. (is_enabled and "enabled" or "disabled") .. "."
				vim.notify(message, vim.log.levels.INFO, { title = "NeoCodeium" })
			end

			vim.keymap.set("n", "<leader>x", toggle, { desc = "Toggle neocodeium" })
		end,
	},
}
