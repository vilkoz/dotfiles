#!/usr/bin/fish

setxkbmap -layout us
# if xrandr -q | grep " connected" | grep -q VIRTUAL
# 	disable_external_monitor
# end
betterlockscreen -l
notify-send "slock end"
setxkbmap -layout us,ru -option grp:win_space_toggle
# if xrandr -q | grep " connected" | grep -q VIRTUAL
# 	enable_external_monitor
# end
