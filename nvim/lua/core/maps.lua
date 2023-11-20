vim.g.mapleader = " "

local maps = {
	i = {
		{ key = "jk", cmd = "<esc>", desc = "goto normal mode" },
		{ key = "kj", cmd = "<esc>", desc = "goto normal mode" },
	},
	v = {
		{ key = "jk", cmd = "<esc>", desc = "goto normal mode" },
		{ key = "kj", cmd = "<esc>", desc = "goto normal mode" },
	},
	n = {
		{
			key = "q",
			cmd = "<cmd>lua require('utils.utils').remap_q()<CR>",
			desc = "close floating window",
		},
		{ key = "<c-d>", cmd = "<c-d>zz" },
		{ key = "<c-u>", cmd = "<c-u>zz" },
		{ key = "<m-i>", cmd = "^" },
		{ key = "<m-S-i>", cmd = "0" },
		{ key = "<m-a>", cmd = "$" },
		{ key = "n", cmd = "nzzzv" },
		{ key = "W", cmd = "viw" },
		{ key = "<esc><esc>", cmd = "<esc>:nohlsearch<cr>", desc = "turn off highlight" },
		{ key = "L", cmd = "<cmd>bnext<cr>", desc = "next buffer" },
		{ key = "H", cmd = "<cmd>bprevious<cr>", desc = "previous buffer" },
		{ key = "<m-q>", cmd = "<cmd>bd<cr>", desc = "close current buffer" },
		{ key = "<m-e>", cmd = "<cmd>%bd|e#|bd#<cr>", desc = "close current buffer" },
		{ key = "<m-w>", cmd = "<cmd>bd<cr>", desc = "close current buffer" },
	},
	leader = {
		{ key = "\\", cmd = "<c-w>v", desc = "split window vertically" },
		{ key = "|", cmd = "<c-w>v", desc = "split window vertically" },
		{ key = "-", cmd = "<c-w>s", desc = "split window horisontally" },
		{ key = "g", cmd = "", desc = "Git" },
		{
			key = "gc",
			cmd = "<cmd>lua require('utils.utils').show_commit()<CR>",
			desc = "show commit log of current file",
		},
		{
			key = "W",
			cmd = "<cmd>lua require('utils.utils').floating_window(nil, 120, 20, 'markdown')<CR>",
			desc = "floating window",
		},
	},
	leader_v = {
		{ key = "t", cmd = [[c{% trans %}<c-r>"{% endtrans %}<esc>]], desc = "{% trans %}{% endtrans %}" },
		{ key = "C", cmd = [[cconsole.log(<c-r>")<esc>]], desc = "console.log()" },
		{ key = "p", cmd = [[cprint(<c-r>")<esc>]], desc = "print()" },
		{ key = "P", cmd = [[cprint(f"\033[93m{<c-r>"}\033[0m")<esc>]], desc = "color print" },
		{ key = "%", cmd = [[c{% <c-r>" %}<esc>]], desc = "jinja func" },
		{ key = "}", cmd = [[c{{ <c-r>" }}<esc>]], desc = "jinja tag" },
		{ key = "d", cmd = [[:s/^[ \t]*$\n//<CR>]], desc = "delete empty lines" },
	},
}
-- Apply the mappings
for mode, map_table in pairs(maps) do
	require("utils.map").set_maps(map_table, require("utils.map")[mode])
end
