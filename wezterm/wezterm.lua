local wezterm = require('wezterm')
local onedark = wezterm.color.get_builtin_schemes()['OneDark (base16)']

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Theme
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
  -- tab_bar = {
  --   background = onedark.background,
  --   active_tab = {
  --     bg_color = onedark.background,
  --     fg_color = onedark.foreground,
  --   },
  -- },
}

-- config.window_frame = {
--   -- The font used in the tab bar.
--   -- Roboto Bold is the default; this font is bundled
--   -- with wezterm.
--   -- Whatever font is selected here, it will have the
--   -- main font setting appended to it to pick up any
--   -- fallback fonts you may have used there.
--   font = wezterm.font { family = 'Roboto', weight = 'Bold' },
--
--   -- The size of the font in the tab bar.
--   -- Default to 10. on Windows but 12.0 on other systems
--   font_size = 12.0,
--
--   -- The overall background color of the tab bar when
--   -- the window is focused
--   active_titlebar_bg = onedark.background,
--
--   -- The overall background color of the tab bar when
--   -- the window is not focused
--   inactive_titlebar_bg = '#990000',
-- }

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.tab_bar_style = {
  active_tab_left = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = SOLID_LEFT_ARROW },
  },
  active_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = SOLID_RIGHT_ARROW },
  },
  inactive_tab_left = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = SOLID_LEFT_ARROW },
  },
  inactive_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = SOLID_RIGHT_ARROW },
  },
}

-- window.colors = {
--   tab_bar = {
--     -- The color of the inactive tab bar edge/divider
--     inactive_tab_edge = '#575757',
--   },
-- }

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
