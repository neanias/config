local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

require("tabs").setup(config)

local colours = require("colours")
colours.apply_color_scheme(config)

wezterm.add_to_config_reload_watch_list(
  config.color_scheme_dirs[1] .. config.color_scheme:lower():gsub(" ", "_") .. ".toml"
)

config.font_size = 13.0
config.font = wezterm.font_with_fallback({
  -- Preferred
  "Hack Nerd Font",

  -- <built-in>, BuiltIn
  "JetBrains Mono",

  -- <built-in>, BuiltIn
  -- Assumed to have Emoji Presentation
  -- Pixel sizes: [128]
  "Noto Color Emoji",

  -- <built-in>, BuiltIn
  "Symbols Nerd Font Mono",
})

config.default_cursor_style = "SteadyBlock"

-- Swap composition keys so left Alt behaves normally
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.use_fancy_tab_bar = false

return config
