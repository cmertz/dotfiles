#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# disable beep
xset -b

# enable dpms
xset +dpms

# set dpms times for standby, suspend and off
xset dpms 600 600 600

$HOME/.config/screenlayout/default.sh || true

rm -rf $HOME/.i3.log
exec /usr/bin/i3 >> $HOME/.i3.log
