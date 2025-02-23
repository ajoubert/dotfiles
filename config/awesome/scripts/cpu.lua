local awful = require("awful")

local update_interval = 4
local cpu_idle_script = [[
	sh -c "
	vmstat 1 2 | tail -1 | awk '{printf \"%d\", \$15}'
	"]]

awful.widget.watch(cpu_idle_script, update_interval, function(widget, stdout)
	local cpu_idle = stdout
	cpu_idle = string.gsub(cpu_idle, '^%s*(.-)%s*$', '%1')
	awesome.emit_signal("signal::cpu", 100 - tonumber(cpu_idle))
end)

local function update_cpu_usage()
	awful.spawn.easy_async_with_shell(cpu_idle_script, function(stdout)
    local cpu_idle = stdout
    cpu_idle = string.gsub(cpu_idle, '^%s*(.-)%s*$', '%1')
    awesome.emit_signal("signal::cpu", 100 - tonumber(cpu_idle))
	end)
end

awesome.connect_signal("widgets::load_all_data", function()
  update_cpu_usage()
end)

