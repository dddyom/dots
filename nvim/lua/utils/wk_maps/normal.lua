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
  -- ['rc'] = {":SnipRun<cr>", 'run code'},
  ['<m-w>'] = {"<cmd>bd<cr>", "close current buffer"},
  ['<m-h>'] = {':<c-u>TmuxNavigateLeft<cr>', 'tmux left'},
  ['<m-l>'] = {':<c-u>TmuxNavigateRight<cr>', 'tmux right'},
  ['<m-j>'] = {':<c-u>TmuxNavigateDown<cr>', 'tmux down'},
  ['<m-k>'] = {':<c-u>TmuxNavigateUp<cr>', 'tmux up'},
  ['<m-p>'] = {'<cmd>bnext<cr>', 'next buffer'},
  ['<m-n>'] = {'<cmd>bprevious<cr>', 'previous buffer'},

}
return M
