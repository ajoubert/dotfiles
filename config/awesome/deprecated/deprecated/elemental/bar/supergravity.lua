local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local keys = require("config/keys")
local t = require("config/tags")

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000" }

local tag_colors_urgent = { X.foreground, X.foreground, X.foreground, X.foreground, X.foreground, X.foreground, X.foreground, X.foreground, X.foreground, X.foreground }

local tag_colors_focused = {
    X.color1,
    X.color5,
    X.color4,
    X.color6,
    X.color2,
    X.color3,
    X.color1,
    X.color5,
    X.color4,
    X.color6,
}

local tag_colors_occupied = {
    X.color1.."45",
    X.color5.."45",
    X.color4.."45",
    X.color6.."45",
    X.color2.."45",
    X.color3.."45",
    X.color1.."45",
    X.color5.."45",
    X.color4.."45",
    X.color6.."45",
}

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index, screen)
    if (tag.selected and tag.screen == screen) then
        item.bg = tag_colors_focused[index]
    elseif tag.urgent then
        item.bg = tag_colors_urgent[index]
    elseif #tag:clients() > 0 then
        item.bg = tag_colors_occupied[index]
    else
        item.bg = tag_colors_empty[index]
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Create a taglist for every screen
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        source = t.getTags,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = {
            spacing = 10,
            spacing_widget = {
                color  = '#00ff00',
                shape  = gears.shape.circle,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.flex.horizontal,
        },
        widget_template = {
            widget = wibox.container.background,
            create_callback = function(self, tag, index, _)
                update_taglist(self, tag, index, s)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index, s)
            end,
        }
    }

    -- Create the taglist wibox
    s.taglist_box = awful.wibar({
        screen = s,
        visible = false,
        ontop = false,
        type = "dock",
        position = "top",
        height = Dpi(10),
        -- position = "left",
        -- width = dpi(6),
        -- bg = "#00000000",
        bg = "#000000",
    })

    s.taglist_box:setup {
        widget = s.mytaglist,
    }
end)

TopBar_show = function()
    awful.screen.connect_for_each_screen(function(screen)
        screen.taglist_box.visible = true;
    end)
end

TopBar_hide = function()
    awful.screen.connect_for_each_screen(function(screen)
        screen.taglist_box.visible = false;
    end)
end

TopBar_toggle = function()
    if awful.screen.focused().taglist_box.visible then
        TopBar_hide()
    else
        TopBar_show();
    end
end

