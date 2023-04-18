local M = {}

M.visual_opts = {
  mode = "v",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.visual_maps = {
  ['rc'] = {":'<,'>SnipRun<cr>", 'run code'},
}

return M
