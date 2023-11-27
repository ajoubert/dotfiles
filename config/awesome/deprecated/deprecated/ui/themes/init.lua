local export = {}

local themes = {
    "amarena",
}
-- change this number to use a different theme
export.theme = themes[1]
-- ===================================================================
-- affects the window appearance: titlebar, titlebar buttons...
local decoration_themes = {
    "ephemeral",
}
export.decoration_theme = decoration_themes[1]
-- ===================================================================
-- statusbar themes. multiple bars can be declared in each theme.
local bar_themes = {
    "supergravity",
}
export.bar_theme = bar_themes[1]

-- ===================================================================
-- affects which icon theme will be used by widgets that display image icons.
local icon_themes = {
    "linebit",        -- 1 -- neon + outline
    "drops",          -- 2 -- pastel + filled
}
export.icon_theme = icon_themes[2]
-- ===================================================================
local notification_themes = {
    "amarena",
}
export.notification_theme = notification_themes[1]
-- ===================================================================
local sidebar_themes = {
    "amarena",        -- 2 -- text-only (consumes less ram)
}
export.sidebar_theme = sidebar_themes[1]
-- ===================================================================
local dashboard_themes = {
    "amarena",
}
export.dashboard_theme = dashboard_themes[1]
-- ===================================================================
local exit_screen_themes = {
    "ephemeral",
}
export.exit_screen_theme = exit_screen_themes[1]

return export;
