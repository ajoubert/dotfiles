local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local _tray = require('ui.bar.tray')
local _screen_dependant_widgets = require("ui.bar.screen_dependant_widgets")

require("scripts.init")

local widgets_per_screen = {}
local bar = nil;

local get_widgets_for_screen = function(s)
  local widgets = widgets_per_screen[s.index]
  return {
    layout = wibox.layout.flex.vertical,
    {
      widget = wibox.container.place,
      valign = "top",
      content_fill_horizontal = true,
      {
        widget = wibox.container.margin,
        margins = { left = 10, right = 10, top = 10 },
        {
          layout = wibox.layout.fixed.vertical,
          spacing = 10,
          widgets.profile,
          widgets.time,
          widgets.taglist_widget,
        }
      }
    },
    {
      widget = wibox.container.place,
      valign = "center",
      content_fill_horizontal = true,
      {
        widget = wibox.container.margin,
        margins = { left = 10, right = 10 },
        {
          layout = wibox.layout.fixed.vertical,
          widgets.tasklist_widget,
        }
      }
    },
    {
      widget = wibox.container.place,
      valign = "bottom",
      content_fill_horizontal = true,
      {
        widget = wibox.container.margin,
        margins = { right = 10, left = 10, bottom = 10 },
        {
          layout = wibox.layout.fixed.vertical,
          spacing = 10,
          _tray.tray,
          widgets.bat,
          -- keyboard,
          widgets.dnd_button,
        }
      }
    }
  }
end

local initialize_widget_bar = function(s)

  widgets_per_screen[s.index] = _screen_dependant_widgets.init(s)

  if s.index ~= 1 then
    return
  end

  _tray.init()

  -- bar --

  bar = awful.wibar {
    screen = s,
    position = "left",
    height = s.geometry.height + beautiful.border_width * 2,
    width = 56,
    bg = beautiful.background,
    opacity = 0.7,
    border_width = beautiful.border_width,
    border_color = beautiful.border_color_normal,
    margins = {
      top = -beautiful.border_width,
      bottom = -beautiful.border_width,
      left = -beautiful.border_width,
    },
    ontop = false,
    widget = get_widgets_for_screen(s)
  }
end

awesome.connect_signal("hide::bar", function()
  if bar == nil then
    return
  end
  if bar.screen ~= awful.screen.focused() then
    bar.visible = true
    bar.screen = awful.screen.focused()
    bar.widget = get_widgets_for_screen(bar.screen)
    _tray.systray.set_screen(bar.screen)
    return
  end
	bar.visible = not bar.visible
end)

screen.connect_signal("request::desktop_decoration", function(s) initialize_widget_bar(s) end)
