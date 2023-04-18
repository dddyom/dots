local M = {
  'nvim-lualine/lualine.nvim'
}


M.config = function ()
  local navic = require("nvim-navic")
  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = {
        'buffers',
      },
      lualine_c = {
                  {
                    function()
                        return navic.get_location()
                    end,
                    cond = function()
                        return navic.is_available()
                    end
                  },
              }
    }
  })
end

return M
