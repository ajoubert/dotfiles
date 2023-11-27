local themes = require("ui/themes")
-- >> Elements - Desktop components
-- Statusbar(s)
require("elemental.bar."..themes.bar_theme)
-- Exit screen
require("elemental.exit_screen."..themes.exit_screen_theme)
-- Sidebar
require("elemental.sidebar."..themes.sidebar_theme)
-- Dashboard (previously called: Start screen)
require("elemental.dashboard."..themes.dashboard_theme)
-- Lock screen
-- Make sure to install lua-pam as described in the README or configure your
-- custom password in the 'user' section above
local lock_screen = require("elemental.lock_screen")
lock_screen.init()
-- App drawer
require("elemental.app_drawer")
-- Window switcher
require("elemental.window_switcher")
