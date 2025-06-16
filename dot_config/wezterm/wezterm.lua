local wezterm = require 'wezterm';
local act = wezterm.action;

local config = wezterm.config_builder()

config.font = wezterm.font("HackGen Console NF")
config.font_size = 16.0

config.color_scheme = "Monokai Remastered"
config.colors = {
  cursor_bg = 'white',
}

config.use_ime = true

config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
}

config.window_background_opacity = 0.9

config.send_composed_key_when_left_alt_is_pressed = true

config.enable_tab_bar = false

config.keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}

return config
