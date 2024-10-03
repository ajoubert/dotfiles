local awful = require("awful")

local _screen = {}

_screen.focus_next_screen = function()
  local s = awful.screen.focused({ mouse = false, client = true })
  local next_screen = s.index % screen.count() + 1
  awful.screen.focus(next_screen)
end

_screen.focus_previous_screen = function()
  local s = awful.screen.focused()
  local previous_screen = (s.index - 2) % screen.count() + 1
  awful.screen.focus(previous_screen)
end

_screen.focus_next_screen_no_roll = function()
  local s = awful.screen.focused()
  if s.index == screen.count() then
    return
  end
  local next_screen = s.index % screen.count() + 1
  awful.screen.focus(next_screen)
end

_screen.focus_previous_screen_no_roll = function()
  local s = awful.screen.focused()
  if s.index == 1 then
    return
  end
  local previous_screen = (s.index - 2) % screen.count() + 1
  awful.screen.focus(previous_screen)
end

_screen.focus_direction = function(d)
  if d == "left" then
    _screen.focus_previous_screen_no_roll()
  elseif d == "right" then
    _screen.focus_next_screen_no_roll()
  end
end

return _screen
