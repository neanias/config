local wezterm = require("wezterm")

local colours = {}

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Light"
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Everforest Dark"
  else
    return "Everforest Light"
  end
end

local function scheme_to_filename(scheme)
  return scheme:lower():gsub(" ", "_") .. ".toml"
end

function colours.fetch_colour_scheme()
  local colour_scheme = scheme_for_appearance(get_appearance())
  return wezterm.color.load_scheme(
    os.getenv("HOME") .. "/.config/wezterm/colours/" .. scheme_to_filename(colour_scheme)
  )
end

function colours.apply_color_scheme(config)
  config.color_scheme = scheme_for_appearance(get_appearance())
  config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colours/" }

  local scheme, _ = colours.fetch_colour_scheme()

  config.colors = {
    tab_bar = {
      background = scheme.background,
      new_tab = {
        bg_color = scheme.background,
        fg_color = scheme.ansi[8],
        intensity = "Bold",
      },
      new_tab_hover = {
        bg_color = scheme.ansi[1],
        fg_color = scheme.brights[8],
        intensity = "Bold",
      },
    },
  }
end

return colours
