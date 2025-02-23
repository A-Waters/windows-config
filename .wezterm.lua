-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()


config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 100 
config.term = "xterm-256color" -- Set the terminal type


config.cell_width = 0.9

config.window_background_opacity = 0.9
config.prefer_egl = true
config.font_size = 18.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- keymaps
config.keys = {
	{
    	key="H", mods="CTRL", action=wezterm.action{SplitPane={direction="Right"}},
  	},
	{
    	key="V", mods="CTRL", action=wezterm.action{SplitPane={direction="Down"}},
  	},
	{
    	key="W", mods="CTRL", action = wezterm.action { CloseCurrentPane = { confirm = false } },
	},	
	{
		key = "U",
		mods = "CTRL",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "I",
		mods = "CTRL",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "O",
		mods = "CTRL",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	{
		key = "O",
		mods = "CTRL",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.9
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

-- For example, changing the color scheme:
config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	-- background = "#181616", -- vague.nvim bg
	background = "#080808", -- almost black
	-- background = "#0c0b0f", -- dark purple
	cursor_border = "#bea3c7",
	cursor_bg = "#bea3c7",

	tab_bar = {
		background = "#0c0b0f",
		-- background = "rgba(0, 0, 0, 0%)",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#bea3c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			-- bg_color = "rgba(59, 34, 76, 50%)",
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}
config.window_decorations = "NONE | RESIZE"
config.default_prog = { "powershell.exe", "-NoLogo" }

-- and finally, return the configuration to wezterm




return config
