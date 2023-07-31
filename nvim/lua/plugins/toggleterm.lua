local M = {
  "akinsho/toggleterm.nvim"
}
M.config = function ()
  require("toggleterm").setup({
    direction = 'float'
  })
end

function _lazygit_toggle()
  local Terminal  = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  lazygit:toggle()
end

return M
