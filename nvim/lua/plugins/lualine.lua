local M = {
  "nvim-lualine/lualine.nvim"
}
  -- local gruvbox = {
  --   bg = '#282828',
  --   black = '#282828',
  --   yellow = '#d8a657',
  --   cyan = '#89b482',
  --   oceanblue = '#45707a',
  --   green = '#a9b665',
  --   orange = '#e78a4e',
  --   violet = '#d3869b',
  --   magenta = '#c14a4a',
  --   white = '#a89984',
  --   fg = '#a89984',
  --   skyblue = '#7daea3',
  --   red = '#ea6962',
  -- }
  --
  --
  -- local onedarkpro = {
  --   bg = "#282c34",
  --   black = "#282c34",
  --   yellow = "#e5c07b",
  --   cyan = "#56b6c2",
  --   oceanblue = "#61afef",
  --   green = "#98c379",
  --   orange = "#d19a66",
  --   violet = "#c678dd",
  --   magenta = "#c678dd",
  --   white = "#abb2bf",
  --   fg = "#abb2bf",
  --   skyblue = "#61afef",
  --   red = "#e06c75",
  -- }
  --
  -- local tokyonight = {
  --   bg = "#1a1b26",
  --   black = "#1a1b26",
  --   yellow = "#e0af68",
  --   cyan = "#7dcfff",
  --   oceanblue = "#7aa2f7",
  --   green = "#9ece6a",
  --   orange = "#e0af68",
  --   violet = "#bb9af7",
  --   magenta = "#bb9af7",
  --   white = "#c0caf5",
  --   fg = "#c0caf5",
  --   skyblue = "#7dcfff",
  --   red = "#f7768e",
  -- }
  --
  -- local tokyonightstorm = {
  --   bg = "#24283b",
  --   black = "#24283b",
  --   yellow = "#e0af68",
  --   cyan = "#7dcfff",
  --   oceanblue = "#7aa2f7",
  --   green = "#9ece6a",
  --   orange = "#e0af68",
  --   violet = "#bb9af7",
  --   magenta = "#bb9af7",
  --   white = "#c0caf5",
  --   fg = "#c0caf5",
  --   skyblue = "#7dcfff",
  --   red = "#f7768e",
  -- }
  --

  local catppuccin = {
    bg = '#1e1e2e',
    black = '#1e1e2e',
    yellow = '#f9e2af',
    cyan = '#94e2d5',
    oceanblue = '#89b4fa',
    green = '#a6e3a1',
    orange = '#fab387',
    violet = '#cba6f7',
    magenta = '#eba0ac',
    white = '#f5e0dc',
    fg = '#f5e0dc',
    skyblue = '#74c7ec',
    red = '#f38ba8',
  }

local colors = {
  color3   = catppuccin.black,
  color6   = catppuccin.white,
  color7   = catppuccin.skyblue,
  color8   = catppuccin.violet,
  color0   = catppuccin.bg,
  color1   = catppuccin.red,
  color2   = catppuccin.fg
}

local current_theme = {
  replace = {
    a = { fg = colors.color0, bg = colors.color1, gui = 'bold' },
    b = { fg = colors.color2, bg = colors.color3 },
  },
  inactive = {
    a = { fg = colors.color6, bg = colors.color3, gui = 'bold' },
    b = { fg = colors.color6, bg = colors.color3 },
    c = { fg = colors.color6, bg = colors.color3 },
  },
  normal = {
    a = { fg = colors.color0, bg = colors.color7, gui = 'bold' },
    b = { fg = colors.color2, bg = colors.color3 },
    c = { fg = colors.color2, bg = colors.color3 },
  },
  visual = {
    a = { fg = colors.color0, bg = colors.color8, gui = 'bold' },
    b = { fg = colors.color2, bg = colors.color3 },
  },
  insert = {
    a = { fg = colors.color0, bg = colors.color2, gui = 'bold' },
    b = { fg = colors.color2, bg = colors.color3 },
  },
}
function M.config()


    require("lualine").setup {
      options = {
      theme=current_theme,
        component_separators = "|",
      -- 	
      section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", { "diff", colored = false } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            separator = { left = "", right = "" },
            right_padding = 2,
            symbols = { alternate_file = "" },
          },
        },
      },
    }

end

return M
