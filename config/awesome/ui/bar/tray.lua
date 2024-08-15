local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local _tray = {};
_tray.systray = nil;
_tray.tray = nil;

_tray.init = function()
  -- Global since there can only be one instance of a system tray
  _tray.systray = wibox.widget.systray

  _tray.tray= wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.background_alt,
    {
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.container.margin,
        margins = 2,
        {
          widget = wibox.widget.textbox,
          id = "button",
          text = "",
          font = beautiful.font.. " 16",
          halign = "center",
        }
      },
      {
        widget = wibox.container.place,
        halign = "center",
        {
          widget = wibox.container.margin,
          margins = { top = 4, bottom = 8 },
          id = "tray",
          visible = false,
          {
            widget = _tray.systray,
            horizontal = false,
            base_size = 24,
          }
        }
      }
    }
  }

  awesome.connect_signal("show::tray", function()
    if not _tray.tray:get_children_by_id("tray")[1].visible then
        _tray.tray:get_children_by_id("button")[1].text = ""
        _tray.tray:get_children_by_id("tray")[1].visible = true
      else
        _tray.tray:get_children_by_id("button")[1].text = ""
        _tray.tray:get_children_by_id("tray")[1].visible = false
    end
  end)

  _tray.tray:buttons{
    awful.button({}, 1, function() awesome.emit_signal("show::tray") end)
  }
end

return _tray;
