return {
	-----------------------------------------------------------------------------
	{ "AndrewRadev/tagalong.vim", event = "BufEnter *.html" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "vidocqh/auto-indent.nvim", opts = {} },
	{ "gregorias/coerce.nvim", tag = "v0.1.1", config = true },
	{ "chrisgrieser/nvim-puppeteer", lazy = false },
	-----------------------------------------------------------------------------
	{
		"stevearc/aerial.nvim",
		opts = {},
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end,
	},
	-----------------------------------------------------------------------------
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		keys = { { "!", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" } },
	},
	-----------------------------------------------------------------------------
	{
		"chrisgrieser/nvim-recorder",
		opts = {
			mapping = {
				startStopRecording = "<leader>q",
				playMacro = "@q",
				switchSlot = "<C-q>",
				editMacro = "cq",
				deleteAllMacros = "dq",
				yankMacro = "yq",
			},
		},
	},
	-----------------------------------------------------------------------------
	{

		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"lukas-reineke/cmp-under-comparator",
			{ "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
		},
		event = "BufEnter",
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local function has_words_before()
				if vim.bo.buftype == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				-- stylua: ignore
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
			end

			return {
				preselect = cmp.PreselectMode.None,
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				experimental = {
					ghost_text = {
						hl_group = "Comment",
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 10 },
					{ name = "path", priority = 40 },
					{ name = "luasnip", priority = 30 },
				}, {
					{ name = "buffer", priority = 50, keyword_length = 3 },
				}),
				mapping = cmp.mapping.preset.insert({
					-- <CR> accepts currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({
							select = true,
							behavior = cmp.ConfirmBehavior.Replace,
						}),
						-- Do not set command mode, it will interfere with noice popmenu.
					}),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-d>"] = cmp.mapping.select_next_item({ count = 5 }),
					["<C-u>"] = cmp.mapping.select_prev_item({ count = 5 }),
					["<Down>"] = cmp.mapping.scroll_docs(4),
					["<Up>"] = cmp.mapping.scroll_docs(-4),
					["<C-c>"] = function(fallback)
						cmp.close()
						fallback()
					end,
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					format = function(entry, vim_item)
						local icons = require("core.icons")
						vim_item.menu = icons.sources[entry.source.name]
						if entry.source.name == "git" then
							vim_item.kind = icons.git
						else
							local symbol = icons.kinds[vim_item.kind]
							if symbol ~= nil then
								vim_item.kind = symbol
							end
						end
						return vim_item
					end,
				},
			}
		end,
	},

	-----------------------------------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		keys = {
			{
				"<C-l>",
				function()
					require("luasnip").expand_or_jump()
				end,
				mode = { "i", "s" },
			},
		},
		opts = {
			-- Don't store snippet history for less overhead
			history = false,
			-- Event on which to check for exiting a snippet's region
			region_check_events = "InsertEnter",
			delete_check_events = "InsertLeave",
			ft_func = function()
				return vim.split(vim.bo.filetype, ".", { plain = true })
			end,
		},
		config = function(_, opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	-----------------------------------------------------------------------------
	{
		"danymat/neogen",
		-- stylua: ignore
		event = "BufEnter",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "doc string",
			},
			{ "<leader>c", "", desc = "neogen" },
		},
		opts = {
			snippet_engine = "luasnip",
			enabled = true,
			languages = {
				python = {
					template = {
						annotation_convention = "reST",
					},
				},
			},
		},
	},
	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.surround",
		-- stylua: ignore
		keys = function(_, keys)
			-- Populate the keys based on the user's options
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
		"b3nj5m1n/kommentary",
		event = "VeryLazy",
		config = function()
			local comments = require("kommentary.config")

			comments.use_extended_mappings()
			comments.configure_language("default", {
				single_line_comment_string = "auto",
				multi_line_comment_strings = "auto",
				hook_function = function()
					require("ts_context_commentstring").update_commentstring()
				end,
			})
		end,
	},

	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.trailspace",
		config = function()
			require("mini.trailspace").setup({})
		  -- stylua: ignore
			vim.keymap.set( "n", "<leader>C", "<cmd>lua require('mini.trailspace').trim()<CR>", { desc = "Trim trailing whitespace" })
		end,
	},

	-----------------------------------------------------------------------------
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		keys = {
			{ "<Leader>h", "", desc = "HTTP request" },
			{ "<Leader>hh", "<Plug>RestNvim<CR>", desc = "Execute" },
		},
		opts = { skip_ssl_verification = true },
	},
	-----------------------------------------------------------------------------
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
		"klen/nvim-test",
		config = function()
			require("nvim-test").setup({ term = "toggleterm" })
		end,
		keys = {
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
			{ "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test all" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
			{ "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test current" },
		},
	},
}
