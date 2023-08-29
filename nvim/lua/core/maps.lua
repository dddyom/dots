-- Set the map leader
vim.g.mapleader = " "

-- Define the mappings
local maps = {
	i = {
		{ key = "jk", cmd = "<esc>", desc = "goto normal mode" },
		{ key = "kj", cmd = "<esc>", desc = "goto normal mode" },
		{ key = "<c-l>", cmd = "<esc>la", desc = "one step right" },
	},
	v = {
		{ key = "jk", cmd = "<esc>", desc = "goto normal mode" },
		{ key = "kj", cmd = "<esc>", desc = "goto normal mode" },
	},
	n = {
		{ key = "<c-d>", cmd = "<c-d>zz" },
		{ key = "<c-u>", cmd = "<c-u>zz" },
		{ key = "n", cmd = "nzzzv" },
		{ key = "<esc><esc>", cmd = "<esc>:nohlsearch<cr>", desc = "turn off highlight" },
		{ key = "L", cmd = "<cmd>bnext<cr>", desc = "next buffer" },
		{ key = "H", cmd = "<cmd>bprevious<cr>", desc = "previous buffer" },
		{ key = "<m-w>", cmd = "<cmd>bd<cr>", "close current buffer" },
	},
	leader = {
		{ key = "q", cmd = "<cmd>q!<CR>", desc = "exit" },
		{ key = "w", cmd = "<cmd>cd $HOME/WorkGit/<CR>", desc = "go to WorkGit" },
		{ key = "bv", cmd = "<c-w>v", desc = "split window vertically" },
		{ key = "bh", cmd = "<c-w>s", desc = "split window horisontally" },
		{ key = "bx", cmd = "<cmd>close<cr>", desc = "close current split window" },
	},
	leader_v = {
		{ key = "t", cmd = [[c{% trans %}<c-r>"{% endtrans %}<esc>]], desc = "{% trans %}{% endtrans %}" },
		{ key = "C", cmd = [[cconsole.log(<c-r>")<esc>]], desc = "console.log()" },
		{ key = "p", cmd = [[cprint(<c-r>")<esc>]], desc = "print()" },
		{ key = "P", cmd = [[cprint(f"\033[93m{<c-r>"}\033[0m")<esc>]], desc = "color print" },
		{ key = "%", cmd = [[c{% <c-r>" %}<esc>]], desc = "jinja func" },
		{ key = "{", cmd = [[c{{ <c-r>" }}<esc>]], desc = "jinja tag" },
		{ key = "d", cmd = [[:s/^[ \t]*$\n//<CR>]], desc = "delete empty lines" },
	},
}

-- Apply the mappings
for mode, map_table in pairs(maps) do
	require("utils.map").set_maps(map_table, require("utils.map")[mode])
end
