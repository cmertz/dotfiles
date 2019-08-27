  local gears     = require('gears')
  local awful     = require('awful')
  local wibox     = require('wibox')
  local beautiful = require('beautiful')
  local naughty   = require('naughty')
  local wallpaper = require('wallpaper')

  require('awful.autofocus')

  local conf_dir = awful.util.getdir('config')
  beautiful.init(conf_dir .. '/theme.lua')

  function set_wallpaper(s)
    local wp = wallpaper.random(beautiful.wallpaper_dir)
    if wp ~= nil then
      gears.wallpaper.maximized(wp, s, false)
    end
  end

  awful.screen.connect_for_each_screen(set_wallpaper)

  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal('property::geometry', set_wallpaper)

  terminal = "/usr/bin/alacritty --live-config-reload --config-file=/home/chris/.config/alacritty/alacritty.yml"
  modkey   = 'Mod4'

  package.path = package.path .. ';' .. conf_dir .. '?.lua;'

  local xkb      = require('xkb')
  local clock    = require('clock')
  local volume_widget = require('volume')


  -- Create a wibox for each screen and add it
  mywibox = {}
  mypromptbox = {}
  mytaglist = {}
  mytaglist.buttons = awful.util.table.join(awful.button({ }, 1, function(t) t:view_only() end))

  mytasklist = {}
  mytasklist.buttons = awful.util.table.join(
                       awful.button({ }, 1, function (c)
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
                                                    c:raise()
                                                end
                                            end))

  awful.screen.connect_for_each_screen(function(s)

      -- Create a promptbox for each screen
      mypromptbox[s] = awful.widget.prompt()

      -- Create a taglist widget
      mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

      layout = awful.layout.suit.fair
      if s.geometry.height > s.geometry.width then
        layout = awful.layout.suit.fair.horizontal
      end

      awful.tag({'1'}, s, layout)

      -- Create a tasklist widget
      mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, mytasklist.buttons)

      -- Create the wiboxbg_wibar
      --
      -- set nonsense bg to prevent it taking effect
      mywibox[s] = awful.wibar({bg = beautiful.bg_wibar, position = 'top', screen = s })

      -- Add widgets to the wibox
      mywibox[s]:setup {
          layout = wibox.layout.align.horizontal,
          { -- Left widgets
              layout = wibox.layout.fixed.horizontal,
              mytaglist[s],
              mypromptbox[s],
          },
          mytasklist[s], -- Middle widget
          { -- Right widgets
              layout = wibox.layout.fixed.horizontal,
              wibox.widget.systray(),

              {
                xkb.widget,
                layout = wibox.container.margin,
                left = 10
              },
              {
                volume_widget,
                layout = wibox.container.margin,
                top = 2,
                bottom = 2,
                left = 10
              },
              {
                clock,
                layout = wibox.container.margin,
                left = 10
              }
          },
      }
  end)
  -- }}}

  -- {{{ Key bindings
  globalkeys = awful.util.table.join(
    awful.key({ modkey, 'Control' }, 'r', awesome.restart, {description='restart awesome', group='awesome'}),
    awful.key({ modkey, }, 'l', function() awful.spawn('/usr/local/lib/screenlock') end, {description='lock screen', group='awesome'}),
    awful.key({ modkey, }, 't', function() awful.spawn('/usr/local/lib/toggle-transparency') end, {description='toggle transparency', group='awesome'}),

    awful.key({ modkey, }, 'Left',   awful.tag.viewprev, {description='view previous tag', group='tag'}),
    awful.key({ modkey, }, 'Right',  awful.tag.viewnext, {description='view next tag', group='tag'}),
    awful.key({ modkey, }, 'Escape', awful.tag.history.restore, {description='jump to last tag', group='tag'}),

    awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end, {description='raise volume', group='media'}),
    awful.key({}, 'XF86AudioLowerVolume', function()   awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end, {description='lower volume', group='media'}),
    awful.key({}, 'XF86AudioMute', function() awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end, {description='toggle mute', group='media'}),

    -- awful.key({}, 'XF86AudioPlay', mpd.toggle_play, {description='toggle music play/pause', group='media'}),
    -- awful.key({}, 'XF86AudioNext', mpd.play_next, {description='play next song', group='media'}),
    -- awful.key({}, 'XF86AudioPrev', mpd.play_prev, {description='play previous song', group='media'}),

    awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn('sudo backlight -10') end, {description='decrease backlight', group='screen'}),
    awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn('sudo backlight +10') end, {description='increase backlight', group='screen'}),

    awful.key({ modkey, }, 'w', function()
      awful.client.focus.global_bydirection('up')
      awful.screen.focus(client.focus.screen)
    end, {description='select next client to the top', group='client'}),
    awful.key({ modkey, }, 'a', function()
      awful.client.focus.global_bydirection('left')
      awful.screen.focus(client.focus.screen)
    end, {description='select next client to the left', group='client'}),
    awful.key({ modkey, }, 's', function()
      awful.client.focus.global_bydirection('down')
      awful.screen.focus(client.focus.screen)
    end, {description='select next client to the bottom', group='client'}),
    awful.key({ modkey, }, 'd', function()
      awful.client.focus.global_bydirection('right')
      awful.screen.focus(client.focus.screen)
    end, {description='select next client to the right', group='client'}),

    awful.key({ modkey, }, 'Tab',
      function()
        c = client.focus
        n = awful.client.next(1)

        -- no other client to switch focus to
        if not n then
          return
        end

        c.fullscreen = false

        awful.client.focus.byidx(1)
      end, {description='cycle through clients', group='client'}),
    awful.key({ modkey, 'Control' }, 'n', function()
      c = awful.client.restore()
      if c == nil then
        return
      end

      c:jump_to()
    end, {description='restore minimized clients', group='client'}),

    awful.key({ modkey, }, 'Return', function ()
      awful.spawn(
        terminal,
        {
          tag = mouse.screen.selected_tag,
        }
      )
    end, {description='spawn new terminal', group='launcher'}),

    awful.key({ modkey },  'r', function () mypromptbox[awful.screen.focused()]:run() end, {description='open promptbox', group='launcher'}),
    awful.key({ modkey, 'Control' }, 'Return', function()
                        local screen = awful.screen.focused()
                        if #screen.tags >= 9 then
                          return
                        end
                        local i = #screen.tags + 1
                        local t = awful.tag({i}, screen, awful.layout.suit.fair)
                        screen.tags[i]:view_only()
    end, {description='spawn new tag', group='awesome'})
  )

  clientkeys = awful.util.table.join(
      awful.key({ modkey,           }, 'f',
          function (c)
            if c.fullscreen then
              local others = awful.client.iterate(function(o)
                if c == o then
                  return false
                end

                if not o:isvisible() then
                  return false
                end

                if not o.fullscreen then
                  return false
                end

                if not o.screen == c.screen then
                  return false
                end

                for _, tag in ipairs(o:tags()) do
                  for _, cur in ipairs(c:tags()) do
                    if tag == cur then
                      return true
                    end
                  end
                end

                return false
              end)

              for other in others do
                other.fullscreen = false
                other.maximized_horizontal = false
                other.maximized_vertical = false
              end
            end

            c.fullscreen = not c.fullscreen
            c:raise()
          end),
      awful.key({ modkey, 'Shift'   }, 'c',      function (c) c:kill()                         end,
                {description = 'close', group = 'client'}),
      awful.key({ modkey,           }, 'n',
          function (c)
              -- The client currently has the input focus, so it cannot be
              -- minimized, since minimized clients can't have the focus.
              c.minimized = true
          end,
          {description = 'minimize', group = 'client'}
      )
  )

  for i = 1, 9 do
      globalkeys = awful.util.table.join(globalkeys,
          -- View tag only.
          awful.key({ modkey }, '#' .. i + 9,
                    function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]

                      for _, t in ipairs(screen.tags) do
                        if t ~= tag and #t:clients() == 0 then
                          t:delete()
                        end
                      end

                      for i, t in ipairs(screen.tags) do
                        t.name = i
                      end

                      if #screen.tags == 0 then
                        awful.tag({'1'}, s, layout)
                      end

                      if tag then
                        tag:view_only()
                      end
                    end,
                    {description = 'view tag #'..i, group = 'tag'}),
          -- Move client to tag.
          awful.key({ modkey, 'Shift' }, '#' .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                       end
                    end,
                    {description = 'move focused client to tag #'..i, group = 'tag'})
      )
  end

  root.keys(globalkeys)

  clientbuttons = awful.util.table.join(
      awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
      awful.button({ modkey }, 1, awful.mouse.client.move),
      awful.button({ modkey }, 3, awful.mouse.client.resize)
  )

  awful.rules.rules = {

    -- match all rule - general properties
    {
      rule = {},
      properties = {
        border_width     = beautiful.border_width,
        border_color     = beautiful.border_normal,
        focus            = awful.client.focus.filter,
        keys             = clientkeys,
        buttons          = clientbuttons,
        raise            = true,
        size_hints_honor = false,
        placement        = awful.placement.no_overlap+awful.placement.no_offscreen,
      }
    },

    -- chromium maximization workaround
    {
      rule = {
        class = 'Chromium'
      },
      callback = function(c)
        c.maximized, c.maximized_vertical, c.maximized_horizontal = false, false, false
      end
    },

    -- floating stuff
    { rule_any = {
      class = { 'Arandr', 'Pinentry' },
      name = { 'Event Tester' },
      role = {
        'AlarmWindow',  -- Thunderbird's calendar.
        'pop-up',       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    }, properties = { floating = true }},
  }
  -- }}}

  -- {{{ Signals
  -- Signal function to execute when a new client appears.
  client.connect_signal('manage', function (c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    if not awesome.startup then
      awful.client.setslave(c)
    end
  end)

  client.connect_signal('mouse::enter', function(c) client.focus = c end)
