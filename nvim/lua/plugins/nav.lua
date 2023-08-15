local leader = require("utils.map").leader
local map_n = require("utils.map").n

local M = {
  {
    'christoomey/vim-tmux-navigator',
    config = function ()
      map_n('<m-h>', ':<c-u>TmuxNavigateLeft<cr>', 'tmux left')
      map_n('<m-l>', ':<c-u>TmuxNavigateRight<cr>', 'tmux right')
      map_n('<m-j>', ':<c-u>TmuxNavigateDown<cr>', 'tmux down')
      map_n('<m-k>', ':<c-u>TmuxNavigateUp<cr>', 'tmux up')
    end
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup()
      leader('m', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'marks menu')
      map_n('M', '<cmd>lua require("harpoon.mark").add_file()<CR>', 'add mark')
      map_n('<m-p>', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', 'prev mark')
      map_n('<m-n>', '<cmd>lua require("harpoon.ui").nav_next()<CR>', 'next mark')
    end
  }
}

return M
