local export = {}

local themes = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "ephemeral",    -- 4 --
    "amarena",      -- 5 --
}
-- change this number to use a different theme
export.theme = themes[5]
-- ===================================================================
-- affects the window appearance: titlebar, titlebar buttons...
local decoration_themes = {
    "lovelace",       -- 1 -- standard titlebar with 3 buttons (close, max, min)
    "skyfall",        -- 2 -- no buttons, only title
    "ephemeral",      -- 3 -- text-generated titlebar buttons
}
export.decoration_theme = decoration_themes[3]
-- ===================================================================
-- statusbar themes. multiple bars can be declared in each theme.
local bar_themes = {
    "manta",        -- 1 -- taglist, client counter, date, time, layout
    "lovelace",     -- 2 -- start button, taglist, layout
    "skyfall",      -- 3 -- weather, taglist, window buttons, pop-up tray
    "ephemeral",    -- 4 -- taglist, start button, tasklist, and more buttons
    "amarena",      -- 5 -- minimal taglist and dock with autohide
    "supergravity", -- 6 -- shared taglist for multi-screen
}
export.bar_theme = bar_themes[6]

-- ===================================================================
-- affects which icon theme will be used by widgets that display image icons.
local icon_themes = {
    "linebit",        -- 1 -- neon + outline
    "drops",          -- 2 -- pastel + filled
}
export.icon_theme = icon_themes[2]
-- ===================================================================
local notification_themes = {
    "lovelace",       -- 1 -- plain with standard image icons
    "ephemeral",      -- 2 -- outlined text icons and a rainbow stripe
    "amarena",        -- 3 -- filled text icons on the right, text on the left
}
export.notification_theme = notification_themes[3]
-- ===================================================================
local sidebar_themes = {
    "lovelace",       -- 1 -- uses image icons
    "amarena",        -- 2 -- text-only (consumes less ram)
}
export.sidebar_theme = sidebar_themes[2]
-- ===================================================================
local dashboard_themes = {
    "skyfall",        -- 1 --
    "amarena",        -- 2 -- displays coronavirus stats
}
export.dashboard_theme = dashboard_themes[2]
-- ===================================================================
local exit_screen_themes = {
    "lovelace",      -- 1 -- uses image icons
    "ephemeral",     -- 2 -- uses text-generated icons (consumes less ram)
}
export.exit_screen_theme = exit_screen_themes[2]

return export;
