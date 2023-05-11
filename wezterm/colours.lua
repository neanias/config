local wezterm = require("wezterm")

local colours = {}

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Everforest Dark (Gogh)"
  else
    return "Everforest Light (Gogh)"
  end
end

function colours.apply_color_scheme(config)
  config.color_scheme = scheme_for_appearance(get_appearance())
end

return colours
