local awful = require("awful")
local gears = require("gears")
local _screen = require("helpers.screen")
local beautiful = require("beautiful")
local capi = { client = client, mouse = mouse }

local _client = {}

-- Resize client or factor
local floating_resize_amount = 20
local tiling_resize_factor = 0.01
function _client.resize_client(c, direction)
  if c and c.floating or awful.layout.get(capi.mouse.screen) == awful.layout.suit.floating then
    if direction == "up" then
      c:relative_move(0, 0, 0, -floating_resize_amount)
    elseif direction == "down" then
      c:relative_move(0, 0, 0, floating_resize_amount)
    elseif direction == "left" then
      c:relative_move(0, 0, -floating_resize_amount, 0)
    elseif direction == "right" then
      c:relative_move(0, 0, floating_resize_amount, 0)
    end
  elseif awful.layout.get(capi.mouse.screen) ~= awful.layout.suit.floating then
    if direction == "up" then
      awful.client.incwfact(-tiling_resize_factor)
    elseif direction == "down" then
      awful.client.incwfact(tiling_resize_factor)
    elseif direction == "left" then
      awful.tag.incmwfact(-tiling_resize_factor)
    elseif direction == "right" then
      awful.tag.incmwfact(tiling_resize_factor)
    end
  end
end

-- Move client to screen edge, respecting the screen workarea
function _client.move_to_edge(c, direction)
  local workarea = awful.screen.focused().workarea
  if direction == "up" then
    c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
  elseif direction == "down" then
    c:geometry({
      nil,
      y = workarea.height
          + workarea.y
          - c:geometry().height
          - beautiful.useless_gap * 2
          - beautiful.border_width * 2,
      nil,
      nil,
    })
  elseif direction == "left" then
    c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
  elseif direction == "right" then
    c:geometry({
      x = workarea.width
          + workarea.x
          - c:geometry().width
          - beautiful.useless_gap * 2
          - beautiful.border_width * 2,
      nil,
      nil,
      nil,
    })
  end
end

-- Move client DWIM (Do What I Mean)
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function _client.move_client(c, direction)
  if c.floating or (awful.layout.get(capi.mouse.screen) == awful.layout.suit.floating) then
    _client.move_to_edge(c, direction)
  elseif awful.layout.get(capi.mouse.screen) == awful.layout.suit.max then
    if direction == "up" or direction == "left" then
      awful.client.swap.byidx(-1, c)
    elseif direction == "down" or direction == "right" then
      awful.client.swap.byidx(1, c)
    end
  else
    local target_client = awful.client.focus.global_bydirection(direction, c)
    if target_client and target_client.screen == c.screen then
      awful.client.swap.global_bydirection(direction, c, nil)
    else
      -- No client in that direction on that screen, move to next screen
      local adj_screen = awful.screen.focus_bydirection(direction, c.screen)
      if adj_screen and adj_screen ~= c.screen then
        c:move_to_screen(adj_screen)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
      end
    end
  end
end

function _client.centered_client_placement(c)
  return gears.timer.delayed_call(function()
    awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
  end)
end

-- Resize gaps on the fly
_client.resize_gaps = function(amt)
  local t = awful.screen.focused().selected_tag
  t.gap = t.gap + tonumber(amt)
  awful.layout.arrange(awful.screen.focused())
end

-- Resize padding on the fly
_client.resize_padding = function(amt)
  local s = awful.screen.focused()
  local l = s.padding.left
  local r = s.padding.right
  local t = s.padding.top
  local b = s.padding.bottom
  s.padding = {
    left = l + amt,
    right = r + amt,
    top = t + amt,
    bottom = b + amt,
  }
  awful.layout.arrange(awful.screen.focused())
end

_client.move_to_next_screen = function()
  local c = client.focus
  if c then
    local s = c.screen.index + 1
    if s > screen.count() then
      s = 1
    end
    c:move_to_screen(s)
  end
end

_client.move_to_previous_screen = function()
  local c = client.focus
  if c then
    local s = c.screen.index - 1
    if s < 1 then
      s = 1
    end
    c:move_to_screen(s)
  end
end

_client.focus_direction = function(direction)
  local c = client.focus;
  if not c then
    _screen.focus_direction(direction)
    return
  end

  awful.client.focus.global_bydirection(direction, c)
end

_client.cycle_focus = function()
  awful.client.focus.byidx(1)
end

-- Client rules for focus border

client.connect_signal(
  "focus",
  function(c)
    c:raise()
    if #awful.screen.focused().clients > 1 then
      c.border_width = beautiful.border_width
    else
      c.border_width = 0
    end
  end
)

client.connect_signal(
  "unfocus",
  function(c)
    c.border_width = 0
  end
)

return _client
