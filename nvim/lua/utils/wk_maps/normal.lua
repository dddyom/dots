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
  ['rc'] = {":SnipRun<cr>", 'run code'},
  ['<m-l>'] = {'<cmd>bnext<cr>', 'next buffer'},
  ['<m-h>'] = {'<cmd>bprevious<cr>', 'previous buffer'},
  ['<m-w>'] = {"<cmd>bd<cr>", "close current buffer"},
  ['<c-h>'] = {':<C-U>TmuxNavigateLeft<cr>', 'tmux left'},
  ['<c-l>'] = {':<C-U>TmuxNavigateRight<cr>', 'tmux right'},
  ['<c-j>'] = {':<C-U>TmuxNavigateDown<cr>', 'tmux down'},
  ['<c-k>'] = {':<C-U>TmuxNavigateUp<cr>', 'tmux up'},

}
return M
