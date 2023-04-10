local M = {
  "eandrju/cellular-automaton.nvim",
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "szw/vim-maximizer",
  "folke/lsp-colors.nvim",
  "tpope/vim-fugitive",
  "jghauser/mkdir.nvim",
  "RRethy/vim-illuminate"
}


local utils_with_config = {
  "windwp/nvim-autopairs",
  "m4xshen/smartcolumn.nvim",
  "simrat39/symbols-outline.nvim",
  "lewis6991/gitsigns.nvim",
  "s1n7ax/nvim-search-and-replace",
  'simrat39/symbols-outline.nvim',
  'dnlhc/glance.nvim',
  "ThePrimeagen/harpoon",
}

for _, plug in pairs(utils_with_config) do
  table.insert(M, {
    plug, config=true
  })
end

local utils_with_more_params = {
  {
    "norcalli/nvim-colorizer.lua",
    config = function () require("colorizer").setup() end
  },
  {
  "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
  }, {
  "jackMort/ChatGPT.nvim",
      config = true,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  }, {
        'm-demare/hlargs.nvim',
        dependencies={ 'nvim-treesitter/nvim-treesitter' },
        config = function ()
          require('hlargs').setup()
        end
    }
}

for _, plug in pairs(utils_with_more_params) do
  table.insert(M, plug)
end

return M
