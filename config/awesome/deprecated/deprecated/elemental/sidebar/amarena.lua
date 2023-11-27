local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local battery_bar = require("noodle.battery_bar")

local hours = wibox.widget.textclock("%H")
local minutes = wibox.widget.textclock("%M")

local make_little_dot = function (color)
    return wibox.widget{
        bg = color,
        forced_width = Dpi(10),
        forced_height = Dpi(10),
        shape = helpers.rrect(Dpi(2)),
        widget = wibox.container.background
    }
end

local time = {
    {
        font = "SF Mono Powerline 44",
        align = "right",
        valign = "top",
        widget = hours
    },
    {
        nil,
        {
            make_little_dot(X.color1),
            make_little_dot(X.color4),
            make_little_dot(X.color5),
            spacing = Dpi(10),
            widget = wibox.layout.fixed.vertical
        },
        expand = "none",
        widget = wibox.layout.align.vertical
    },
    {
        --font = "biotif extra bold 44",
        font = "SF Mono Powerline 44",
        align = "left",
        valign = "top",
        widget = minutes
    },
    spacing = Dpi(20),
    layout = wibox.layout.fixed.horizontal
}

-- Day of the week (dotw)
local dotw = require("noodle.day_of_the_week")
local day_of_the_week = wibox.widget {
    nil,
    dotw,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

-- Create the sidebar
local sidebar = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
sidebar.bg = "#00000000" -- For anti aliasing
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = screen.primary.geometry.height
sidebar.width = beautiful.sidebar_width or Dpi(300)
sidebar.y = beautiful.sidebar_y or 0
if beautiful.sidebar_position == "right" then
    awful.placement.top_right(sidebar)
else
    awful.placement.top_left(sidebar)
end

sidebar:buttons(gears.table.join(
    -- Middle click - Hide sidebar
    awful.button({ }, 2, function ()
        Sidebar_hide()
    end)
))


Sidebar_show = function()
    sidebar.screen = awful.screen.focused()
    awful.placement.maximize_vertically(sidebar, { honor_workarea = false })
    sidebar.visible = true
end

Sidebar_hide = function()
    sidebar.visible = false
end

Sidebar_toggle = function()
    if sidebar.visible then
        Sidebar_hide()
    else
        Sidebar_show();
    end
end

-- Hide sidebar when mouse leaves
if User.sidebar.hide_on_mouse_leave then
    sidebar:connect_signal("mouse::leave", function ()
        Sidebar_hide()
    end)
end

local timer_id = nil;

local function onMouseEnterScreenEdge()
    timer_id = gears.timer.start_new(0.5, Sidebar_show)
end

local function onMouseLeaveScreenEdge()
    -- Clear any existing timers
    if timer_id ~= nil then
        timer_id:stop()
        timer_id = nil
    end
end


-- Activate sidebar by moving the mouse at the edge of the screen
if User.sidebar.show_on_mouse_screen_edge then
    local sidebar_activator = wibox({y = sidebar.y, width = 1, visible = true, ontop = false, opacity = 0, below = true, screen = screen.primary})
    sidebar_activator.height = sidebar.height
    sidebar_activator:connect_signal("mouse::enter", function ()
        onMouseEnterScreenEdge();
    end)

    sidebar_activator:connect_signal("mouse::leave", function ()
        onMouseLeaveScreenEdge();
    end)


    if beautiful.sidebar_position == "right" then
        awful.placement.right(sidebar_activator)
    else
        awful.placement.left(sidebar_activator)
    end

    sidebar_activator:buttons(
        gears.table.join(
            awful.button({ }, 4, function ()
                awful.tag.viewprev()
            end),
            awful.button({ }, 5, function ()
                awful.tag.viewnext()
            end)
    ))
end

local timewidget = wibox.widget {
    nil,
    {
        time,
        spacing = Dpi(12),
        layout = wibox.layout.fixed.horizontal
    },
    expand = "none",
    layout = wibox.layout.align.horizontal
}

local timedatebox = {
    helpers.vertical_pad(Dpi(30)),
    timewidget,
    helpers.vertical_pad(Dpi(20)),
    day_of_the_week,
    helpers.vertical_pad(Dpi(30)),
    layout = wibox.layout.fixed.vertical
}

local systray = wibox.widget.systray();
systray.base_size = Dpi(25);

local systrayMargin = wibox.container.margin(systray, 10, 10, 10, 10);

local systrayCentered = wibox.container.place(systrayMargin, { halign = "center" })

local systraywidget = {
    nil,
    nil,
    systrayCentered,
    layout = wibox.layout.align.vertical,
}

local batteryFullIcon = "󱊣  ";
local batteryMediumIcon = "󱊢  ";
local batteryLowIcon = "󱊡  ";
local batteryChargingFullIcon = "󱊦  ";
local batteryChargingMediumIcon = "󱊥  ";
local batteryChargingLowIcon = "󱊤  ";
local noBattery = " ";
local currentBatteryIcon = batteryFullIcon;
local charger_plugged = true;

local textwidget = wibox.widget {
    {
        {
            markup = currentBatteryIcon,
            widget = wibox.widget.textbox,
        },
        battery_bar,
        layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.align.vertical
}

local textwidth_width = wibox.container.margin(textwidget, 50, 50, 10, 10);


-- Item placement
sidebar:setup {
    {
        timedatebox,
        textwidth_width,
        systraywidget,
        layout = wibox.layout.align.vertical,
    },
    bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111",
    widget = wibox.container.background
}
