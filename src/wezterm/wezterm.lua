local wezterm = require 'wezterm';

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'
  window:set_right_status(wezterm.format {
    { Text = date .. '  ' },
  })
end)

return {
  font = wezterm.font("HackGen Console NF"),
  font_size = 16.0,

  color_scheme = "Monokai Remastered",
  use_ime = true,
  adjust_window_size_when_changing_font_size = false,

  keys = {
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
  },
}
