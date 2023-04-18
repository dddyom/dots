local M = {}

M.normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}


M.normal_maps = {
  ['H'] = {'<cmd>lua require("harpoon.ui").nav_prev()<CR>', "prev mark"},
  ['L'] = {'<cmd>lua require("harpoon.ui").nav_next()<CR>', "next mark"},
  ['M'] = {'<cmd>lua require("harpoon.mark").add_file()<CR>', 'add mark'},

}

return M
