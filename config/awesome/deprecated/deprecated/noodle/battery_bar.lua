local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local active_color = beautiful.battery_bar_active_color or "#5AA3CC"
local background_color = beautiful.battery_bar_background_color or "#222222"

local battery_bar = wibox.widget{
  max_value     = 100,
  value         = 50,
  forced_height = Dpi(30),
    margins       = {
      top = Dpi(8),
      bottom = Dpi(8),
    },
  shape         = gears.shape.rounded_bar,
  bar_shape     = gears.shape.rounded_bar,
  color         = active_color,
  background_color = background_color,
  border_width  = 0,
  border_color  = beautiful.border_color,
  widget        = wibox.widget.progressbar,
}

awesome.connect_signal("evil::battery", function(value)
    battery_bar.value = value
end)

return battery_bar
