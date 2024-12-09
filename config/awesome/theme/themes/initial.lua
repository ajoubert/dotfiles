local result = {}

-- local colours = {}

local function hydrate_theme(theme)
  theme.background = "#191919"
  theme.background_alt = "#292929"
  theme.background_urgent = "#393939"
  theme.background_urgent1 = "#4c4c4c"
  theme.foreground = "#f0f0f0"

  theme.green = "#9ec49f"
  theme.yellow = "#c4c19e"
  theme.blue = "#a5b4cb"
  theme.red = "#c49ea0"
  theme.orange = "#ceb188"
  theme.violet = "#c49ec4"
  theme.accent = theme.red

  theme.wall = ""
  return theme
end

result.hydrate_theme = hydrate_theme

return result
