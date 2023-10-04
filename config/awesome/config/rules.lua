local awful = require('awful')
local beautiful = require('beautiful')
local keys = require('config/keys')
local decorations = require('decorations')
local t = require('config/tags');

-- Screen dimension, used for sizing rules
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Rules
-- ===================================================================
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            maximized = false,
            titlebars_enabled = beautiful.titlebars_enabled,
            maximized_horizontal = false,
            maximized_vertical = false,
        }
    },

    -- Floating clients
    {
        rule_any = {
            instance = {
                "Devtools", -- Firefox devtools
            },
            role = {
                "pop-up",
                "GtkFileChooserDialog",
                "conversation",
            },
            type = { "dialog" }
        },
        properties = { floating = true }
    },

    -- Titlebars OFF (explicitly)
    {
        rule_any = {
            instance = {
                "Alacritty",
                "discord",
                "obsidian",
                "qjackctl",
            },
            class = {
                "Blueman-manager",
                "Chromium",
                "Evolution",
                "firefox",
                "looking-glass-client",
                "Signal",
            },
            type = {
              "splash"
            },
        },
        callback = function(c)
            decorations.hide(c)
        end
    },

    -- File chooser dialog
    {
        rule_any = { role = { "GtkFileChooserDialog" } },
        properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.65 }
    },

    -- Pavucontrol & qjackctl
    {
        rule_any = { class = { "Pavucontrol", "qjackctl" } },
        properties = {
            floating = true,
            width = screen_width * 0.45,
            height = screen_height * 0.8,
        },
        callback = function(c)
            awful.placement.centered(c, {honor_padding = true, honor_workarea=true})
        end
    },

    -- File managers
    {
        rule_any = {
            class = {
                "Nemo",
                -- "Thunar"
            },
        },
        except_any = { type = { "dialog" } },
        properties = { floating = true, width = screen_width * 0.65, height = screen_height * 0.55},
        callback = function (c)
            decorations.hide(c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    -- Keepass
    {
        rule_any = { class = { "KeePassXC" } },
        except_any = { name = { "KeePassXC-Browser Confirm Access" }, type = { "dialog" } },
        properties = { floating = true, width = screen_width * 0.7, height = screen_height * 0.75},
        callback = function (c)
            decorations.hide(c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    ---------------------------------------------
    -- Start application on specific workspace --
    ---------------------------------------------
    -- Terminal
    {
        rule_any = {
            class = {
                "Alacritty",
            },
        },
        properties = { screen = 1, tag = t.tags[1] },
    },

    -- Browsing
    {
        rule_any = {
            class = {
                "firefox",
                "firefoxdeveloperedition",
                "Chromium",
                "Chromium-browser",
            },
        },
        except_any = {
            role = { "GtkFileChooserDialog" },
            instance = { "Toolkit" },
            type = { "dialog" }
        },
        properties = { screen = 1, tag = t.tags[2] },
    },

    -- Obsidian
    {
        rule_any = {
            class = { "obsidian" },
        },
        properties = { screen = 1, tag = t.tags[9] },
    },

    -- Chatting
    {
        rule_any = {
            class = {
                "discord",
                "Signal",
            },
        },
        properties = { screen = 1, tag = t.tags[4] }
    },

    -- looking glass
    {
        rule_any = {
            class = {
                "looking-glass-client",
            },
        },
        properties = { screen = 1, tag = t.tags[8], fullscreen = true }
    },

    -- Miscellaneous
    -- All clients that I want out of my way when they are running
    {
        rule_any = {
            class = {
                "KeePassXC"
            },
            instance = {
                "qemu",
            }
        },
        except_any = {
            type = { "dialog" }
        },
        properties = { screen = 1, tag = t.tags[10] }
    },
}
