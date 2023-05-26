local wezterm = require("wezterm")
local colours = require("colours")

local function basename(name)
  return string.gsub(name, "(.*[/\\])(.*)", "%2")
end

local function convert_home_dir(path)
  local cwd = path
  local home = os.getenv("HOME")
  cwd = cwd:gsub("^" .. home .. "/", "~/")
  if cwd == "" then
    return path
  end
  return cwd
end

local function convert_useful_path(dir)
  local cwd = convert_home_dir(dir)
  return basename(cwd)
end

local function create_tab_title(tab, _, _, _, _, max_width)
  local user_title = tab.active_pane.user_vars.panetitle
  if user_title ~= nil and #user_title > 0 then
    return tab.tab_index + 1 .. ":" .. user_title
  end

  local title = wezterm.truncate_right(basename(tab.active_pane.foreground_process_name), max_width)
  if title == "" then
    local dir = string.gsub(tab.active_pane.title, "(.*[: ])(.*)]", "%2")
    dir = convert_useful_path(dir)
    title = wezterm.truncate_right(dir, max_width)
  end

  local copy_mode, n = string.gsub(tab.active_pane.title, "(.+) mode: .*", "%1", 1)
  if copy_mode == nil or n == 0 then
    copy_mode = ""
  else
    copy_mode = copy_mode .. ": "
  end
  return copy_mode .. tab.tab_index + 1 .. ":" .. title
end

---------------------------------------------------------------
--- wezterm on
---------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = create_tab_title(tab, tabs, panes, config, hover, max_width)
  local scheme = colours.fetch_colour_scheme()

  -- selene: allow(undefined_variable)
  local solid_left_arrow = utf8.char(0xe0ba)
  -- selene: allow(undefined_variable)
  local solid_right_arrow = utf8.char(0xe0bc)
  -- https://github.com/wez/wezterm/issues/807
  -- local edge_background = scheme.background
  -- https://github.com/wez/wezterm/blob/61f01f6ed75a04d40af9ea49aa0afe91f08cb6bd/config/src/color.rs#L245
  local edge_background = scheme.background
  local background = scheme.ansi[5]
  local foreground = scheme.ansi[8]

  if tab.is_active then
    background = scheme.brights[7]
    foreground = scheme.brights[1]
  elseif hover then
    background = scheme.cursor_bg
    foreground = scheme.cursor_fg
  end
  local edge_foreground = background

  return {
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = solid_left_arrow },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = solid_right_arrow },
    { Attribute = { Intensity = "Normal" } },
  }
end)
