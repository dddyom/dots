return {
	diagnostics = {
		error = "✘", --   ✘
		warn = "󰀪", -- 󰀪 󰳤 󱦄 󱗓 
		info = "ⁱ", --    ⁱ 󰋼 󰋽
		hint = "", --  󰌶 
	},
	buffers = {
		modified = " 󰇤", -- ● 󰇤
		alternate_file = "#",
		directory = "",
	},

	git = {
		added = "", --  ₊
		modified = "", --  ∗
		removed = "", --  ₋
		ignored = "",
		rename = "",
		diff = "",
		repo = "",
		untracked = "",
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
