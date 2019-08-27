local wibox = require "wibox"
local awful = require "awful"

kbdcfg = {
  cmd     = "setxkbmap",
  layout  = { "us", "de" },
  current = 1,
  widget  = wibox.widget.textbox()
}

kbdcfg.switch = function()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_markup('<b><span foreground="white" font="Monospace">' .. t .. '</span></b>')
  os.execute(kbdcfg.cmd .. " " .. t)
end

kbdcfg.widget:set_markup('<b><span foreground="white" font="Monospace">' .. kbdcfg.layout[kbdcfg.current] .. '</span></b>')

kbdcfg.widget:buttons(awful.util.table.join(awful.button({}, 1, function()
  kbdcfg.switch()
end)))

return kbdcfg
