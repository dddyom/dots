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
  local params = require("core.maps")
  wk.register(params.leader_maps, params.leader_opts)
  wk.register(params.surround_maps, params.surround_opts)
  wk.register(params.normal_maps, params.normal_opts)
end

return M
