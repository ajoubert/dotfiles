local awful = require("awful")
local gears = require("gears")


local function update_value_of_volume()
	awful.spawn.easy_async_with_shell("amixer sget Master", function (stdout)
		local value = string.match(stdout, "(%d?%d?%d)%%")
		local muted = string.match(stdout, "%[(o%D%D?)%]")
		value = tonumber(value)
		local icon = ""
		if muted == "off" then
			icon = ""
		elseif value <= 33 then
			icon = ""
		elseif value <= 66 then
			icon = ""
		elseif value <= 100 then
			icon = ""
		end
		awesome.emit_signal("volume::value", value, icon)
	end)
end

-- local function update_value_of_capture()
-- 	awful.spawn.easy_async_with_shell("amixer sget Capture toggle | tail -n 1 | awk '{print $5}' | tr -d []%", function (stdout)
-- 		local value_as_string =  string.gsub(stdout, '^%s*(.-)%s*$', '%1')
-- 		local value = tonumber(value_as_string)
-- 		awesome.emit_signal("capture::value", value)
-- 	end)
-- end

local function update_value_of_capture_muted()
	awful.spawn.easy_async_with_shell("amixer sget Capture toggle | tail -n 1 | awk '{print $6}' | tr -d '[]'", function (stdout)
		local value =  string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		awesome.emit_signal("capture_muted::value", value)
	end)
end

function UpdateVolumeSignals()
	update_value_of_volume()
	update_value_of_capture_muted()
end

awesome.connect_signal("widgets::load_all_data", function()
  UpdateVolumeSignals()
end)

gears.timer {
	call_now = true,
	autostart = true,
	timeout = 2,
	callback = UpdateVolumeSignals,
	single_shot = true
}
