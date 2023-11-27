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
local naughty = require("naughty") -- Notification libary

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

-- Garbage collection
-- Enabled for lower memory consumption
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
