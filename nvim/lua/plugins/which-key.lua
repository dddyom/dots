local M = {
    "folke/which-key.nvim",
}

M.config = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  local wk = require("which-key")
  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }
  wk.setup(conf)
  local leader = require("utils.wk_maps.leader")
  local normal = require("utils.wk_maps.normal")
  local visual = require("utils.wk_maps.visual")
  local surround = require("utils.wk_maps.surround")
  local print = require("utils.wk_maps.print")

  wk.register(leader.leader_maps, leader.leader_opts)
  wk.register(normal.normal_maps, normal.normal_opts)
  wk.register(visual.visual_maps, visual.visual_opts)
  wk.register(surround.surround_maps, surround.surround_opts)
  wk.register(print.print_maps, print.print_opts)
  wk.register(print.v_print_maps, print.v_print_opts)
end

return M
