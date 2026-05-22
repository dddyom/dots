return {
	-----------------------------------------------------------------------------
	-- Treesitter: подсветка, indent, парсеры
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			-- контекст (заголовок функции/блока)
			{ "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
			-- комментарии на базе treesitter
			{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
		},
		opts = {
			highlight = { enable = true },
			indent = { enable = true, disable = { "markdown" } },
            -- stylua: ignore start
			ensure_installed = {
				"python", "bash", "css", "html", "json", "htmldjango", "http",
				"javascript", "lua", "make", "regex", "rust", "tsx", "typescript",
				"dockerfile", "markdown", "markdown_inline",
			},
			-- stylua: ignore end
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			-- master-ветка nvim-treesitter архивирована и не совместима с Neovim 0.11+:
			-- match[id] теперь TSNode[], а директивы плагина ждут одиночный TSNode.
			-- Перерегистрируем три задетых директивы, разворачивая первый узел из списка.
			local q = require("vim.treesitter.query")
			local function first_node(match, id)
				local n = match[id]
				if type(n) == "table" then
					return n[1]
				end
				return n
			end

			local html_script_type_languages = {
				importmap = "json",
				module = "javascript",
				["application/ecmascript"] = "javascript",
				["text/ecmascript"] = "javascript",
			}

			local injection_aliases = {
				ex = "elixir",
				pl = "perl",
				sh = "bash",
				uxn = "uxntal",
				ts = "typescript",
			}

			q.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
				local node = first_node(match, pred[2])
				if not node then
					return
				end
				local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
				local configured = html_script_type_languages[type_attr_value]
				if configured then
					metadata["injection.language"] = configured
				else
					local parts = vim.split(type_attr_value, "/", {})
					metadata["injection.language"] = parts[#parts]
				end
			end, { force = true })

			q.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
				local node = first_node(match, pred[2])
				if not node then
					return
				end
				local alias = vim.treesitter.get_node_text(node, bufnr):lower()
				local ft = vim.filetype.match({ filename = "a." .. alias })
				metadata["injection.language"] = ft or injection_aliases[alias] or alias
			end, { force = true })

			q.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
				local id = pred[2]
				local node = first_node(match, id)
				if not node then
					return
				end
				local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
				if not metadata[id] then
					metadata[id] = {}
				end
				metadata[id].text = string.lower(text)
			end, { force = true })
		end,
	},

	-----------------------------------------------------------------------------
	-- Авто-закрытие HTML/XML-тегов через treesitter
	{ "tronikelis/ts-autotag.nvim", opts = {}, event = "VeryLazy" },
}
