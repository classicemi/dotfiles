-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

-- font and color scheme
config.font = wezterm.font 'Menlo'
config.color_scheme = 'Gruvbox Material (Gogh)'

-- key assignment
config.keys = {}

-- and finally, return the configuration to wezterm
return config
