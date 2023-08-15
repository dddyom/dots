return {
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
