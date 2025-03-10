local awful = require("awful")
local ruled = require("ruled")

-- Rules ----------------

ruled.client.connect_signal("request::rules", function()
  -- global ---------------

  ruled.client.append_rule {
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = false }
  }

  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      size_hints_honor = false,
      screen = awful.screen.preferred,
      placement = function(c)
        awful.placement.centered(c, c.transient_for)
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
      end,
    }
  }
end)

-- user rules ---------------

ruled.client.append_rule {
  rule_any = { class = { "librewolf" } },
  properties = { tag = "1" }
}
ruled.client.append_rule {
  rule_any = { class = { "TelegramDesktop", "AyuGramDesktop" } },
  properties = { tag = "2" }
}
ruled.client.append_rule {
  rule_any = { class = { "Inkscape" } },
  properties = { maximized = false }
}

ruled.client.append_rule {
  rule_any = { class = { "feh", "Zathura" } },
  properties = { fullscreen = true }
}

ruled.client.append_rule {
  rule_any = { class = { "Emulator" } },
  properties = { floating = true }
}

ruled.client.append_rule {
  rule_any = { class = { "Komorebi" } },
  properties = {
    fullscreen = true,
    focusable = false,
    skip_decoration = true,
    border_width = 0,
    below = true,
    skip_taskbar = true,
    ontop = false,
  },
  callback = function(c)
    if not c.name:match("Desktop") then
      c.fullscreen = false;
      c.focusable = true;
    end
  end
}

client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)

-- Center dialogs over screen ----

client.connect_signal('request::manage', function(c)
  if c.transient_for then
    awful.placement.centered(c, c.transient_for)
    awful.placement.no_offscreen(c)
  end
end)
