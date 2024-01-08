local kind_icons = {
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
}

local outline_defaults = {
	File = { icon = "󰈔", hl = "Identifier" },
	Module = { icon = "󰆧", hl = "Include" },
	Namespace = { icon = "󰅪", hl = "Include" },
	Package = { icon = "󰏗", hl = "Include" },
	Class = { icon = "𝓒", hl = "Type" },
	Method = { icon = "ƒ", hl = "Function" },
	Property = { icon = "", hl = "Identifier" },
	Field = { icon = "󰆨", hl = "Identifier" },
	Constructor = { icon = "", hl = "Special" },
	Enum = { icon = "ℰ", hl = "Type" },
	Interface = { icon = "󰜰", hl = "Type" },
	Function = { icon = "", hl = "Function" },
	Variable = { icon = "", hl = "Constant" },
	Constant = { icon = "", hl = "Constant" },
	String = { icon = "𝓐", hl = "String" },
	Number = { icon = "#", hl = "Number" },
	Boolean = { icon = "⊨", hl = "Boolean" },
	Array = { icon = "󰅪", hl = "Constant" },
	Object = { icon = "⦿", hl = "Type" },
	Key = { icon = "🔐", hl = "Type" },
	Null = { icon = "NULL", hl = "Type" },
	EnumMember = { icon = "", hl = "Identifier" },
	Struct = { icon = "𝓢", hl = "Structure" },
	Event = { icon = "🗲", hl = "Type" },
	Operator = { icon = "+", hl = "Identifier" },
	TypeParameter = { icon = "𝙏", hl = "Identifier" },
	Component = { icon = "󰅴", hl = "Function" },
	Fragment = { icon = "󰅴", hl = "Constant" },
	TypeAlias = { icon = " ", hl = "Type" },
	Parameter = { icon = " ", hl = "Identifier" },
	StaticMethod = { icon = " ", hl = "Function" },
	Macro = { icon = " ", hl = "Function" },
}
local function outline_icons()
	local res = {}
	for outlineKind, default in pairs(outline_defaults) do
		res[outlineKind] = {
			icon = kind_icons[outlineKind] or default.icon,
			hl = default.hl,
		}
	end
	return res
end

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
	kinds = kind_icons,
	outline = outline_icons(),

	sources = {
		buffer = "📔",
		path = "📁",
		nvim_lsp = "⚡",
		luasnip = "🔑",
	},
}
