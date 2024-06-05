local wezterm = require 'wezterm';

local config = wezterm.config_builder()

config.font = wezterm.font("HackGen Console NF")
config.font_size = 16.0

config.color_scheme = "Monokai Remastered"
config.colors = {
  cursor_bg = 'white',
}

config.use_ime = true

config.adjust_window_size_when_changing_font_size = false

config.send_composed_key_when_left_alt_is_pressed = true

config.keys = {
  -- Screen
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  -- Close Pane
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- Select Pane
  {
    key = '[',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Prev'
  },
  {
    key = ']',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Next'
  },
  -- Split Window
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}

return config
