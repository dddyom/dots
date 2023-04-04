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

local cur_theme = catppuccin

local colors = {
  color3   = cur_theme.black,
  color6   = cur_theme.white,
  color7   = cur_theme.skyblue,
  color8   = cur_theme.violet,
  color0   = cur_theme.bg,
  color1   = cur_theme.red,
  color2   = cur_theme.fg
}

local THEME = {
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

return THEME

