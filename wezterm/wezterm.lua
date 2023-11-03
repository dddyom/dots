local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return {
	font = wezterm.font("JetBrains Mono"),
	font_size = 12,
	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("JetBrains Mono", { weight = "ExtraBold", stretch = "Normal", style = "Normal" }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font("JetBrains Mono", { weight = "ExtraBold", stretch = "Normal", style = "Normal" }),
		},
	},
	hide_tab_bar_if_only_one_tab = true,
	warn_about_missing_glyphs = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	color_scheme = "Ayu Dark (Gogh)",
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
	colors = {
		cursor_bg = "#FFCC66",
		cursor_fg = "#0A0E14",
	},
}
