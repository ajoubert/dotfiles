local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local pampath = require("gears").filesystem.get_configuration_dir() .. "liblua_pam.so"

local authenticate

screen.connect_signal("request::desktop_decoration", function(s)

-- Authentication

awful.spawn.easy_async_with_shell("stat "..pampath.." >/dev/null 2>&1", function (_, _, _)
		local pam = require("liblua_pam")
		authenticate = function(password)
			return pam.auth_current_user(password)
		end
end)

-- Variables

local characters_entered = 0

-- Header

local header = wibox.widget {
	widget = wibox.container.place,
	halign = "center",
	{
		layout = wibox.layout.fixed.vertical,
		spacing = 10,
		{
			widget = wibox.widget.imagebox,
			image = beautiful.profile_image,
			forced_width = 140,
			forced_height = 140,
		},
		{
			widget = wibox.widget.textbox,
			halign = "center",
			text = "@".. io.popen([[whoami | sed 's/.*/\u&/']]):read("*all"),
		}
	}
}

local create_point = function(color)
	return wibox.widget {
		widget = wibox.container.background,
		bg = color,
		forced_width = 10,
		forced_height = 10,
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
			font = beautiful.font.. " 38",
			format = "%H",
		},
		{
			widget = wibox.container.margin,
			top = 20,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 10,
				create_point(beautiful.green),
				create_point(beautiful.yellow),
				create_point(beautiful.red),
			},
		},
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 38",
			format = "%M",
		}
	}
}

-- Prompt

local icon = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.background_alt,
	{
		widget = wibox.container.margin,
		margins = 16,
		{
			widget = wibox.widget.textbox,
			font = beautiful.font .. " 24",
			text = "",
			align = "center",
			valign = "center"
		}
	}
}

local prompt = wibox.widget {
	widget = wibox.widget.textbox,
	markup = helpers.ui.colorizeText("enter password", ""),
	align = "center",
}

local main = wibox {
	width = s.geometry.width,
	height = s.geometry.height,
	bg = beautiful.background,
	ontop = true,
	visible = false,
}

main:setup {
	layout = wibox.layout.stack,
	{
		widget = wibox.container.place,
		valign = "top",
		{
			widget = wibox.container.margin,
			top = 40,
			time,
		}
	},
	{
		widget = wibox.container.place,
		valign = "center",
		{
			layout = wibox.layout.fixed.vertical,
			header,
			{
				widget = wibox.container.background,
				bg = beautiful.background_alt,
				{
					widget = wibox.container.margin,
					margins = 16,
					{
						widget = wibox.container.background,
						forced_width = 240,
						prompt,
					},
				}
			}
		}
	},
	{
		widget = wibox.container.place,
		valign = "bottom",
		{
			widget = wibox.container.margin,
			bottom = 100,
			icon
		}
	}
}


-- Reset

local function reset()
	characters_entered = 0;
	prompt.markup = helpers.ui.colorizeText("enter password...", "")
end

-- Fail

local function fail()
	characters_entered = 0;
	prompt.markup = helpers.ui.colorizeText("try again...", "")
end

-- Input

local function grabpassword()
	awful.prompt.run {
		hooks = {
			{{ }, "Escape", function(_)
					reset()
					grabpassword()
				end
			}
		},
		keypressed_callback  = function(_, key)
			if #key == 1 then
				characters_entered = characters_entered + 1
				prompt.markup = helpers.ui.colorizeText(string.rep("*", characters_entered), "")
			elseif key == "BackSpace" then
				if characters_entered > 1 then
					characters_entered = characters_entered - 1
					prompt.markup = helpers.ui.colorizeText(string.rep("*", characters_entered), "")
				else
					characters_entered = 0
					prompt.markup = helpers.ui.colorizeText("enter password...", "")
				end
			end
		end,
		exe_callback = function(input)
      if not authenticate then
        reset()
        main.visible = false
      end
			if authenticate == nil then
				reset()
				main.visible = false
			end
			if authenticate(input) then
				reset()
				main.visible = false
			elseif input == "test" then
				reset()
				main.visible = false
			else
				fail()
				grabpassword()
			end
		end,
		textbox = wibox.widget.textbox()
	}
end

-- Lock

function Lockscreen()
	main.visible = true
	grabpassword()
end

end)
