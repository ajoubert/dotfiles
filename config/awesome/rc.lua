--[[
   ___       ___       ___       ___       ___       ___       ___
  /\  \     /\__\     /\  \     /\  \     /\  \     /\__\     /\  \
 /::\  \   /:/\__\   /::\  \   /::\  \   /::\  \   /::L_L_   /::\  \
/::\:\__\ /:/:/\__\ /::\:\__\ /\:\:\__\ /:/\:\__\ /:/L:\__\ /::\:\__\
\/\::/  / \::/:/  / \:\:\/  / \:\:\/__/ \:\/:/  / \/_/:/  / \:\:\/  /
  /:/  /   \::/  /   \:\/  /   \::/  /   \::/  /    /:/  /   \:\/  /
  \/__/     \/__/     \/__/     \/__/     \/__/     \/__/     \/__/

-- >> The file that binds everything together.
--]]

-- ===================================================================
-- Load AwesomeWM libraries
-- ===================================================================
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification libary
local gears = require("gears") -- Utility library
local awful = require("awful") -- UI utility library

-- ===================================================================
-- Initialization - Get configuration variables and load custom libs
-- ===================================================================
require("config/user") -- User variables and preferences
require("ui/themes/xresources") -- sets colorscheme globally

-- Error handling - added early to display anything going wrong
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)


-- ===================================================================
-- Start - Load features
-- ===================================================================

require("config/tags") -- Tags + sharedtags
require("config/keys") -- Keybinds and mousebinds
require("ui") -- Starts UI and load themes
require("elemental") -- >> init elements - desktop components
require("config/rules")
require("config/signals")
require("evil") -- >> daemons, dependency of most widgets with external infos. Needs to be initialized last

-- Autorun
--autorun = false
--awesome.connect_signal(
--    'startup',
--    function(args)
--        --awful.spawn('bash -c "~/.local/scripts/randomBgAndVideo.sh"')
--        --awful.spawn('bash -c "~/.local/scripts/backlight -b 0.9"')
--        --awful.spawn('bash -c "unclutter -idle 2')
--        --awful.spawn('bash -c "xset r rate 200 60')
--    end
--)


-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
