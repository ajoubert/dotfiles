local awful = require('awful')
local beautiful = require('beautiful')
local sharedtags = require('third-party/sharedtags')

local t = {}
local l = awful.layout.suit -- Alias to save time :)

t.sharedtags = sharedtags;
t.tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
t.tags = t.sharedtags({
    { name = t.tagnames[0], screen=2, layout = l.tile },
    { name = t.tagnames[1], screen=1, layout = l.tile },
    { name = t.tagnames[2], layout = l.tile },
    { name = t.tagnames[3], layout = l.tile },
    { name = t.tagnames[4], layout = l.tile },
    { name = t.tagnames[5], layout = l.tile },
    { name = t.tagnames[6], layout = l.tile },
    { name = t.tagnames[7], layout = l.tile },
    { name = t.tagnames[8], layout = l.tile },
    { name = t.tagnames[9], layout = l.tile }
})

t.getTags = function()
    return t.tags;
end

return t;
