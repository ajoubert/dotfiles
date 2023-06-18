local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

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

local search_icon = wibox.widget {
    font = "SF Mono Powerline 11",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox()
}

local reset_search_icon = function ()
    search_icon.markup = helpers.colorize_text("󰍉", X.color3)
end
reset_search_icon()

local search_text = wibox.widget {
    markup = helpers.colorize_text("Search", X.color8),
    align = "center",
    valign = "center",
    font = "SF Mono Powerline 9",
    widget = wibox.widget.textbox()
}

local search_bar = wibox.widget {
    shape = gears.shape.rounded_bar,
    bg = X.color0,
    widget = wibox.container.background()
}

local search = wibox.widget{
    -- search_bar,
    {
        {
            search_icon,
            {
                search_text,
                bottom = Dpi(2),
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = Dpi(15),
        widget = wibox.container.margin
    },
    forced_height = Dpi(35),
    forced_width = Dpi(200),
    shape = gears.shape.rounded_bar,
    bg = X.color0,
    widget = wibox.container.background()
    -- layout = wibox.layout.stack
}

local function generate_prompt_icon(icon, color)
    -- return "<span font='icomoon 10' foreground='" .. color .."'>" .. icon .. "</span> "
    return "<span foreground='" .. color .."'>" .. icon .. "</span> "
end

function sidebar_activate_prompt(action)
    Sidebar_show()
    search_icon.visible = false
    local prompt
    if action == "run" then
        prompt = generate_prompt_icon("", X.color2)
    elseif action == "web_search" then
        prompt = generate_prompt_icon("", X.color4)
    end
    helpers.prompt(action, search_text, prompt, function()
        search_icon.visible = true
        if mouse.current_wibox ~= sidebar then
            sidebar.visible = false
        end
    end)
end

local prompt_is_active = function ()
    -- The search icon is hidden and replaced by other icons
    -- when the prompt is running
    return not search_icon.visible
end

search:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        sidebar_activate_prompt("run")
    end),
    awful.button({ }, 3, function ()
        sidebar_activate_prompt("web_search")
    end)
))

-- Create tooltip widget
-- It should change depending on what the user is hovering over
local adaptive_tooltip = wibox.widget {
    visible = false,
    top_only = true,
    layout = wibox.layout.stack
}

-- Create tooltip for widget w
local tooltip_counter = 0
local create_tooltip = function(w)
    local tooltip = wibox.widget {
        font = "SF Mono Powerline 10",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    tooltip_counter = tooltip_counter + 1
    local index = tooltip_counter

    adaptive_tooltip:insert(index, tooltip)

    w:connect_signal("mouse::enter", function()
        -- Raise tooltip to the top of the stack
        adaptive_tooltip:set(1, tooltip)
        adaptive_tooltip.visible = true
    end)
    w:connect_signal("mouse::leave", function ()
        adaptive_tooltip.visible = false
    end)

    return tooltip
end


-- Create the sidebar
sidebar = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
sidebar.bg = "#00000000" -- For anti aliasing
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = screen.primary.geometry.height
sidebar.width = beautiful.sidebar_width or Dpi(300)
sidebar.y = beautiful.sidebar_y or 0
--local radius = beautiful.sidebar_border_radius or 0
local radius = 0
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
    --awful.placement.maximize_vertically(sidebar, { honor_workarea = true, margins = { top = beautiful.useless_gap * 2 } })
    awful.placement.maximize_vertically(sidebar, { honor_workarea = false })
    sidebar.visible = true
end

Sidebar_hide = function()
    -- Do not hide it if prompt is active
    if not prompt_is_active() then
        sidebar.visible = false
    end
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
-- Activate sidebar by moving the mouse at the edge of the screen
if User.sidebar.show_on_mouse_screen_edge then
    local sidebar_activator = wibox({y = sidebar.y, width = 1, visible = true, ontop = false, opacity = 0, below = true, screen = screen.primary})
    sidebar_activator.height = sidebar.height
    sidebar_activator:connect_signal("mouse::enter", function ()
        sidebar.visible = true
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


-- Item placement
sidebar:setup {
    {
        { ----------- TOP GROUP -----------
            {
                helpers.vertical_pad(Dpi(30)),
                {
                    nil,
                    {
                        time,
                        spacing = Dpi(12),
                        layout = wibox.layout.fixed.horizontal
                    },
                    expand = "none",
                    layout = wibox.layout.align.horizontal
                },
                helpers.vertical_pad(Dpi(20)),
                day_of_the_week,
                helpers.vertical_pad(Dpi(30)),
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.vertical
        },
        { ----------- BOTTOM GROUP -----------
            {
                {
                    {
                        nil,
                        adaptive_tooltip,
                        expand = "none",
                        layout = wibox.layout.align.horizontal,
                    },
                    helpers.vertical_pad(Dpi(30)),
                    {
                        nil,
                        search,
                        expand = "none",
                        layout = wibox.layout.align.horizontal,
                    },
                    layout = wibox.layout.fixed.vertical
                },
                left = Dpi(20),
                right = Dpi(20),
                bottom = Dpi(30),
                widget = wibox.container.margin
            },
            bg = X.color0.."66",
            widget = wibox.container.background
        },
        layout = wibox.layout.align.vertical,
    },
    --shape = helpers.prrect(beautiful.sidebar_border_radius, false, true, false, false),
    shape = helpers.prrect(0, false, true, false, false),
    bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111",
    widget = wibox.container.background
}
