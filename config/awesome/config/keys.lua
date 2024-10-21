-- local naughty = require("naughty")
local awful = require("awful")
local helpers = require("helpers")
local hotkeys_popup = require("awful.hotkeys_popup")
local naughty = require("naughty")
local _client = require("helpers.client")
local _screen = require("helpers.screen")

local mod = "Mod4"
-- local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"

awful.keyboard.append_global_keybindings({

  -- Dismiss notifications and elements that connect to the dismiss signal

	awful.key({ ctrl }, "space", function() naughty.destroy_all_notifications() end, {description = "dismiss notification", group = "awesome"}),
	awful.key({ mod, ctrl }, "r", function() awful.spawn.with_shell("~/.local/scripts/record_screen.sh") end, {description = "record screen", group = "tool"}),

	awful.key({ mod, shift }, "p", function ()
		helpers.tag.unminimize_tag_clients()
	end, {description = "restore minimized", group = "tag"}),

	-- Background control

	awful.key({ mod }, "b", function() awful.spawn.with_shell("~/.local/scripts/randomBackground.sh") end, {description = "changes wallpaper", group = "tag"}),

	-- launch programms --

	awful.key({ mod }, "Return", function() awful.spawn("alacritty -e sh -c 'tmux attach || tmux new-session'") end, {description = "open terminal", group = "launch"}),
	awful.key({ mod, shift }, "Return", function() awful.spawn("alacritty") end, {description = "open terminal without tmux", group = "launch"}),
	awful.key({ mod, ctrl }, "o", function() awful.spawn.with_shell("~/.local/scripts/openphone.sh", false) end, {description = "phone", group = "launch"}),
	awful.key({ mod }, "e", function() awful.spawn("thunar") end, {description = "file manager", group = "launch"}),
	awful.key({ mod }, "a", function() awful.spawn("ayugram-desktop" or "telegram-desktop") end),

	-- tools --

	awful.key({}, "Print", function() awful.spawn("flameshot gui") end, {description = "screenshot", group = "tool"}),
	awful.key({ mod }, "d", function() awful.spawn.with_shell("~/.local/scripts/monitorhotplug", false) end, {description = "monitor hotplug", group = "tool"}),
	awful.key({ mod, ctrl }, "p", function() awful.spawn.with_shell("~/.local/scripts/colorpicker", false) end, {description = "colorpicker", group = "tool"}),
	awful.key({ mod, ctrl }, "q", function() awful.spawn.with_shell("~/.local/scripts/qr_codes", false) end, {description = "qr codes", group = "tool"}),

  -- screen control

  awful.key({ mod }, "[", function() _screen.focus_previous_screen_no_roll() end, {description = "focus previous screen", group="awesome"}),
  awful.key({ mod }, "]", function() _screen.focus_next_screen_no_roll() end, {description = "focus next screen", group="awesome"}),

	-- Help screen

  awful.key({ mod, shift }, "/", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, {description="show help", group="awesome"}),

	-- playerctl --

	awful.key({}, "XF86AudioPlay", function()
		awful.spawn.with_shell("playerctl play-pause")
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.spawn.with_shell("playerctl previous")
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.spawn.with_shell("playerctl next")
	end),

	-- volume up/down/mute --

	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("amixer sset Master 2%+")
		UpdateVolumeSignals()
		awesome.emit_signal("summon::osd")
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("amixer sset Master 2%-")
		UpdateVolumeSignals()
		awesome.emit_signal("summon::osd")
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("amixer sset Master toggle")
		UpdateVolumeSignals()
		awesome.emit_signal("summon::osd")
	end),

	-- brightness up/down --

	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("brightnessctl s 5%+")
		Update_value_of_bright()
		awesome.emit_signal("summon::osd")
  end),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("brightnessctl s 5%-")
		Update_value_of_bright()
		awesome.emit_signal("summon::osd")
	end),

	-- binds to widgets --

	awful.key({ mod, ctrl }, "b", function() awesome.emit_signal("summon::books") end, {description = "books", group = "tag"}),
	awful.key({ mod, ctrl }, "c", function() awesome.emit_signal("summon::clipboard") end, {description = "clipboard", group = "tag"}),
	awful.key({ mod }, "space", function() awesome.emit_signal("summon::launcher") end, {description = "launcher", group = "launch"}),
	awful.key({ mod }, "x", function() awesome.emit_signal("summon::powermenu") end, {description = "powermenu", group = "launch"}),
	awful.key({ mod }, "m", function() awesome.emit_signal("signal::dnd") end, {description = "dnd", group = "tag"}),
	awful.key({ mod, ctrl }, "w", function() awesome.emit_signal("summon::wifi_popup") end, {description = "wifi popup", group = "tag"}),
	awful.key({ mod }, "n", function() awesome.emit_signal("notif_center::open") end, {description = "notification center", group = "tag"}),
	awful.key({ mod }, "c", function() awesome.emit_signal("time::calendar") end, {description = "calendar", group = "tag"}),
	awful.key({ mod }, "p", function() awesome.emit_signal("profile::control") end, {description = "profile control", group = "tag"}),
	awful.key({ mod, shift }, "b", function() awesome.emit_signal("hide::bar") end, {description = "hide bar", group = "tag"}),
	awful.key({ mod }, "t", function() awesome.emit_signal("show::tray") end, {description = "show tray", group = "tag"}),

  -- Non-awesomewm shortcuts, just to show in help screen

  awful.key({ mod }, "`", function()
    -- [[ configured in settings of keepassxc itself ]]
  end, {description = "KeepassXC autotype", group = "launch"}),

	-- switching a focus client -- 

	awful.key({ mod }, "h", function () helpers.client.focus_direction("left") end, {description = "focus left", group = "client"}),
	awful.key({ mod }, "j", function () helpers.client.focus_direction("down") end, {description = "focus down", group = "client"}),
	awful.key({ mod }, "k", function () helpers.client.focus_direction("up") end, {description = "focus up", group = "client"}),
	awful.key({ mod }, "l", function () helpers.client.focus_direction("right") end, {description = "focus right", group = "client"}),

  -- switch client to next screen
  awful.key({ mod, shift }, "]", function() _client.move_to_next_screen() end, {description = "Move to next screen", group = "client"}),

  awful.key({ mod, shift }, "[", function() _client.move_to_previous_screen() end, {description = "Move to previous screen", group = "client"}),

	-- Close client

	awful.key({ mod }, "w", function()
		if client.focus then
			client.focus:kill()
		end ;
		awful.client.focus.bydirection("left")
	end, {description = "close", group = "client"}),

	-- focus to tag --

	awful.key {
		modifiers = { mod },
		keygroup = "numrow",
		on_press = function (index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end
  },

	-- Toggle focus on tag --

	awful.key {
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		on_press = function (index)
		local screen = awful.screen.focused()
		local tag = screen.tags[index]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end},

	-- move focused client to tag --

	awful.key {
		modifiers = { mod, shift },
		keygroup = "numrow",
		on_press = function (index)
		if client.focus then
			local tag = client.focus.screen.tags[index]
			if tag then
				client.focus:move_to_tag(tag)
			end
		end
	end},

	-- restart wm --

	awful.key({ mod, shift }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),

	-- resize client --

   awful.key({ mod, ctrl }, "k", function()
		helpers.client.resize_client(client.focus, "up")
	end, {description = "resize up", group = "client"}),
	awful.key({ mod, ctrl }, "j", function()
		helpers.client.resize_client(client.focus, "down")
	end, {description = "resize down", group = "client"}),
	awful.key({ mod, ctrl }, "h", function()
		helpers.client.resize_client(client.focus, "left")
	end, {description = "resize left", group = "client"}),
	awful.key({ mod, ctrl }, "l", function()
		helpers.client.resize_client(client.focus, "right")
	end, {description = "resize right", group = "client"}),

	-- change padding tag on fly --

	awful.key({ mod, shift }, "=", function()
		helpers.client.resize_padding(5)
	end, {description = "increase padding", group = "tag"}),
	awful.key({ mod, shift }, "-", function()
		helpers.client.resize_padding(-5)
	end, {description = "decrease padding", group = "tag"}),

	-- change useless gap on fly --

	awful.key({ mod }, "=", function()
		helpers.client.resize_gaps(5)
	end, {description = "increase gaps", group = "tag"}),
	awful.key({ mod }, "-", function()
		helpers.client.resize_gaps(-5)
	end, {description = "decrease gaps", group = "tag"}),

})


-- mouse binds --

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({ }, 1, function (c)
			c:activate { context = "mouse_click" }
		end),
		awful.button({ mod }, 1, function (c)
			c:activate { context = "mouse_click", action = "mouse_move"  }
		end),
		awful.button({ mod }, 3, function (c)
			c:activate { context = "mouse_click", action = "mouse_resize" }
		end),
		awful.button({ }, 10, function (c)
			c.floating = not c.floating
		end),
	})
end)

-- client binds --

client.connect_signal("request::default_keybindings", function()

	awful.keyboard.append_client_keybindings({
		awful.key({ mod }, "f", function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, {description = "fullscreen", group = "client"}),

		awful.key({ mod, shift }, "f", awful.client.floating.toggle, {description = "floating", group = "client"}),

		awful.key({ mod, shift }, "n", function (c)
				c.minimized = true
		end, {description = "minimize", group = "client"}),

		awful.key({ mod, shift }, "m", function (c)
			c.maximized = not c.maximized
			c:raise()
		end, {description = "maximize", group = "client"}),

		-- Move or swap by direction --

		awful.key({ mod, shift }, "k", function(c)
			helpers.client.move_client(c, "up")
		end, {description = "move up", group = "client"}),
		awful.key({ mod, shift }, "j", function(c)
			helpers.client.move_client(c, "down")
		end, {description = "move down", group = "client"}),
		awful.key({ mod, shift }, "h", function(c)
			helpers.client.move_client(c, "left")
		end, {description = "move left", group = "client"}),
		awful.key({ mod, shift }, "l", function(c)
			helpers.client.move_client(c, "right")
		end, {description = "move right", group = "client"}),

		--- Relative move  floating client --

		awful.key({ mod, shift, ctrl }, "j", function(c)
			c:relative_move(0, 20, 0, 0)
		end, {description = "move down", group = "floating controls"}),
		awful.key({ mod, shift, ctrl }, "k", function(c)
			c:relative_move(0, -20, 0, 0)
		end, {description = "move up", group = "floating controls"}),
		awful.key({ mod, shift, ctrl }, "h", function(c)
			c:relative_move(-20, 0, 0, 0)
		end, {description = "move left", group = "floating controls"}),
		awful.key({ mod, shift, ctrl }, "l", function(c)
			c:relative_move(20, 0, 0, 0)
		end, {description = "move right", group = "floating controls"}),

	})

end)


