local result = {}
local colours = {}
colours.bg = "#282828"
colours.red = "#cc241d"
colours.green= "#98971a"
colours.yellow = "#d79921"
colours.blue = "#458588"
colours.purple = "#b16286"
colours.aqua = "#689d6a"
colours.gray = "#a89984"
colours.gray2 = "#928374"
colours.red2 = "#fb4934"
colours.green2 = "#b8bb26"
colours.yellow2 = "#fabd2f"
colours.blue2 = "#83a598"
colours.purple2 = "#d3869b"
colours.aqua2 = "#8ec07c"
colours.fg = "#ebdbb2"
colours.bg0_h = "#1d2021"
colours.bg0 = "#282828"
colours.bg1 = "#3c3836"
colours.bg2 = "#504945"
colours.bg3 = "#665c54"
colours.bg4 = "#7c6f64"
colours.gray2 = "#928374"
colours.orange = "#d65d0e"
colours.bg0_s = "#32302f"
colours.fg4 = "#a89984"
colours.fg3 = "#bdae93"
colours.fg2 = "#d5c4a1"
colours.fg1 = "#ebdbb2"
colours.fg0 = "#fbf1c7"
colours.orange2 = "#fe8019"

result.colours = colours;

local function hydrate_theme(theme)
  theme.background = colours.bg
  theme.background_alt = colours.bg0_s
  theme.background_urgent = colours.bg0_h
  theme.background_urgent1 = colours.bg0_h
  theme.foreground = colours.fg
  theme.green = colours.green
  theme.yellow = colours.yellow
  theme.blue = colours.blue
  theme.red = colours.red
  theme.orange = colours.orange
  theme.violet = colours.purple
  theme.accent = theme.orange
  theme.wall = ""
  return theme
end

result.hydrate_theme = hydrate_theme;

return result;
