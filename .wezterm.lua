local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- GPU backend
local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter  = gpus[0]
config.front_end = "WebGpu"
config.animation_fps = 60

-- Decoration
config.window_decorations = "NONE"  
config.window_background_opacity = 0.7 

config.enable_tab_bar = true
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
  left   = '20px',
  right  = '20px',
  top    = '20px',
  bottom = '50px',
}


-- Custom Theme
local custom_catppuccin      = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato"]
custom_catppuccin.background = '#293643'
config.color_schemes         = { ['Custom_Catpuccin'] = custom_catppuccin }
config.color_scheme          = 'Custom_Catpuccin'

-- Font
config.font = wezterm.font_with_fallback {
  { family='D2Coding ligature', weight='Regular', scale=1.0, },
  { family='Sarasa Mono K Nerd Font', weight='Regular', },
}  
config.font_size = 15
config.cell_width = 0.9
config.line_height = 1.05


-- Muxtiplexing keymaps
local act = wezterm.action

config.leader = { mods = "CTRL", key = "b", timeout_milliseconds = 2000 }
config.keys   = {
  { mods = "LEADER", key  = "x",          action = act.CloseCurrentPane { confirm = false              } },

  { mods = "LEADER", key  = "LeftArrow",  action = act.ActivatePaneDirection "Left"  },
  { mods = "LEADER", key  = "RightArrow", action = act.ActivatePaneDirection "Right" },
  { mods = "LEADER", key  = "UpArrow",    action = act.ActivatePaneDirection "Up"    },
  { mods = "LEADER", key  = "DownArrow",  action = act.ActivatePaneDirection "Down"  },
  
  { mods = 'LEADER', key  = 'a',          action = act.ActivateKeyTable { name = 'activate_pane', one_shot = false } },
  { mods = 'LEADER', key  = 'r',          action = act.ActivateKeyTable { name = 'resize_pane'  , one_shot = false } },
  { mods = 'LEADER', key  = 'c',          action = act.ActivateKeyTable { name = 'rotate_pane'  , one_shot = false } },

  { mods = 'LEADER', key = ']',           action = act.RotatePanes "Clockwise"        },
  { mods = 'LEADER', key = '[',           action = act.RotatePanes "CounterClockwise" },
  
  { mods = 'LEADER', key = 'p',           action = act{PaneSelect={alphabet="0123456789"}}},
}

config.key_tables = {
  activate_pane = {
    { key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left'  },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow',    action = act.ActivatePaneDirection 'Up'    },
    { key = 'DownArrow',  action = act.ActivatePaneDirection 'Down'  },
    -- Cancel the mode by pressing escape
    { key = 'Escape',     action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },
    { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
    { key = 'Escape',     action = 'PopKeyTable' },
  },
  rotate_pane = {
    { key = 'RightArrow', action = act.RotatePanes "CounterClockwise" },
    { key = 'LeftArrow',  action = act.RotatePanes "Clockwise"        },
    { key = 'Escape',     action = 'PopKeyTable' },
  },
}

return config;

