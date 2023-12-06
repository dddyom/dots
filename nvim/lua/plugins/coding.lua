return {
	-----------------------------------------------------------------------------
	{ "AndrewRadev/tagalong.vim", event = "BufEnter *.html" },
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
	-----------------------------------------------------------------------------
	{

		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
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
				sorting = defaults.sorting,
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
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.select_next_item({ count = 5 }),
					["<C-u>"] = cmp.mapping.select_prev_item({ count = 5 }),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
		keys = {
			{
				'<leader>cc',
				function() require('neogen').generate({}) end,
				desc = 'Neogen Comment',
			},
		},
		opts = { snippet_engine = "luasnip" },
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

	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.trailspace",
		opts = {},
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
}
