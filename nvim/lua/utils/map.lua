local M = {}

-- Utility function to create key mappings
local map = function(mode, key, cmd, desc)
	vim.api.nvim_set_keymap(mode, key, cmd, { silent = true, noremap = true, nowait = false, desc = desc })
end

-- Function to set mappings from a table
M.set_maps = function(map_table, mode_fn)
	for _, m in pairs(map_table) do
		mode_fn(m.key, m.cmd, m.desc)
	end
end

-- Function to create specific mapping functions based on mode and optional base key
local function create_map_fn(mode, base_key)
	return function(key, cmd, desc)
		if base_key then
			key = base_key .. key
		end
		map(mode, key, cmd, desc)
	end
end

-- Prefixes for key mappings
M.prefixes = {
	["<leader>"] = {
		f = { name = "Telescope" },
		b = { name = "Buffers" },
		c = { name = "Change dir" },
		d = { name = "DB" },
		h = { name = "Http requests" },
		r = { name = "Replace" },
	},
	["g"] = {
		["?"] = { name = "Debug print" },
	},
}

-- Create mapping functions for different modes and prefixes
M.n = create_map_fn("n")
M.v = create_map_fn("v")
M.i = create_map_fn("i")
M.c = create_map_fn("c")
M.leader = create_map_fn("n", "<leader>")
M.leader_v = create_map_fn("v", "<leader>")

return M
