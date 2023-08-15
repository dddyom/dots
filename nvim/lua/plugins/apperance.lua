local leader = require("utils.map").leader

return {
  {
    "eandrju/cellular-automaton.nvim",
    config = function() leader(']', '<cmd>CellularAutomaton make_it_rain<CR>', 'rain') end
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
      leader('a', '<cmd>SymbolsOutline<CR>', 'code structure')
    end
  },
  {
      "norcalli/nvim-colorizer.lua",
      config = function () require("colorizer").setup() end
  },
  {
    'm-demare/hlargs.nvim',
    config = function () require('hlargs').setup() end
  },
  {
    "mrjones2014/nvim-ts-rainbow",
    config=function ()
      require('nvim-treesitter.configs').setup({
        highlight = {},
        rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
      })
    end
  },
  {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
  },
  {
    "Shatur/neovim-ayu",
    config = function ()
      require('ayu').setup({
        overrides = {
          NonText = { fg = '#CBCCCA' },
        }
      })
      vim.cmd("colorscheme ayu")
    end
  }
}
