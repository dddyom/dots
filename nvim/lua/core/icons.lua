return {
	diagnostics = {
		error = "✘", --   ✘
		warn = "󰀪", -- 󰀪 󰳤 󱦄 󱗓 
		info = "ⁱ", --    ⁱ 󰋼 󰋽
		hint = "", --  󰌶 
	},
	buffers = {
		modified = " 󰇤", -- ● 󰇤
		alternate_file = "", -- #
		directory = "",
		no_name = "[No name]", --  󱗆 󰇥
	},
	notify = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	git = {
		added = "", --  ₊
		copied = "󰆏",
		modified = "", --  ∗
		removed = "", --  ₋
		deleted = "",
		ignored = "",
		rename = "",
		renamed = "",
		diff = "",
		repo = "",
		typechanged = "󰉺",
		untracked = "", -- 
		unmodified = " ",
		unmerged = "",
		upstream_added = "󰈞",
		upstream_copied = "󰈢",
		upstream_deleted = "",
		upstream_ignored = " ",
		upstream_modified = "󰏫",
		upstream_renamed = "",
		upstream_typechanged = "󱧶",
		upstream_unmodified = " ",
		upstream_unmerged = "",
		upstream_untracked = " ",
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "┘" },
			topdelete = { text = "┐" },
			changedelete = { text = "├" },
			untracked = { text = "┤" },
		},
	},
	kinds = {
		Array = "󰅪 ", --  󰅪 󰅨 󱃶
		Boolean = "◩ ", --  ◩ 󰔡 󱃙 󰟡 󰨙
		Class = "󰌗 ", --  󰌗 󰠱 𝓒
		Color = "󰏘 ", -- 󰸌 󰏘
		Constant = "󰏿 ", --   󰏿
		Constructor = "󰆧 ", --  󰆧   
		Copilot = " ", -- 
		Enum = "󰕘 ", --  󰕘  ℰ 
		EnumMember = " ", --  
		Event = " ", --  
		Field = " ", -- 󰄶  󰆨  󰀻 󰃒
		File = " ", --    󰈔 󰈙
		Folder = " ", --   󰉋
		Function = "󰊕 ", --  󰊕 
		Interface = " ", --    
		Key = " ", -- 
		Keyword = " ", --   󰌋 
		Method = "󰆧 ", --  󰆧 ƒ
		Module = " ", --   󰅩 󰆧 󰏗
		Namespace = " ", --   󰅩
		Null = " ", --  󰟢
		Number = "󰎠 ", --  󰎠 
		Object = " ", --   󰅩
		Operator = "󰃬 ", --  󰃬 󰆕 +
		Package = " ", --   󰏖 󰏗
		Property = "󰖷 ", --  󰜢  
		Reference = "󰈝 ", --  󰈝 󰈇
		Snippet = " ", --  󰘌 ⮡   
		String = "󰅳 ", --  󰅳
		Struct = " ", --   𝓢 󰙅 󱏒
		Text = " ", --   󰉿 𝓐
		TypeParameter = " ", --  󰊄 𝙏
		Unit = " ", --   󰑭 
		Value = " ", --   󰀬 󰎠
		Variable = " ", --   󰀫 
	},

	sources = {
		buffer = "📔",
		path = "📁",
		nvim_lsp = "⚡",
		luasnip = "🔑",
	},
}
