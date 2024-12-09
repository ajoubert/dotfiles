local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local vars = require("ui.vars")

local _screen_dependant_widgets = {}

_screen_dependant_widgets.screens = {}

_screen_dependant_widgets.init = function(s)

  local result = {}

  -- profile --

  result.profile = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    {
      widget = wibox.container.background,
      id = "profile",
      bg = beautiful.background_alt,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
      end,
      {
        widget = wibox.container.margin,
        margins = { bottom = 8, top = 8, right = 4 },
        {
          widget = wibox.widget.textbox,
          -- text = "",
          text = "󰍜",
          halign = "center"
        }
      }
    }
  }

  awesome.connect_signal("profile::control", function()
    if not vars.profile_default then
      result.profile:get_children_by_id("profile")[1]:set_bg(beautiful.background_alt)
    else
      result.profile:get_children_by_id("profile")[1]:set_bg(beautiful.background_urgent)
    end
  end)

  result.profile:buttons {
    awful.button({}, 1, function()
      vars.profile_default = not vars.profile_default
      awesome.emit_signal("profile::control")
    end)
  }

  -- tasklist --

  result.tasklist = awful.widget.tasklist {
    screen = s,
    style   = {
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 4)
        end
    },
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({ }, 1, function (c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
      awful.button({ }, 2, function (c)
        c:kill { context = "tasklist", action = "close client" }
      end),
    },
    layout = {
      spacing = 10,
      layout = wibox.layout.fixed.vertical,
    },
    widget_template = {
      id = "background_role",
      widget = wibox.container.background,
      forced_height = 36,
      create_callback = function(self, c)
        local tooltip = awful.tooltip({
          objects = { self },
          timer_function = function()
            return c.name
          end,
        })
        tooltip.mode = "outside"
        tooltip.gaps = beautiful.useless_gap
        tooltip.margins_leftright = 10
        tooltip.margins_topbottom = 10
      end
    }
  }

  result.tasklist_widget = wibox.widget {
      widget = wibox.container.margin,
      margins = 6,
      result.tasklist
  }

  -- keyboard layout --

  result.mykeyboard=awful.widget.keyboardlayout()
  result.mykeyboard.widget.text = string.upper(result.mykeyboard.widget.text)
  result.mykeyboard.widget:connect_signal("widget::redraw_needed",
    function(wid) wid.text = string.upper(wid.text)
  end)


  -- clock --

  result.time = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    {
      widget = wibox.container.background,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
      end,
      id = "clock",
      bg = beautiful.background_alt, {
        widget = wibox.container.margin,
        margins = { bottom = 6, top = 6 },
        {
          layout = wibox.layout.fixed.vertical,
          spacing = 4,
          {
            widget = wibox.widget.textclock,
            format = "%H\n%M\n%S",
            refresh = 1,
            halign = "center"
          }
        }
      }
    }
  }

  awesome.connect_signal("time::calendar", function()
    if not vars.time_default then
      result.time:get_children_by_id("clock")[1]:set_bg(beautiful.background_alt)
    else
      result.time:get_children_by_id("clock")[1]:set_bg(beautiful.background_urgent)
    end
  end)

  result.time:buttons {
    awful.button({}, 1, function()
      awesome.emit_signal("time::calendar")
      vars.time_default = not vars.time_default
    end)
  }

  -- taglist --

  result.taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    style   = {
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 4)
        end
    },
    buttons = {
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    },
    layout = {
      spacing = 10,
      layout = wibox.layout.fixed.vertical
    },
    widget_template = {
      id = "background_role",
      forced_height = 20,
      forced_width = 20,
      widget = wibox.container.background,
      create_callback = function (self, tag)
        self.update = function ()
          if tag.selected then
            self:get_children_by_id("background_role")[1].forced_height = 28
          elseif #tag:clients() > 0 then
            self:get_children_by_id("background_role")[1].forced_height = 18
          end
        end
        self.update()
      end,
      update_callback = function (self)
        self.update()
      end,
    },
  }

  result.taglist_widget = wibox.widget {
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 8)
    end,
    bg = beautiful.background_alt,
    {
      widget = wibox.container.margin,
      margins = 12,
      result.taglist
    }
  }
  -- battery --
  -- Function to get battery time left
  local function update_battery_time(widget)
      awful.spawn.easy_async_with_shell("/home/sloth/.local/scripts/power_left", function(out)
          widget:set_text(out)
      end)
  end

  result.bat = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.background_alt,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 8)
    end,
    {
      layout = wibox.layout.stack,
      {
        widget = wibox.container.rotate,
        direction = "east",
        {
          widget = wibox.widget.progressbar,
          id = "progressbar",
          max_value = 100,
          forced_width = 60,
          background_color = beautiful.background_urgent,
        }
      },
      {
        widget = wibox.container.background,
        fg = beautiful.background,
        {
          widget = wibox.widget.imagebox,
          id = "icon",
          valign = "center"
        }
      },
      {
        widget = wibox.container.place,
        {
          widget = wibox.container.margin, -- Add margin to adjust vertical position
          top = 30,
          bottom = 2,
          {
            widget = wibox.container.background,
            fg = "#000000", -- Set the font color to black
            {
              widget = wibox.widget.textbox,
              id = "time_remaining",
              align = "center",
              valign = "center",
              font = "Sans 12"
            }
          }
        }
      }
    }
  }

  -- Timer to update the battery time left every minute
  gears.timer {
      timeout = 60,
      autostart = true,
      callback = function()
          local time_remaining = result.bat:get_children_by_id("time_remaining")[1]
          update_battery_time(time_remaining)
      end
  }

  local time_remaining = result.bat:get_children_by_id("time_remaining")[1]
  update_battery_time(time_remaining)



  awesome.connect_signal("bat::value", function(value)
    result.bat:get_children_by_id("progressbar")[1].value = value
    if value == nil then
      return
    end
    if value > 70 then
      result.bat:get_children_by_id("progressbar")[1].color = beautiful.green
    elseif value > 20 then
      result.bat:get_children_by_id("progressbar")[1].color = beautiful.yellow
    else
      result.bat:get_children_by_id("progressbar")[1].color = beautiful.red
    end
  end)

  awesome.connect_signal("bat::state", function(value)
    if value == "Discharging" then
      result.bat:get_children_by_id("icon")[1].text = ""
    else
      result.bat:get_children_by_id("progressbar")[1].color = beautiful.green
      result.bat:get_children_by_id("icon")[1].image = beautiful.battery_icon
    end
  end)

  -- dnd --

  result.dnd_button = wibox.widget {
    widget = wibox.container.background,
    id = "dnd",
    bg = beautiful.background_alt,
    fg = beautiful.foregraund,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 8)
    end,
    {
      widget = wibox.container.margin,
      margins = { top = 8, bottom = 8, right = 4 },
      {
        widget = wibox.widget.textbox,
        id = "icon",
        text = "",
        halign = "center",
      }
    }
  }

  awesome.connect_signal("signal::dnd", function()
    vars.dnd = not vars.dnd
    if not vars.dnd then
      result.dnd_button:get_children_by_id("icon")[1].text = ""
      naughty.suspend()
    else
      result.dnd_button:get_children_by_id("icon")[1].text = ""
      naughty.resume()
    end
  end)

  awesome.connect_signal("notif_center::open", function()
    vars.notif_center_default = not vars.notif_center_default
    if not vars.notif_center_default then
      result.dnd_button:get_children_by_id("dnd")[1]:set_bg(beautiful.background_alt)
      awesome.emit_signal("summon::notif_center")
    else
      result.dnd_button:get_children_by_id("dnd")[1]:set_bg(beautiful.background_urgent)
      awesome.emit_signal("summon::notif_center")
    end
  end)

  result.dnd_button:buttons {
    awful.button({}, 1, function()
      awesome.emit_signal("notif_center::open")
    end),
    awful.button({}, 3, function()
      awesome.emit_signal("signal::dnd")
    end),
  }

  return result
end

return _screen_dependant_widgets
