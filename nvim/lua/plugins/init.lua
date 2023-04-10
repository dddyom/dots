local M = {
  "eandrju/cellular-automaton.nvim",
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "szw/vim-maximizer",
  "folke/lsp-colors.nvim",
  "tpope/vim-fugitive",
  "jghauser/mkdir.nvim",
}


local utils_with_config = {
  "windwp/nvim-autopairs",
  "m4xshen/smartcolumn.nvim",
  "simrat39/symbols-outline.nvim",
  "lewis6991/gitsigns.nvim",
  "s1n7ax/nvim-search-and-replace",
  "beauwilliams/focus.nvim",
  'simrat39/symbols-outline.nvim',
  'dnlhc/glance.nvim'
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
    "ThePrimeagen/harpoon",
    config = function ()
      require("harpoon").setup({
          menu = {
              width = vim.api.nvim_win_get_width(0) - 50,
              height = vim.api.nvim_win_get_height(0) - 10
          }
      })
    end
    }, {
        'm-demare/hlargs.nvim',
        dependencies={ 'nvim-treesitter/nvim-treesitter' },
        config = function ()
          require('hlargs').setup()
        end
    }, {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
          "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config=true
  }
}

for _, plug in pairs(utils_with_more_params) do
  table.insert(M, plug)
end

return M
