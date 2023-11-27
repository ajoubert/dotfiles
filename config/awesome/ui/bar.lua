local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local vars = require("ui.vars")
require("scripts.init")
local rubato = require("modules.rubato")

screen.connect_signal("request::desktop_decoration", function(s)

-- profile --

local profile = wibox.widget {
	layout = wibox.layout.fixed.vertical,
	{
		widget = wibox.container.background,
		id = "profile",
		bg = beautiful.background_alt,
		{
			widget = wibox.container.margin,
			margins = { bottom = 8, top = 8 },
			{
				widget = wibox.widget.textbox,
				text = "",
				halign = "center"
			}
		}
	}
}

awesome.connect_signal("profile::control", function()
	vars.profile_default = not vars.profile_default
	if not vars.profile_default then
		profile:get_children_by_id("profile")[1]:set_bg(beautiful.background_alt)
		awesome.emit_signal("summon::control")
	else
		profile:get_children_by_id("profile")[1]:set_bg(beautiful.background_urgent)
		awesome.emit_signal("summon::control")
	end
end)

profile:buttons {
	awful.button({}, 1, function()
		awesome.emit_signal("profile::control")
	end)
}

-- tasklist --

local tasklist = awful.widget.tasklist {
	screen = s,
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
		forced_height = 24,
		create_callback = function(self, c, index, objects)
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

local tasklist_widget = wibox.widget {
		widget = wibox.container.margin,
		margins = 6,
		tasklist
}

-- keyboard layout --

local mykeyboard=awful.widget.keyboardlayout()
mykeyboard.widget.text = string.upper(mykeyboard.widget.text)
mykeyboard.widget:connect_signal("widget::redraw_needed",
	function(wid) wid.text = string.upper(wid.text)
end)

local keyboard = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
	{
		widget = wibox.container.margin,
		margins = {top = 6, bottom = 6},
		{
			layout = wibox.layout.fixed.vertical,
			spacing = 8,
			{
				widget = wibox.container.place,
				halign = "center",
				{
					widget = wibox.container.margin,
					margins = { left = -5, right = -5 },
					mykeyboard,
  				}
			}
		}
	}
}

-- tray --

local tray = wibox.widget {
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
					widget = wibox.widget.systray,
					horizontal = false,
					base_size = 24,
				}
			}
		}
	}
}

awesome.connect_signal("show::tray", function()
	if not tray:get_children_by_id("tray")[1].visible then
			tray:get_children_by_id("button")[1].text = ""
			tray:get_children_by_id("tray")[1].visible = true
		else
			tray:get_children_by_id("button")[1].text = ""
			tray:get_children_by_id("tray")[1].visible = false
	end
end)

tray:buttons{
	awful.button({}, 1, function() awesome.emit_signal("show::tray") end)
}

-- clock --

local time = wibox.widget {
	layout = wibox.layout.fixed.vertical,
	{
		widget = wibox.container.background,
		id = "clock",
		bg = beautiful.background_alt,
		{
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
	vars.time_default = not vars.time_default
	if not vars.time_default then
		time:get_children_by_id("clock")[1]:set_bg(beautiful.background_alt)
		awesome.emit_signal("summon::calendar_widget")
	else
		time:get_children_by_id("clock")[1]:set_bg(beautiful.background_urgent)
		awesome.emit_signal("summon::calendar_widget")
	end
end)

time:buttons {
	awful.button({}, 1, function()
		awesome.emit_signal("time::calendar")
	end)
}

-- taglist --

local taglist = awful.widget.taglist {
	screen = s,
	filter = awful.widget.taglist.filter.noempty,
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
		forced_width  = 20,
		widget = wibox.container.background,
		create_callback = function (self, tag)
			self.animate = rubato.timed {
				duration = 0.3,
				easing = rubato.easing.linear,
				subscribed = function (h)
					self:get_children_by_id("background_role")[1].forced_height = h
				end
			}
			self.update = function ()
				if tag.selected then
					self.animate.target = 28
				elseif #tag:clients() > 0 then
					self.animate.target = 18
				end
			end
			self.update()
		end,
		update_callback = function (self)
			self.update()
		end,
	},
}

local taglist_widget = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
	{
		widget = wibox.container.margin,
		margins = 12,
		taglist
	}
}
-- battery --

local bat = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
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
		}
	}
}

awesome.connect_signal("bat::value", function(value)
	bat:get_children_by_id("progressbar")[1].value = value
	if value == nil then
		return
	end
	if value > 70 then
		bat:get_children_by_id("progressbar")[1].color = beautiful.green
	elseif value > 20 then
		bat:get_children_by_id("progressbar")[1].color = beautiful.yellow
	else
		bat:get_children_by_id("progressbar")[1].color = beautiful.red
	end
end)

awesome.connect_signal("bat::state", function(value)
	if value == "Discharging" then
		bat:get_children_by_id("icon")[1].text = ""
	else
		bat:get_children_by_id("progressbar")[1].color = beautiful.green
		bat:get_children_by_id("icon")[1].image = beautiful.battery_icon
	end
end)

-- dnd --

local dnd_button = wibox.widget {
	widget = wibox.container.background,
	id = "dnd",
	bg = beautiful.background_alt,
	fg = beautiful.foregraund,
	{
		widget = wibox.container.margin,
		margins = { top = 8, bottom = 8 },
		{
			widget = wibox.widget.textbox,
			id = "icon",
			text = "",
			halign = "center",
		}
	}
}


awesome.connect_signal("signal::dnd", function()
	vars.dnd = not vars.dnd
	if not vars.dnd then
		dnd_button:get_children_by_id("icon")[1].text = ""
		naughty.suspend()
	else
		dnd_button:get_children_by_id("icon")[1].text = ""
		naughty.resume()
	end
end)

awesome.connect_signal("notif_center::open", function()
	vars.notif_center_default = not vars.notif_center_default
	if not vars.notif_center_default then
		dnd_button:get_children_by_id("dnd")[1]:set_bg(beautiful.background_alt)
		awesome.emit_signal("summon::notif_center")
	else
		dnd_button:get_children_by_id("dnd")[1]:set_bg(beautiful.background_urgent)
		awesome.emit_signal("summon::notif_center")
	end
end)

dnd_button:buttons {
	awful.button({}, 1, function()
		awesome.emit_signal("notif_center::open")
	end),
	awful.button({}, 3, function()
		awesome.emit_signal("signal::dnd")
	end),
}
-- bar --

bar = awful.wibar {
	screen = s,
	position = "left",
	height = s.geometry.height + beautiful.border_width * 2,
	width = 56,
	bg = beautiful.background,
	border_width = beautiful.border_width,
	border_color = beautiful.border_color_normal,
	margins = {
		top = -beautiful.border_width,
		bottom = -beautiful.border_width,
		left = -beautiful.border_width,
	},
	ontop = false,
	widget = {
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
					profile,
					time,
					taglist_widget,
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
					tasklist_widget,
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
					tray,
					bat,
					-- keyboard,
					dnd_button,
				}
			}
		}
	}
}

end)

awesome.connect_signal("hide::bar", function()
	bar.visible = not bar.visible
end)

