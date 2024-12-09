local result = {}
local colours = {}
colours.rosewater = "#f4dbd6"
colours.flamingo = "#f0c6c6"
colours.pink = "#f5bde6"
colours.mauve = "#c6a0f6"
colours.red = "#ed8796"
colours.maroon = "#ee99a0"
colours.peach = "#f5a97f"
colours.yellow = "#eed49f"
colours.green = "#a6da95"
colours.teal = "#8bd5ca"
colours.sky = "#91d7e3"
colours.sapphire = "#7dc4e4"
colours.blue = "#8aadf4"
colours.lavender = "#b7bdf8"
colours.text = "#cad3f5"
colours.subtext1 = "#b8c0e0"
colours.subtext0 = "#a5adcb"
colours.overlay2 = "#939ab7"
colours.overlay1 = "#8987a2"
colours.overlay0 = "#6e738d"
colours.surface2 = "#5b6078"
colours.surface1 = "#494d64"
colours.surface0 = "#363a4f"
colours.base = "#24273a"
colours.mantle = "#1e2030"
colours.crust = "#181926"

result.colours = colours;

local function hydrate_theme(theme)
  theme.background = colours.crust
  theme.background_alt = colours.base
  theme.background_urgent = colours.mantle
  theme.background_urgent1 = colours.mantle
  theme.foreground = colours.text
  theme.green = colours.green
  theme.yellow = colours.yellow
  theme.blue = colours.blue
  theme.red = colours.pink
  theme.orange = colours.peach
  theme.violet = colours.mauve
  theme.accent = theme.red
  theme.wall = ""
  return theme
end

result.hydrate_theme = hydrate_theme;

return result;
