local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local PATH_TO_ICON = "/usr/share/icons/Arc/status/symbolic/audio-volume-muted-symbolic.svg"

local icon = {
  id = "icon",
  image = PATH_TO_ICON,
  resize = true,
  widget = wibox.widget.imagebox,
}

local volumearc = wibox.widget {
  icon,
  border_width = 0.3,
  border_color = '#000000',
  max_value = 1,
  thickness = 3,
  start_angle = 4.71238898, -- 2pi*3/4
  forced_height = 18,
  forced_width = 18,
  bg = "#ffffff11",
  paddings = 2,
  widget = wibox.container.arcchart
}

local update = function()
  awful.spawn.easy_async('pamixer --get-volume', function(out)
    volumearc.value = tonumber(out) / 100
  end)
  awful.spawn.easy_async('pamixer --get-mute', function(out)
    if string.match(out, '^false') then
      volumearc.colors =  { '#ffffff' }
    else
      volumearc.colors =  { '#000000' }
    end
  end)
end

volumearc:connect_signal("button::press", function(_, _, _, button)
  if (button == 4) then awful.spawn('pamixer --increase 5', false)
  elseif (button == 5) then awful.spawn('pamixer --decrease 5', false)
  elseif (button == 1) then awful.spawn('pamixer --toggle-mute', false)
  end

  update()
end)

gears.timer {
  timeout   = 3,
  call_now  = true,
  autostart = true,
  callback  = update
}

return volumearc
