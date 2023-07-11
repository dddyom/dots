local wezterm = require 'wezterm'

wezterm.on("gui-startup", function()
  local tab, pane, window = wezterm.mux.spawn_window{}
  window:gui_window():maximize()
end)

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
  color_scheme = 'Orangish (terminal.sexy)',
  mouse_bindings = {
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action="OpenLinkAtMouseCursor",
    },
  },
}
