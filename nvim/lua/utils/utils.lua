local M = {}

M.set_cmp_icons = function ()
     require "cmp".setup {
      formatting = {
        format = function (entry, vim_item)
          local icons = require("utils.icons")
          vim_item.kind = icons[vim_item.kind]
          vim_item.menu = icons[entry.source.name]
          return vim_item
        end
      }
    }
end

M.plugins = {}


M.plugins.colorizer = {
    "norcalli/nvim-colorizer.lua",
    config = function () require("colorizer").setup() end
}


M.plugins.surround = {
  "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
}

M.plugins.hlargs = {
  'm-demare/hlargs.nvim',
  dependencies={ 'nvim-treesitter/nvim-treesitter' },
  config = function () require('hlargs').setup() end

}

M.plugins.rainbow = {
  "mrjones2014/nvim-ts-rainbow",
  config=function ()
    require('nvim-treesitter.configs').setup({
      highlight = {},
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
    })
  end
}

M.plugins.trevj = {
  "AckslD/nvim-trevJ.lua",
  config = function ()
      require('trevj').setup({
        containers = {
          lua = {
            table_constructor = {final_separator = ',', final_end_line = true},
            arguments = {final_separator = false, final_end_line = true},
            parameters = {final_separator = false, final_end_line = true},
          },
        },
      })
  end
}

M.plugins.icon_picker = {
  "ziontee113/icon-picker.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
  },

  config = function()
    require("icon-picker").setup({
      disable_legacy_commands = true
    })
  end,
}

M.plugins.sniprun = {
  'michaelb/sniprun',
  build = "bash install.sh"

}

return M
