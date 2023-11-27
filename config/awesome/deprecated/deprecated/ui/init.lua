local beautiful = require("beautiful")
local themes = require("ui/themes")
local icons = require("icons")
local theme_dir = os.getenv("HOME") .. "/.config/awesome/ui/themes/" .. themes.theme .. "/"
local notifications = require("notifications")
local decorations = require("decorations") -- Window decoration theme and other custom decorations
beautiful.init(theme_dir .. "theme.lua")
icons.init(themes.icon_theme)
notifications.init(themes.notification_theme)
decorations.init(themes.decoration_theme)
