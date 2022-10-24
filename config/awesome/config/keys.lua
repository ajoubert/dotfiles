local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local gears = require("gears")
local decorations = require("decorations")
local helpers = require("helpers")

local keys = {}

-- Mod keys
local superkey = "Mod4"
local ctrlkey = "Control"
local shiftkey = "Shift"

-- {{{ Key bindings
keys.globalkeys = gears.table.join(

    -- Focus client by direction (hjkl keys)
    awful.key({ superkey }, "j", helpers.focus_direction("down"), {description = "focus down", group = "focus"}),
    awful.key({ superkey }, "k", helpers.focus_direction("up"), {description = "focus up", group = "focus"}),
    awful.key({ superkey }, "h", helpers.focus_direction("left"), {description = "focus left", group = "focus"}),
    awful.key({ superkey }, "l", helpers.focus_direction("right"), {description = "focus right", group = "focus"}),

    -- Change screen focus
    awful.key({ superkey }, "[", helpers.focus_screen_by_direction("left"), {description = "focus left screen", group = "focus"}),
    awful.key({ superkey }, "]", helpers.focus_screen_by_direction("right"), {description = "focus right screen", group = "focus"}),

    -- Window switcher
    awful.key({ superkey }, "Tab", helpers.show_window_switcher, {description = "window switcher", group = "focus"}),

    -- Spawn terminal
    awful.key({ superkey }, "Return", helpers.spawn(User.terminal), {description = "open a terminal", group = "launcher"}),

    -- Run program
    awful.key({ superkey }, " ", helpers.show_rofi, {description = "rofi launcher", group = "launcher"}),

    -- Rofi-password
    awful.key({ superkey }, "p", helpers.spawn("rofi-pass"), {description = "rofi pass", group = "launcher"}),

    -- Reload Awesome
    awful.key({ superkey, shiftkey }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key({ superkey }, "Escape", helpers.show_exit_screens, {description = "quit awesome", group = "awesome"}),
    awful.key({}, "XF86PowerOff", helpers.show_exit_screens),

    -- Dismiss notifications and elements that connect to the dismiss signal
    awful.key({ ctrlkey }, "space", helpers.dismiss_all_notifs, {description = "dismiss notification", group = "awesome"}),

    -- Help screen
    awful.key({ superkey }, "/", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, {description="show help", group="awesome"}),

    -- Toggle tray visibility
    awful.key({ superkey }, "=", function() Tray_toggle() end, {description = "toggle tray visibility", group = "awesome"}),

    -- Toggle sidebar
    awful.key({ superkey }, "grave", function() sidebar_toggle() end, {description = "toggle sidebar visibility", group = "awesome"}),

    -- Volume Control with volume keys, on the bluetooth headset
    -- (un)mute volume
    awful.key({}, "XF86AudioMute", helpers.volume_control(0)),
    -- Lower volume
    awful.key({}, "XF86AudioLowerVolume", helpers.volume_control(-5)),
    -- Raise volume
    awful.key({}, "XF86AudioRaiseVolume", helpers.volume_control(5)),
    awful.key({}, "XF86AudioPlay", helpers.spawn('bash -c $HOME/.local/scripts/mpc_play.sh')),
    awful.key({}, "XF86AudioPause", helpers.spawn('bash -c $HOME/.local/scripts/mpc_pause.sh')),
    awful.key({}, "XF86AudioNext", helpers.spawn('bash -c $HOME/.local/scripts/mpc_next.sh')),
    awful.key({}, "XF86AudioPrev", helpers.spawn('bash -c $HOME/.local/scripts/mpc_prev.sh')),

    -- Bluetooth control
    awful.key({ superkey }, "XF86AudioMute", helpers.spawn('bash -c $HOME/.local/scripts/bluetoothctl_toggle.sh')),
    awful.key({ superkey }, "Print", helpers.spawn('bash -c $HOME/.local/scripts/bluetoothctl_toggle.sh'), {description = "Toggle bluetooth device", group = "hardware"}),

    -- Control virtual machine
    awful.key({ superkey, shiftkey }, "d", helpers.spawn("/home/sloth/.local/share/VFIOinput/input_attach.sh"), {description = "attach keyboard+mouse to virtual machine", group = "hardware"}),

    -- Remote control android phone
    awful.key({ superkey, shiftkey }, "p", helpers.spawn('bash -c $HOME/.local/scripts/openphone.sh'), {description = "remote control android phone", group = "hardware"}),

    -- LAYOUTS

    -- Tiling
    awful.key({ superkey }, "s", helpers.set_tiled_layout, {description = "set tiled layout", group = "tag"}),
    -- Set floating layout
    awful.key({ superkey, shiftkey }, "s", helpers.set_floating_layout, {description = "set floating layout", group = "tag"})
)

keys.clientkeys = gears.table.join(
    -- Toggle titlebars (for focused client only)
    awful.key({ superkey }, "t", decorations.cycle, {description = "toggle titlebar", group = "client"}),

    -- Toggle fullscreen
    awful.key({ superkey }, "f", helpers.toggle_fullscreen, {description = "toggle fullscreen", group = "client"}),

    -- Move client to screen.
    awful.key({ superkey, shiftkey }, "[", function() helpers.move_to_screen("left") end, {description = "move to left screen", group = "client"}),
    awful.key({ superkey, shiftkey }, "]", function() helpers.move_to_screen("right") end, {description = "move to right screen", group = "client"}),

    -- Center client
    awful.key({ superkey }, "c", helpers.center_with_doubletap, {description = "center client", group = "client"}),


    -- Close client
    awful.key({ superkey }, "w", function(c) c:kill(); awful.client.focus.bydirection("left") end, {description = "close", group = "client"}),

    -- Maximize
    awful.key({ superkey }, "m", function (c) c.maximized = not c.maximized end, {description = "toggle maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    local viewDescription = {description = "view tag #"..i, group = "tag"};
    local toggleDescription = {description = "toggle tag #"..i, group = "tag"};
    local moveDescription = {description = "move focused client to tag #"..i, group = "tag"};

    if(i ~= 2) then
        viewDescription = {};
        toggleDescription = {};
        moveDescription = {};
    end

    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9, helpers.switch_tag(i), viewDescription),

        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9, helpers.toggle_tag(i), toggleDescription),

        -- Move client to tag.
        awful.key({ superkey, shiftkey }, "#" .. i + 9, helpers.move_to_tag(i), moveDescription)
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
     awful.button({}, 1, helpers.tag_click),
     awful.button({}, 3, helpers.move_if_focused),
     awful.button({ superkey }, 3, helpers.toggle_if_focused),
     awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
     awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
)

-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = gears.table.join(
    -- Left button - move
    awful.button({}, 1, helpers.move_under_pointer),
    -- Middle button - toggle floating
    awful.button({}, 2, helpers.toggle_floating_under_pointer),
    -- Right button - resize
    awful.button({}, 3, helpers.resize_under_pointer),
    -- Side button up - close
    awful.button({}, 9, helpers.close_under_pointer)
)
-- }}}

root.keys(keys.globalkeys)

return keys
