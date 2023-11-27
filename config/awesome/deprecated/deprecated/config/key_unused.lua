local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local apps = require("config/apps")

-- Mod keys
local superkey = "Mod4"
local ctrlkey = "Control"
local shiftkey = "Shift"

local keys = {};
-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join()
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
    -- Urgent or Undo:
    -- Jump to urgent client or (if there is no such client) go back to the last tag
    awful.key({ superkey }, "u", helpers.jump_urgent, {description = "jump to urgent client", group = "client"}),

    -- Gaps
    awful.key({ superkey, shiftkey }, "minus", helpers.increase_gaps, {description = "increment gaps size for the current tag", group = "gaps"}),
    awful.key({ superkey }, "minus", helpers.decrease_gaps, {description = "decrement gap size for the current tag", group = "gaps"}),


    awful.key({ superkey, shiftkey }, "n", helpers.restore_minimized, {description = "restore minimized", group = "client"}),

    -- Brightness
    awful.key({}, "XF86MonBrightnessDown", helpers.spawn_with_shell("backlight -d"), {description = "decrease brightness", group = "brightness"}),
    awful.key({}, "XF86MonBrightnessUp", helpers.spawn_with_shell("backlight -i"), {description = "increase brightness", group = "brightness"}),
    awful.key({ superkey }, "F11", helpers.spawn('bash -c "$HOME/.local/scripts/backlight -d"'), {description = "descrease brightness", group = "brightness"}),
    awful.key({ superkey }, "F12", helpers.spawn('bash -c "$HOME/.local/scripts/backlight -i"'), {description = "increase brightness", group = "brightness"}),

    -- Dashboard
    awful.key({ superkey }, "F1", function() dashboard_show() end, {description = "dashboard", group = "custom"}),

    -- FIXME -- Screenshots
    awful.key({}, "Print", apps.screenshot("full"), {description = "Take full screenshot", group = "screenshots"}),

    -- Toggle wibar(s)
    awful.key({ superkey }, "b", function() wibars_toggle() end, {description = "show or hide wibar(s)", group = "awesome"})
);

keys.clientkeys = gears.table.join(
    -- Relative move client
    awful.key({ superkey, shiftkey, ctrlkey }, "j", function(c) c:relative_move(0,  Dpi(20), 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "k", function(c) c:relative_move(0, Dpi(-20), 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "h", function(c) c:relative_move(Dpi(-20), 0, 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "l", function(c) c:relative_move(Dpi( 20), 0, 0, 0) end),

    -- Toggle floating
    awful.key({ superkey, ctrlkey }, "space", helpers.toggle_floating_layout, {description = "toggle floating", group = "client"}),

    -- P for pin: keep on top OR sticky
    -- On top
    awful.key({ superkey, shiftkey }, "p", function(c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
    -- Sticky
    awful.key({ superkey, ctrlkey }, "p", function(c) c.sticky = not c.sticky end, {description = "toggle sticky", group = "client"}),

    -- Minimize
    --awful.key({ superkey }, "n", function (c) c.minimized = true end, {description = "minimize", group = "client"}),

    -- Maximize
    awful.key({ superkey, ctrlkey }, "m", helpers.maximize_vertically, {description = "(un)maximize vertically", group = "client"}),
    awful.key({ superkey, shiftkey }, "m", helpers.maximize_horizontally, {description = "(un)maximize horizontally", group = "client"})
);

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    local toggleFocusedTag = {description = "toggle focused client on tag #"..i, group = "tag"};

    if(i ~= 2) then
        toggleFocusedTag = {};
    end

    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9, helpers.toggle_tag_on_client(i), toggleFocusedTag)
    )
end

root.buttons(keys.desktopbuttons)

return keys;
