local M = {
    "AckslD/nvim-neoclip.lua"
}
M.dependencies = {
  'nvim-telescope/telescope.nvim'
}
M.config = function()
    require('neoclip').setup({
      default_register = {'+', '*', '"'}
    })
    require "telescope".load_extension "neoclip"
end

return M

