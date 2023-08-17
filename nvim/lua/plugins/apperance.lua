local leader = require("utils.map").leader

return {
  "Theprimeagen/vim-be-good",

  { "yamatsum/nvim-cursorline", config = true },

  {
  'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
          show_current_context = true,
          show_current_context_start = true,
      }
    end,
  },

  {
     "m4xshen/hardtime.nvim",
     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
     config = function()
      require("hardtime").setup()
      leader('p', '<cmd>Hardtime toggle<CR>', 'hardtime toggle')
     end
  },

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

  -- theme
  {
    "Shatur/neovim-ayu",
    config = function ()
      require('ayu').setup({
        overrides = {
          -- NonText = { fg = '#CBCCCA' },
        }
      })
      vim.cmd("colorscheme ayu")
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
    'f-person/git-blame.nvim'
    },
    config = function ()
      local navic = require("nvim-navic")
      vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_date_format = '%d:%M %Y'
      local git_blame = require('gitblame')

      local custom_ayu = require'lualine.themes.ayu'
      custom_ayu.normal.c.bg = '#0000000'

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = custom_ayu,
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_a = { { 'buffers' }
          },
          lualine_b = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
          lualine_c = { { function() return navic.get_location() end, cond = function() return navic.is_available() end },
          }
        },
        tabline = {
          lualine_a = { {function() return require("utils.utils").get_project_name(vim.fn.getcwd()) end} },
          lualine_b = { 'branch' },
          lualine_y = { {'filename', path = 1} },
          lualine_z = { 'searchcount' },
        }
      })
    end
  }
}
