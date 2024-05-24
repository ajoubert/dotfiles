local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vars = require("ui.vars")
require("scripts.init")

screen.connect_signal("request::desktop_decoration", function(s)

-- arccharts --

local create_arcchart_widget = function(widget, signal, bg, fg, thickness, text, icon)

  widget = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.background_alt,
    forced_width = 154,
    forced_height = 180,
    {
      widget = wibox.container.margin,
      margins = 10,
      {
        layout = wibox.layout.fixed.vertical,
        spacing = 10,
        {
          layout = wibox.layout.stack,
          {
            widget = wibox.container.arcchart,
            id = "progressbar",
            max_value = 100,
            min_value = 0,
            thickness = thickness,
            bg = bg,
            colors = {fg}
          },
          {
            widget = wibox.widget.textbox,
            id = "icon",
            font = beautiful.font .." 20",
            text = icon,
            halign = "center",
            valign = "center",
          },
        },
        {
          layout = wibox.layout.flex.horizontal,
          {
            widget = wibox.widget.textbox,
            text = text
          },
          {
            widget = wibox.container.place,
            halign = "right",
            {
              widget = wibox.widget.textbox,
              id = "text"
            }
          }
        }
      }
    }
  }

  awesome.connect_signal(signal, function (value)
    widget:get_children_by_id("progressbar")[1].value = value
    widget:get_children_by_id("text")[1].text = value.. "%"
  end)

  return widget
end

local cpu;
local ram;
local disk;

local resourses = wibox.widget {
	layout = wibox.layout.fixed.horizontal,
	spacing = 10,
	create_arcchart_widget(cpu, "signal::cpu", beautiful.background_urgent, beautiful.red, 15, "CPU:", ""),
	create_arcchart_widget(ram, "signal::ram", beautiful.background_urgent, beautiful.yellow, 15, "RAM:", ""),
	create_arcchart_widget(disk, "disk::value", beautiful.background_urgent, beautiful.blue, 15, "DISK:", ""),
}

-- progressbars --
local create_progressbar_widget = function(color, width, icon)
  return wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.background_alt,
    forced_height = 20,
    {
      layout = wibox.layout.fixed.horizontal,
      fill_space = true,
      spacing = 10,
      {
        widget = wibox.widget.textbox,
        id = "icon",
        text = icon,
        font = beautiful.font .. " 13",
        halign = "center",
      },
      {
        widget = wibox.container.background,
        forced_width = 36,
        {
          widget = wibox.widget.textbox,
          id = "text",
          halign = "center",
        }
      },
      {
        widget = wibox.widget.progressbar,
        id = "progressbar",
        max_value = 100,
        forced_width = width,
        background_color = beautiful.background_urgent,
        color = color,
      }
    }
  }
end


local volume = create_progressbar_widget(beautiful.orange, 370, "")

volume:buttons  {
	awful.button({}, 1, function()
		awful.spawn.with_shell("amixer sset Master toggle")
		UpdateVolumeSignals()
	end),
	awful.button({}, 4, function()
		os.execute("amixer sset Master 2%+")
		UpdateVolumeSignals()
	end),
	awful.button({}, 5, function()
		os.execute("amixer sset Master 2%-")
		UpdateVolumeSignals()
	end),
}

awesome.connect_signal("volume::value", function(value, icon)
	volume:get_children_by_id("progressbar")[1].value = value
	volume:get_children_by_id("text")[1].text = value
	volume:get_children_by_id("icon")[1].text = icon
end)

local bright = create_progressbar_widget(beautiful.violet, 370, "")

bright:buttons  {
	awful.button({}, 4, function()
		awful.spawn.with_shell("brightnessctl s 5%+")
		Update_value_of_bright()
	end),
	awful.button({}, 5, function()
		awful.spawn.with_shell("brightnessctl s 5%-")
  		Update_value_of_bright()
	end),
}

awesome.connect_signal("bright::value", function(value)
	bright:get_children_by_id("progressbar")[1].value = value
	bright:get_children_by_id("text")[1].text = value
end)

local info = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
	forced_height = 80,
	{
		widget = wibox.container.margin,
		margins = 10,
		{
			layout = wibox.layout.fixed.vertical,
			spacing = 20,
			volume,
			bright,
		}
	}
}

-- profile --

local create_fetch_comp = function(icon, text)
	return wibox.widget {
		layout = wibox.layout.flex.horizontal,
		{
			widget = wibox.widget.textbox,
			text = icon,
		},
		{
			widget = wibox.widget.textbox,
			text = text,
			halign = "right"
		}
	}
end

local fetch = wibox.widget {
	layout = wibox.layout.flex.vertical,
	forced_width = 322,
	spacing = 10,
	create_fetch_comp("", io.popen([[distro | grep "Name:" | awk '{sub(/^Name: /, ""); print}' | awk '{print $1 " " $2}']]):read("*all")),
	create_fetch_comp("", io.popen([[uname -r]]):read("*all")),
	create_fetch_comp("", io.popen([[xbps-query -l | wc -l]]):read("*all")),
	create_fetch_comp("", "Awesome WM"),
}

local profile_image = wibox.widget {
	widget = wibox.widget.imagebox,
	forced_width = 90,
	forced_height = 90,
	image = beautiful.profile_image,
}

local profile_name = wibox.widget {
	widget = wibox.widget.textbox,
	text = "@".. io.popen([[whoami | sed 's/.*/\u&/']]):read("*all")
}

local line = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.green,
	forced_width = beautiful.border_width * 3,
}

local profile = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
	forced_height = 140,
	{
		widget = wibox.container.margin,
		margins = 10,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 20,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 10,
				profile_image,
				profile_name,
			},
			fetch,
			line,
		}
	},
}

local create_point = function(color)
	return wibox.widget {
		widget = wibox.container.background,
		bg = color,
		forced_width = 8,
		forced_height = 8,
	}
end

local time = wibox.widget {
	widget = wibox.container.place,
	halign = "center",
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = 20,
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 30",
			format = "%H",
		},
		{
			widget = wibox.container.margin,
			top = 15,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 8,
				create_point(beautiful.green),
				create_point(beautiful.yellow),
				create_point(beautiful.red),
			},
		},
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 30",
			format = "%M",
		}
	}
}

-- toggles --

local create_toggle_widget = function(bg, fg, icon, name, value, arroy_visible)
	return wibox.widget {
	widget = wibox.container.background,
	forced_width = 236,
	forced_height = 80,
	bg = beautiful.background_alt,
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = 20,
		{
			widget = wibox.container.margin,
			left = 10,
			{
				widget = wibox.container.place,
				align = "center",
				{
					widget = wibox.container.background,
					id = "icon_container",
					bg = bg,
					fg = fg,
					{
						widget = wibox.container.margin,
						margins = 10,
						{
							widget = wibox.widget.textbox,
							id = "icon",
							text = icon,
							font = beautiful.font.. " 20",
							halign = "center"
						}
					}
				}
			}
		},
		{
			widget = wibox.container.place,
			halign = "center",
			{
				layout = wibox.layout.fixed.vertical,
				{
					widget = wibox.widget.textbox,
					text = name
				},
				{
					widget = wibox.widget.textbox,
					id = "value",
					text = value
				},
			}
		},
		{
			widget = wibox.widget.textbox,
			text = "",
			forced_width = 80,
			halign = "right",
			font = beautiful.font .. " 24",
			visible = arroy_visible,
			buttons = {
				awful.button({ }, 1, function() awesome.emit_signal("summon::wifi_popup") end),
			}
		}
	}
}
end

local toggle_change = function(x, widget)
	if x == "off" then
		widget:get_children_by_id("value")[1].text = "Off"
		widget:get_children_by_id("icon_container")[1]:set_bg(beautiful.background_urgent)
		widget:get_children_by_id("icon_container")[1]:set_fg(beautiful.foreground)
	else
		widget:get_children_by_id("value")[1].text = "On"
		widget:get_children_by_id("icon_container")[1]:set_bg(beautiful.accent)
		widget:get_children_by_id("icon_container")[1]:set_fg(beautiful.background)
	end
end

local wifi = create_toggle_widget(beautiful.accent, beautiful.background, "", "Wifi", "On", true)

awesome.connect_signal("wifi::value", function(value)
	if value == "disabled" then
		toggle_change("off", wifi)
	else
		toggle_change("on", wifi)
	end
end)

local function wifi_button()
	awesome.connect_signal("wifi::value", function(value)
		if value == "disabled" then
			toggle_change("on", wifi)
			awful.spawn.with_shell("nmcli radio wifi on")
		else
			toggle_change("off", wifi)
			awful.spawn.with_shell("nmcli radio wifi off")
		end
	end)
end

wifi:get_children_by_id("icon_container")[1]:buttons {
	awful.button({}, 1, function()
		wifi_button()
		Update_value_of_wifi()
	end)
}

local micro = create_toggle_widget(beautiful.accent, beautiful.background, "", "Microphone", "On", false)

awesome.connect_signal("capture_muted::value", function(value)
	if value == "off" then
		toggle_change("off", micro)
	else
		toggle_change("on", micro)
	end
end)

micro:get_children_by_id("icon_container")[1]:buttons {
	awful.button({}, 1, function()
		awful.spawn.with_shell("amixer -D pipewire sset Capture toggle")
		UpdateVolumeSignals()
	end),
}

local float = create_toggle_widget(beautiful.accent, beautiful.background, "", "Floating", "On", false)
toggle_change("off", float)

float:get_children_by_id("icon_container")[1]:buttons {
	awful.button({}, 1, function()
		vars.float_value_default = not vars.float_value_default
		local tags = awful.screen.focused().tags
		if not vars.float_value_default then
			toggle_change("off", float)
			for _, tag in ipairs(tags) do
				awful.layout.set(awful.layout.suit.tile, tag)
			end
		else
			toggle_change("on", float)
			for _, tag in ipairs(tags) do
				awful.layout.set(awful.layout.suit.floating, tag)
			end
		end
	end),
}

local opacity = create_toggle_widget(beautiful.accent, beautiful.background, "", "Opacity", "On", false)

opacity:get_children_by_id("icon_container")[1]:buttons {
	awful.button({}, 1, function()
		vars.opacity_value_default = not vars.opacity_value_default
		if not vars.opacity_value_default then
			toggle_change("off", opacity)
			awful.spawn.with_shell("$HOME/.config/awesome/other/picom/launch.sh --no-opacity")
		else
			toggle_change("on", opacity)
			awful.spawn.with_shell("$HOME/.config/awesome/other/picom/launch.sh --opacity")
		end
	end),
}


local toggles = wibox.widget {
	layout = wibox.layout.grid,
	spacing = 10,
	forced_num_cols = 2,
	wifi,
	micro,
	float,
	opacity,
}

-- main window --

local main = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background,
	{
		widget = wibox.container.margin,
		margins = 10,
		{
			layout = wibox.layout.fixed.vertical,
			spacing = 10,
			time,
			profile,
			toggles,
			info,
			resourses,
		}
	}
}

local control = awful.popup {
	screen = s,
	visible = false,
	ontop = true,
	border_width = beautiful.border_width,
	border_color = beautiful.border_color_normal,
	minimum_height = s.geometry.height,
	minimum_width = 490,
	placement = function(d)
		awful.placement.bottom_right(d,
			{
				margins = {
					top = -beautiful.border_width,
					bottom = -beautiful.border_width,
					right = -beautiful.border_width,
				}
			}
		)
	end,
	widget = main,
}

-- summon functions --

awesome.connect_signal("summon::control", function()
	control.visible = not control.visible
end)

-- hide on click --

client.connect_signal("button::press", function()
	if control.visible == true then
		awesome.emit_signal("profile::control")
	end
end)

awful.mouse.append_global_mousebinding(
	awful.button({ }, 1, function()
		if control.visible == true then
			awesome.emit_signal("profile::control")
		end
	end)
)

end)
