local dpi     = require("beautiful").xresources.apply_dpi
local awful   = require("awful")
local naughty = require("naughty")

naughty.config.presets.normal.opacity   = 0.8
naughty.config.presets.low.opacity      = 0.8
naughty.config.presets.critical.opacity = 0.8

local theme = {}

theme.font          = "sans 8"
theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = '#2d2d31'
theme.bg_wibar      = 'invalid'
theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"
theme.wallpaper_dir = os.getenv("HOME") .. '/photos'

theme.tasklist_bg_minimize = '#000000'

theme.taglist_bg_focus = '#FFFFFF'
theme.taglist_fg_focus = '#000000'
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = '/usr/share/awesome/themes/zenburn/taglist/squarez.png'

theme.tooltip_opacity = 0.8
theme.tooltip_fg_color = theme.fg_normal
theme.tooltip_bg_color = theme.bg_normal
theme.tooltip_border_width = dpi(1)
theme.tooltip_border_color = '#535d6c'

theme.useless_gap = 1

return theme
