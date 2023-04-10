local wezterm = require 'wezterm'
return {
  font = wezterm.font 'JetBrains Mono',
  hide_tab_bar_if_only_one_tab = true,
  warn_about_missing_glyphs = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  color_scheme = 'Orangish (terminal.sexy)'
}
