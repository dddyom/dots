return {
	diagnostics = {
		error = "✘", --   ✘
		warn = "󰀪", -- 󰀪 󰳤 󱦄 󱗓 
		info = "ⁱ", --    ⁱ 󰋼 󰋽
		hint = "", --  󰌶 
	},
	buffers = {
		modified = "󰇤", -- ● 󰇤
		alternate_file = "", -- #
		directory = "",
		no_name = "[No name]", --  󱗆 󰇥
	},
	notifier = {
		debug = "",
		error = "",
		info = "",
		trace = "✎",
		warn = "",
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
}
