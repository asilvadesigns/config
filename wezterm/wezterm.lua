local wezterm = require('wezterm')
local onedark = wezterm.color.get_builtin_schemes()['OneDark (base16)']

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Theme
config.color_scheme = 'OneDark (base16)'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 15
config.line_height = 1.2
config.window_decorations = 'RESIZE'

config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font('JetBrainsMono Nerd Font Mono'),
  font_size = 14.0,
}
config.colors = {
  cursor_bg = '#4d88f3',
  tab_bar = {
    background = onedark.background,
    active_tab = {
      bg_color = onedark.background,
      fg_color = onedark.foreground,
    },
  },
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- Command Pallet
config.command_palette_font_size = 15.0

-- Keys
config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'D',
    mods = 'CMD',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.Multiple({
      wezterm.action.ClearScrollback('ScrollbackAndViewport'),
      wezterm.action.SendKey({ key = 'L', mods = 'CTRL' }),
    }),
  },
  {
    key = 'K',
    mods = 'CMD',
    action = wezterm.action.PaneSelect,
  },
}

-- and finally, return the configuration to wezterm
return config
