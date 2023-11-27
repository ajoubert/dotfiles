-- Functions that you use more than once and in different files would
-- be nice to define here.

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local icons = require("icons")
local naughty = require("naughty")
local t = require("config/tags")

local helpers = {}

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

helpers.squircle = function(rate, delta)
    return function(cr, width, height)
        gears.shape.squircle(cr, width, height, rate, delta)
    end
end
helpers.psquircle = function(rate, delta, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partial_squircle(cr, width, height, tl, tr, br, bl, rate, delta)
    end
end

helpers.colorize_text = function(text, color)
    return "<span foreground='"..color.."'>"..text.."</span>"
end

function helpers.client_menu_toggle()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = dpi(250) } })
        end
    end
end

-- Escapes a string so that it can be displayed inside pango markup
-- tags. Modified from:
-- https://github.com/kernelsauce/turbo/blob/master/turbo/escape.lua
function helpers.pango_escape(s)
    return (string.gsub(s, "[&<>]", {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;"
    }))
end

function helpers.vertical_pad(height)
    return wibox.widget{
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function helpers.horizontal_pad(width)
    return wibox.widget{
        forced_width = width,
        layout = wibox.layout.fixed.horizontal
    }
end

local direction_translate = {
    ['up'] = 'top',
    ['down'] = 'bottom',
    ['left'] = 'left',
    ['right'] = 'right'
}
function helpers.move_to_edge(c, direction)
    local old = c:geometry()
    local new = awful.placement[direction_translate[direction]](c, {honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2, pretend = true})
    if direction == "up" or direction == "down" then
        c:geometry({ x = old.x, y = new.y })
    else
        c:geometry({ x = new.x, y = old.y })
    end
end

local double_tap_timer = nil
function helpers.single_double_tap(single_tap_function, double_tap_function)
    if double_tap_timer then
        double_tap_timer:stop()
        double_tap_timer = nil
        double_tap_function()
        -- naughty.notify({text = "We got a double tap"})
        return
    end

    double_tap_timer =
        gears.timer.start_new(0.20, function()
            double_tap_timer = nil
            -- naughty.notify({text = "We got a single tap"})
            if single_tap_function then
                single_tap_function()
            end
            return false
        end)
end


-- Used as a custom command in rofi to move a window into the current tag
-- instead of following it.
-- Rofi has access to the X window id of the client.
function helpers.rofi_move_client_here(window)
    local win = function (c)
        return awful.rules.match(c, {window = window})
    end

    for c in awful.client.iterate(win) do
        c.minimized = false
        c:move_to_tag(mouse.screen.selected_tag)
        client.focus = c
    end
end

-- Tag back and forth:
-- If you try to focus the tag you are already at, go back to the previous tag.
-- Useful for quick switching after for example checking an incoming chat
-- message at tag 2 and coming back to your work at tag 1 with the same
-- keypress.
function helpers.tag_back_and_forth(tag_index)
    local s = mouse.screen;
    local tag = s.tags[tag_index]
    if tag then
        if tag == s.selected_tag then
            awful.tag.history.restore()
        else
            tag:view_only()
        end
    end
end

-- Resize DWIM (Do What I Mean)
-- Resize client or factor
-- Constants --
local floating_resize_amount = dpi(20)
local tiling_resize_factor= 0.05
---------------
function helpers.resize_dwim(c, direction)
    if c and c.floating then
        if direction == "up" then
            c:relative_move(  0,  0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(  0,  0, 0,  floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(  0,  0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(  0,  0,  floating_resize_amount, 0)
        end
    elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact( tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact( tiling_resize_factor)
        end
    end
end

-- Move client DWIM (Do What I Mean)
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function helpers.move_client_dwim(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        helpers.move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- Make client floating and snap to the desired edge
local axis_translate = {
    ['up'] = 'horizontally',
    ['down'] = 'horizontally',
    ['left'] = 'vertically',
    ['right'] = 'vertically'
}
function helpers.float_and_edge_snap(c, direction)
    c.maximized = false
    c.maximized_vertical = false
    c.maximized_horizontal = false
    c.floating = true
    local f = awful.placement.scale
        + awful.placement[direction_translate[direction]]
        + awful.placement['maximize_'..axis_translate[direction]]
    f(c, {honor_padding = true, honor_workarea=true, to_percent = 0.5, margins = beautiful.useless_gap * 2 })
end

-- Rounds a number to any number of decimals
function helpers.round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end


function helpers.send_key(c, key)
    awful.spawn.with_shell("xdotool key --window "..tostring(c.window).." "..key)
end

function helpers.send_key_sequence(c, seq)
    awful.spawn.with_shell("xdotool type --delay 5 --window "..tostring(c.window).." "..seq)
end

function helpers.fake_escape()
    root.fake_input('key_press', "Escape")
    root.fake_input('key_release', "Escape")
end

local prompt_font = beautiful.prompt_font or "sans bold 8"
function helpers.prompt(action, textbox, prompt, callback)
    if action == "run" then
        awful.prompt.run {
            -- prompt       = prompt,
            prompt       = "<b>Run: </b>",
            textbox      = textbox,
            font = prompt_font,
            done_callback = callback,
            exe_callback = awful.spawn,
            completion_callback = awful.completion.shell,
            history_path = awful.util.get_cache_dir() .. "/history"
        }
    elseif action == "web_search" then
        awful.prompt.run {
            --prompt       = prompt,
            prompt       = '<b>Web search: </b>',
            textbox      = textbox,
            font = prompt_font,
            history_path = awful.util.get_cache_dir() .. "/history_web",
            done_callback = callback,
            exe_callback = function(input)
                if not input or #input == 0 then return end
                awful.spawn.with_shell("noglob "..User.web_search_cmd.."'"..input.."'")
                naughty.notify { title = "Searching the web for", text = input, icon = icons.image.firefox, urgency = "low" }
            end
        }
    end
end

-- Given a `match` condition, returns an array with clients that match it, or
-- just the first found client if `first_only` is true
function helpers.find_clients(match, first_only)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    if first_only then
        for c in awful.client.iterate(matcher) do
            return c
        end
    else
        local clients = {}
        for c in awful.client.iterate(matcher) do
            table.insert(clients, c)
        end
        return clients
    end
    return nil
end

-- Given a `match` condition, calls the specified function `f_do` on all the
-- clients that match it
function helpers.find_clients_and_do(match, f_do)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    for c in awful.client.iterate(matcher) do
        f_do(c)
    end
end

function helpers.run_or_raise(match, move, spawn_cmd, spawn_args)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    -- Find and raise
    local found = false
    for c in awful.client.iterate(matcher) do
        found = true
        c.minimized = false
        if move then
            c:move_to_tag(mouse.screen.selected_tag)
            client.focus = c
        else
            c:jump_to()
        end
        break
    end

    -- Spawn if not found
    if not found then
        awful.spawn(spawn_cmd, spawn_args)
    end
end

-- Run raise or minimize a client (scratchpad style)
-- Depends on helpers.run_or_raise
-- If it not running, spawn it
-- If it is running, focus it
-- If it is focused, minimize it
function helpers.scratchpad(match, spawn_cmd, spawn_args)
    local cf = client.focus
    if cf and awful.rules.match(cf, match) then
        cf.minimized = true
    else
        helpers.run_or_raise(match, true, spawn_cmd, spawn_args)
    end
end

function helpers.float_and_resize(c, width, height)
    c.maximized = false
    c.width = width
    c.height = height
    awful.placement.centered(c,{honor_workarea=true, honor_padding = true})
    awful.client.property.set(c, 'floating_geometry', c:geometry())
    c.floating = true
    c:raise()
end

-- Adds a maximized mask to a screen
function helpers.screen_mask(s, bg)
    local mask = wibox({visible = false, ontop = true, type = "splash", screen = s})
    awful.placement.maximize(mask)
    mask.bg = bg
    return mask
end

-- Useful for periodically checking the output of a command that
-- requires internet access.
-- Ensures that `command` will be run EXACTLY once during the desired
-- `interval`, even if awesome restarts multiple times during this time.
-- Saves output in `output_file` and checks its last modification
-- time to determine whether to run the command again or not.
-- Passes the output of `command` to `callback` function.
function helpers.remote_watch(command, interval, output_file, callback)
    local run_the_thing = function()
        -- Pass output to callback AND write it to file
        awful.spawn.easy_async_with_shell(command.." | tee "..output_file, function(out) callback(out) end)
    end

    local timer
    timer = gears.timer {
        timeout = interval,
        call_now = true,
        autostart = true,
        single_shot = false,
        callback = function()
            awful.spawn.easy_async_with_shell("date -r "..output_file.." +%s", function(last_update, _, __, exitcode)
                -- Probably the file does not exist yet (first time
                -- running after reboot)
                if exitcode == 1 then
                    run_the_thing()
                    return
                end

                local diff = os.time() - tonumber(last_update)
                if diff >= interval then
                    run_the_thing()
                else
                    -- Pass the date saved in the file since it is fresh enough
                    awful.spawn.easy_async_with_shell("cat "..output_file, function(out) callback(out) end)

                    -- Schedule an update for when the remaining time to complete the interval passes
                    timer:stop()
                    gears.timer.start_new(interval - diff, function()
                        run_the_thing()
                        timer:again()
                    end)
                end
            end)
        end
    }
end

-- The directory of the currently executed lua script
-- Requires the `debug` library to be available in the build of Lua that is running
function helpers.this_dir()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end


-- START - custom

function helpers.volume_control(step)
    return function()
        local cmd
        if step == 0 then
            cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
        else
            sign = step > 0 and "+" or ""
            cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."%"
        end
        awful.spawn.with_shell(cmd)
    end
end

function helpers.focus_direction(direction)
    return function()
        local focused_before = client.focus

        if not focused_before then
            client.focus = awful.screen.focused().clients[1]
            if not client.focus then
                helpers.focus_screen_by_direction(direction)()
            end
            return
        end

        awful.client.focus.bydirection(direction)

        local focused_after = client.focus

        if (focused_before.window == focused_after.window) then
            helpers.focus_screen_by_direction(direction)()
        end
    end
end

function helpers.focus_screen_by_direction(direction)
    return function()
        awful.screen.focus_bydirection(direction)
    end
end

function helpers.show_window_switcher()
    window_switcher_show(awful.screen.focused())
end

function helpers.increase_gaps()
    awful.tag.incgap(5, nil)
end

function helpers.decrease_gaps()
    awful.tag.incgap(-5, nil)
end

function helpers.jump_urgent()
    local uc = awful.client.urgent.get()
    -- If there is no urgent client, go back to last tag
    if uc == nil then
        awful.tag.history.restore()
    else
        awful.client.urgent.jumpto()
    end
end

function helpers.spawn(to_spawn)
    return function()
        awful.spawn(to_spawn)
    end
end

function helpers.spawn_with_shell(to_spawn)
    return function()
        awful.spawn_with_shell(to_spawn)
    end
end

function helpers.show_exit_screens()
    exit_screen_show()
end

function helpers.restore_minimized()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        client.focus = c
    end
end

function helpers.show_rofi()
    awful.spawn.with_shell("rofi -matching fuzzy -show combi")
end

function helpers.dismiss_all_notifs()
    awesome.emit_signal("elemental::dismiss")
    naughty.destroy_all_notifications()
end

function helpers.set_tiled_layout()
    awful.layout.set(awful.layout.suit.tile)
    helpers.single_double_tap(
        nil,
        function()
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                c.floating = false
            end
        end)
end

function helpers.set_floating_layout()
    awful.layout.set(awful.layout.suit.floating)
end

function helpers.center_with_doubletap(c)
    helpers.single_double_tap(
        awful.placement.centered(c, {honor_workarea = true, honor_padding = true}),
        function ()
            helpers.float_and_resize(c, screen_width * 0.65, screen_height * 0.9)
        end
    )
end

function helpers.toggle_fullscreen(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end

function helpers.toggle_floating_layout(c)
    local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
    if not layout_is_floating then
        awful.client.floating.toggle()
    end
end

function helpers.maximize_vertically(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end

function helpers.maximize_horizontally(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end

function helpers.switch_tag(index)
    return function()
        local screen = awful.screen.focused()
        local tag = t.tags[index]
        if tag then
            t.sharedtags.viewonly(tag, screen)
            -- Yeah, arrays start at 1
            client.focus = awful.screen.focused().clients[1]
        end
    end
end

function helpers.toggle_tag(index)
    return function()
        local screen = awful.screen.focused()
        local tag = t.tags[index]
        if tag then
            t.sharedtags.viewtoggle(tag, screen)
        end
    end
end

function helpers.move_to_tag(index)
    return function()
        local c = client.focus;
        if c then
            local tag = t.tags[index]
            if tag then
                c:move_to_tag(tag)
                if(awful.screen.focused().clients) then
                    client.focus = awful.screen.focused().clients[1]
                else
                end
            end
        end
    end
end

function helpers.show_focus()
    --naughty.notify({text = tostring(awful.screen.focused().index)});
    local clients = awful.screen.focused().clients;
    for _, c in pairs(clients) do
        local text = tostring(awful.client.idx(c).idx) .. " " .. c.name;
        naughty.notify({text = text});
    end
end

function helpers.move_to_screen(direction)
    local c = client.focus;
    local initialScreen = awful.screen.focused();
    local newScreen = initialScreen:get_next_in_direction(direction);
    if c and initialScreen and newScreen then
        c:move_to_screen(newScreen);
        -- Weirdly enough, the new screen cannot be focused (or rather, the
        -- screen gets focused, but the client doesn't, resulting in
        -- a weird experience
        awful.screen.focus(initialScreen);
        if(not next(initialScreen.clients)) then
            awful.screen.focus(newScreen);
            awful.client.focus.byidx(1);
        end
    end
end

function helpers.toggle_tag_on_client(index)
    return function()
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end
end

function helpers.focus_or_minimize(c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
            c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
    end
end

function helpers.move_if_focused(index)
    if client.focus then
     client.focus:move_to_tag(index)
    end
end

function helpers.toggle_if_focused(index)
    if client.focus then
        client.focus:toggle_tag(index)
    end
end

function helpers.move_under_pointer()
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.move(c)
end

function helpers.close_under_pointer()
    local c = mouse.object_under_pointer()
    c:kill()
end

function helpers.resize_under_pointer()
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.resize(c)
end

function helpers.toggle_floating_under_pointer()
    local c = mouse.object_under_pointer()
    client.focus = c
    c.floating = not c.floating
end

function helpers.tag_click(tag)
		local screen = awful.screen.focused()
		t.sharedtags.viewonly(tag, screen)
    -- Yeah, arrays start at 1
    client.focus = awful.screen.focused().clients[1]
end

function helpers.switch_theme(themeName)
    local theme_dir = os.getenv("HOME") .. "/.config/awesome/ui/themes/" .. themeName .. "/"
    beautiful.init(theme_dir .. "theme.lua")
end

return helpers
