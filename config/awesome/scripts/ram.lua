local awful = require("awful")

local update_interval = 20
local ram_script = [[
	sh -c "
	free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", \$7, \$2}'
	"]]

awful.widget.watch(ram_script, update_interval, function(widget, stdout)
	local available = stdout:match('(.*)@@')
	local total = stdout:match('@@(.*)@')
	local used = tonumber(total) - tonumber(available)
	local value = math.floor((used/total)*100)
	awesome.emit_signal("signal::ram", value)
end)

local function update_ram_usage()
	awful.spawn.easy_async_with_shell(ram_script, function(stdout)
    local available = stdout:match('(.*)@@')
    local total = stdout:match('@@(.*)@')
    local used = tonumber(total) - tonumber(available)
    local value = math.floor((used/total)*100)
    awesome.emit_signal("signal::ram", value)
	end)
end

awesome.connect_signal("widgets::load_all_data", function()
  update_ram_usage()
end)
