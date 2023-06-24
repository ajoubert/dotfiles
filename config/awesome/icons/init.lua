local gears = require("gears")

local function file_exists(path)
    -- Try to open it
    local f = io.open(path)
    if f then
        f:close()
        return true
    end
    return false
end

local icons = {}
icons.image = {}
icons.text = {}

-- TODO Set up weather text icons here instead of in ../noodle/text_weather.lua
-- icons.text.weather = {}

-- Set up text symbols and accent colors to be used in tasklists or docks
-- instead of awful.widget.clienticon
-- Based on the client's `class` property
-- TODO Ability to match using rules instead of just class
icons.text.by_class = {
    -- Terminals
    ['kitty'] = { symbol = "", color = X.color5 },
    ['Alacritty'] = { symbol = "", color = X.color5 },
    ['Termite'] = { symbol = "", color = X.color5 },
    ['URxvt'] = { symbol = "", color = X.color5 },
    ['st'] = { symbol = "", color = X.color5 },
    ['st-256color'] = { symbol = "", color = X.color5 },

    -- Image viewers
    ['feh'] = { symbol = "", color = X.color1 },
    ['Sxiv'] = { symbol = "", color = X.color1 },

    -- General
    ['TelegramDesktop'] = { symbol = "", color = X.color4 },
    ['Firefox'] = { symbol = "", color = X.color3 },
    ['firefox'] = { symbol = "", color = X.color3 },
    ['firefoxdeveloperedition'] = { symbol = "", color = X.color3 },
    ['Nightly'] = { symbol = "", color = X.color4 },
    ['Chromium'] = { symbol = "", color = X.color4 },
    ['Chromium-browser'] = { symbol = "", color = X.color4 },
    ['Steam'] = { symbol = "", color = X.color2 },
    ['Lutris'] = { symbol = "", color = X.color6 },
    ['editor'] = { symbol = "", color = X.color5 },
    ['Emacs'] = { symbol = "", color = X.color2 },
    ['email'] = { symbol = "", color = X.color6 },
    ['music'] = { symbol = "", color = X.color6 },
    ['mpv'] = { symbol = "󰕧", color = X.color6 },
    ['KeePassXC'] = { symbol = "", color = X.color1 },
    ['Gucharmap'] = { symbol = "", color = X.color6 },
    ['Pavucontrol'] = { symbol = "", color = X.color4 },
    ['htop'] = { symbol = "", color = X.color2 },
    ['Screenruler'] = { symbol = "", color = X.color3 },
    ['Galculator'] = { symbol = "", color = X.color2 },
    ['Zathura'] = { symbol = "", color = X.color2 },
    ['Qemu-system-x86_64'] = { symbol = "", color = X.color3 },
    ['Wine'] = { symbol = "", color = X.color1 },
    ['markdown_input'] = { symbol = "", color = X.color2 },
    ['scratchpad'] = { symbol = "", color = X.color1 },
    ['weechat'] = { symbol = "", color = X.color5 },
    ['discord'] = { symbol = "󰙯", color = X.color5 },
    ['6cord'] = { symbol = "", color = X.color3 },
    ['obsidian'] = { symbol = "", color = X.color5 },
    ['libreoffice-writer'] = { symbol = "", color = X.color4 },
    ['libreoffice-calc'] = { symbol = "", color = X.color2 },
    ['libreoffice-impress'] = { symbol = "", color = X.color1 },
    ['Godot'] = { symbol = "", color = X.color4 },

    -- File managers
    ['Thunar'] = { symbol = "󰀶", color = X.color3 },
    ['Nemo'] = { symbol = "󰀶", color = X.color3 },
    ['files'] = { symbol = "󰀶", color = X.color3 },

    ['Gimp'] = { symbol = "", color = X.color4 },
    ['Inkscape'] = { symbol = "", color = X.color2 },
    ['Gpick'] = { symbol = "", color = X.color6 },

    -- Default
    ['_'] = { symbol = "", color = X.color7.."99" }
}

-- Available icons
local image_icon_names = {
    "playerctl_toggle",
    "playerctl_prev",
    "playerctl_next",
    "stats",
    "search",
    "volume",
    "muted",
    "firefox",
    "youtube",
    "reddit",
    "discord",
    "telegram",
    "steam",
    "games",
    "files",
    "manual",
    "keyboard",
    "appearance",
    "editor",
    "redshift",
    "gimp",
    "terminal",
    "mail",
    "music",
    "temperature",
    "battery",
    "battery_charging",
    "cpu",
    "compositor",
    "start",
    "ram",
    "screenshot",
    "home",
    "alarm",
    "alarm_off",
    "alert",
    "submenu",
    -- Weather icons
    "cloud",
    "dcloud",
    "ncloud",
    "sun",
    "star",
    "rain",
    "snow",
    "mist",
    "storm",
    "whatever",
    -- Exit screen icons
    "exit",
    "poweroff",
    "reboot",
    "suspend",
    "lock",
}

-- Path to icons
local p

-- Assumes all the icon files end in .png
-- TODO maybe automatically detect icons in icon theme directory
local function set_image_icon(icon_name)
    local i = p..icon_name..".png"
    icons.image[icon_name] = i
end

-- Set all the icon variables
function icons.init(theme_name)
    -- Set the path to image icons
    p = gears.filesystem.get_configuration_dir().."icons/"..theme_name.."/"

    for i = 1, #image_icon_names do
        set_image_icon(image_icon_names[i])
    end

    -- Set symbols and accent colors for text icons
end

return icons
