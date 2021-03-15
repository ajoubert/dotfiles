local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require("apps")
local decorations = require("decorations")
local helpers = require("helpers")

local keys = {}

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join()
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(

    -- Focus client by direction (hjkl keys)
    awful.key({ superkey }, "j", helpers.focus_direction("down"), {description = "focus down", group = "client"}),
    awful.key({ superkey }, "k", helpers.focus_direction("up"), {description = "focus up", group = "client"}),
    awful.key({ superkey }, "h", helpers.focus_direction("left"), {description = "focus left", group = "client"}),
    awful.key({ superkey }, "l", helpers.focus_direction("right"), {description = "focus right", group = "client"}),

    -- Focus client by direction (arrow keys)
    awful.key({ superkey }, "down", helpers.focus_direction("down"), {description = "focus down", group = "client"}),
    awful.key({ superkey }, "up", helpers.focus_direction("up"), {description = "focus up", group = "client"}),
    awful.key({ superkey }, "left", helpers.focus_direction("left"), {description = "focus left", group = "client"}),
    awful.key({ superkey }, "right", helpers.focus_direction("right"), {description = "focus right", group = "client"}),

    -- Change screen focus
    awful.key({ superkey }, "[", helpers.focus_screen_by_direction("left"), {description = "Focus screen on the left", group = "client"}),
    awful.key({ superkey }, "]", helpers.focus_screen_by_direction("right"), {description = "Focus screen on the right", group = "client"}),


    -- Window switcher
    awful.key({ superkey }, "Tab", helpers.show_window_switcher, {description = "activate window switcher", group = "client"}),

    -- Gaps
    awful.key({ superkey, shiftkey }, "minus", helpers.increase_gaps, {description = "increment gaps size for the current tag", group = "gaps"}),
    awful.key({ superkey }, "minus", helpers.decrease_gaps, {description = "decrement gap size for the current tag", group = "gaps"}),

    -- Urgent or Undo:
    -- Jump to urgent client or (if there is no such client) go back to the last tag
    awful.key({ superkey }, "u", helpers.jump_urgent, {description = "jump to urgent client", group = "client"}),

    -- Spawn terminal
    awful.key({ superkey }, "Return", helpers.spawn(user.terminal), {description = "open a terminal", group = "launcher"}),

    -- Reload Awesome
    awful.key({ superkey, shiftkey }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key({ superkey }, "Escape", helpers.show_exit_screens, {description = "quit awesome", group = "awesome"}),
    awful.key({}, "XF86PowerOff", helpers.show_exit_screens, {description = "quit awesome", group = "awesome"}),

    awful.key({ superkey, shiftkey }, "n", helpers.restore_minimized, {description = "restore minimized", group = "client"}),

    -- Run program (d for dmenu ;)
    awful.key({ superkey }, " ", helpers.show_rofi, {description = "rofi launcher", group = "launcher"}),

    -- Dismiss notifications and elements that connect to the dismiss signal
    awful.key({ ctrlkey }, "space", helpers.dismiss_all_notifs, {description = "dismiss notification", group = "notifications"}),

    -- Brightness
    awful.key({}, "XF86MonBrightnessDown", helpers.spawn_with_shell("backlight -d"), {description = "decrease brightness", group = "brightness"}),
    awful.key({}, "XF86MonBrightnessUp", helpers.spawn_with_shell("backlight -i"), {description = "increase brightness", group = "brightness"}),
    awful.key({ superkey }, "F11", helpers.spawn('bash -c "$HOME/.local/scripts/backlight -d"'), {description = "descrease brightness", group = "brightness"}),
    awful.key({ superkey }, "F12", helpers.spawn('bash -c "$HOME/.local/scripts/backlight -i"'), {description = "increase brightness", group = "brightness"}),

    -- Volume Control with volume keys
    awful.key({}, "XF86AudioMute", helpers.volume_control(0), {description = "(un)mute volume", group = "volume"}),
    awful.key({}, "XF86AudioLowerVolume", helpers.volume_control(-5), {description = "lower volume", group = "volume"}),
    awful.key({}, "XF86AudioRaiseVolume", helpers.volume_control(5), {description = "raise volume", group = "volume"}),

    -- Control virtual machine 
    awful.key({ superkey, shiftkey }, "d", helpers.spawn("/home/sloth/.VFIOinput/input_attach.sh"), {description = "attach input to vm", group = "volume"}),

    -- FIXME -- Screenshots
    awful.key({}, "Print", apps.screenshot("full"), {description = "Take full screenshot", group = "screenshots"}),

    -- Toggle tray visibility
    awful.key({ superkey }, "=", function() tray_toggle() end, {description = "toggle tray visibility", group = "awesome"}),


    -- LAYOUTS

    -- Tiling
    -- Single tap: Set tiled layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ superkey }, "s", helpers.set_tiled_layout, {description = "set tiled layout", group = "tag"}),

    -- Set floating layout
    awful.key({ superkey, shiftkey }, "s", helpers.set_floating_layout, {description = "set floating layout", group = "tag"}),

    -- Dashboard
    awful.key({ superkey }, "F1", function() dashboard_show() end, {description = "dashboard", group = "custom"}),

    -- Toggle sidebar
    awful.key({ superkey }, "grave", function() sidebar_toggle() end, {description = "show or hide sidebar", group = "awesome"}),

    -- Toggle wibar(s)
    awful.key({ superkey }, "b", function() wibars_toggle() end, {description = "show or hide wibar(s)", group = "awesome"}),

    awful.key({ superkey }, "p", helpers.spawn("rofi-pass"), {description = "rofi pass", group = "launcher"})
)

keys.clientkeys = gears.table.join(
    -- Single tap: Center client 
    -- Double tap: Center client + Floating + Resize
    awful.key({ superkey }, "c", helpers.center_with_doubletap),

    -- Relative move client
    awful.key({ superkey, shiftkey, ctrlkey }, "j", function(c) c:relative_move(0,  dpi(20), 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "k", function(c) c:relative_move(0, dpi(-20), 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "h", function(c) c:relative_move(dpi(-20), 0, 0, 0) end),
    awful.key({ superkey, shiftkey, ctrlkey }, "l", function(c) c:relative_move(dpi( 20), 0, 0, 0) end),

    -- Toggle titlebars (for focused client only)
    awful.key({ superkey }, "t", decorations.cycle, {description = "toggle titlebar", group = "client"}),

    -- Toggle fullscreen
    awful.key({ superkey }, "f", helpers.toggle_fullscreen, {description = "toggle fullscreen", group = "client"}),

    -- Close client
    awful.key({ superkey }, "w", function(c) c:kill() end, {description = "close", group = "client"}),

    -- Toggle floating
    awful.key({ superkey, ctrlkey }, "space", helpers.toggle_floating_layout, {description = "toggle floating", group = "client"}),

    -- P for pin: keep on top OR sticky
    -- On top
    awful.key({ superkey, shiftkey }, "p", function(c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
    -- Sticky
    awful.key({ superkey, ctrlkey }, "p", function(c) c.sticky = not c.sticky end, {description = "toggle sticky", group = "client"}),

    -- Minimize
    awful.key({ superkey }, "n", function (c) c.minimized = true end, {description = "minimize", group = "client"}),

    -- Maximize
    awful.key({ superkey }, "m", function (c) c.maximized = not c.maximized end, {description = "(un)maximize", group = "client"}),
    awful.key({ superkey, ctrlkey }, "m", helpers.maximize_vertically, {description = "(un)maximize vertically", group = "client"}),
    awful.key({ superkey, shiftkey }, "m", helpers.maximize_horizontally, {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9, helpers.switch_tag(i), {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9, helpers.toggle_tag(i), {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ superkey, shiftkey }, "#" .. i + 9, helpers.move_to_tag(i), {description = "move focused client to tag #"..i, group = "tag"}),

        -- Move client to screen.
        awful.key({ superkey, shiftkey }, "[", helpers.move_to_left_screen, {description = "move to screen on left", group = "screen"}),
        awful.key({ superkey, shiftkey }, "]", helpers.move_to_right_screen, {description = "move to screen on right", group = "screen"}),

        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9, helpers.toggle_tag_on_client(i), {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
    awful.button({}, 1, function (c) client.focus = c end),
    awful.button({ superkey }, 1, awful.mouse.client.move),
    awful.button({ superkey }, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
    end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the modkey is pressed
keys.tasklist_buttons = gears.table.join(
    awful.button({ 'Any' }, 1, helpers.focus_or_minimize),
    awful.button({ 'Any' }, 4, function(c) c.focus.byidx(-1) end),
    awful.button({ 'Any' }, 5, function(c) c.focus.byidx(1) end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = gears.table.join(
     awful.button({}, 1, function(t) t:view_only() end),
     awful.button({}, 3, helpers.move_if_focused),
     awful.button({ superkey }, 3, helpers.toggle_if_focused),
     awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
     awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
)


-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = gears.table.join(
    -- Left button - move
    awful.button({}, 1, helpers.move_under_pointer),
    -- Middle button - close
    awful.button({}, 2, helpers.close_under_pointer),
    -- Right button - resize
    awful.button({}, 3, helpers.resize_under_pointer),
    -- Side button up - toggle floating
    awful.button({}, 9, helpers.toggle_floating_under_pointer)
)
-- }}}

-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
