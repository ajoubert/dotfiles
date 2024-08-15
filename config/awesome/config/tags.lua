local awful = require("awful")

-- awful.layout.layouts = {
	-- awful.layout.suit.tile,
-- }

awful.layout.append_default_layouts({
    awful.layout.suit.tile,
})

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])
end)

awful.mouse.snap.edge_enabled = false
