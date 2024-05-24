local awful = require("awful")

local icon = ""

function Update_value_of_bright()
	awful.spawn.easy_async_with_shell("brightnessctl i | grep Current | awk '{print $4}' | tr -d '()%'", function (stdout)
		local value_string = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		local value = tonumber(value_string)
		awesome.emit_signal("bright::value", value, icon)
	end)
end

Update_value_of_bright()
