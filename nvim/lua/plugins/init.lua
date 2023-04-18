local M = {
  "eandrju/cellular-automaton.nvim",
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "szw/vim-maximizer",
  "folke/lsp-colors.nvim",
  "tpope/vim-fugitive",
  "jghauser/mkdir.nvim",
  "RRethy/vim-illuminate",
  'nvim-pack/nvim-spectre'
}


local utils_with_config = {
  "windwp/nvim-autopairs",
  "m4xshen/smartcolumn.nvim",
  "simrat39/symbols-outline.nvim",
  "lewis6991/gitsigns.nvim",
  'simrat39/symbols-outline.nvim',
  'dnlhc/glance.nvim',
  "ThePrimeagen/harpoon",
}

for _, plug in pairs(utils_with_config) do
  table.insert(M, {
    plug, config=true
  })
end

local plugins_with_short_conf = require("utils.utils").plugins
for _, plug in pairs(plugins_with_short_conf) do
  table.insert(M, plug)
end



return M
