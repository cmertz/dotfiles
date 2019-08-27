local wibox = require("wibox")
local awful = require("awful")

local clock = wibox.widget.textclock('<span font="Monospace">%H:%M </span>')

local now = os.time()
local timediff = os.difftime(now, os.time(os.date("!*t", now)))
local h, m = math.modf(timediff / 3600)
local tz = string.format("%+.4d", 100 * h + 60 * m)

awful.tooltip({
  objects = {clock},
  timer_function = function()
    return os.date('%a %e %B %Y') .. "\n"
    .. os.date("%H:%M:%S") .. "\n"
    .. "UTC " .. tz
  end
})

return clock
