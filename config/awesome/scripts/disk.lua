local awful = require("awful")

local update_interval = 600
local disk_script = [[
  sh -c "df -h /home | grep '^/' | awk '{print \$5}' | tr -d '%'"
]]

awful.widget.watch(disk_script, update_interval, function(_, stdout)
	local value =  string.gsub(stdout, '^%s*(.-)%s*$', '%1')
	awesome.emit_signal("disk::value", value)
end)

local function update_disk_usage()
	awful.spawn.easy_async_with_shell(disk_script, function(stdout)
    local value =  string.gsub(stdout, '^%s*(.-)%s*$', '%1')
    awesome.emit_signal("disk::value", value)
	end)
end

awesome.connect_signal("widgets::load_all_data", function()
  update_disk_usage()
end)

