#!/bin/bash

#cd ~/.scripts/scop; ./scop res/statue/statue.obj &
i3-msg workspace 1;
i3-msg workspace 8;
i3-msg workspace 2;
i3-msg workspace 9;
setxkbmap -layout us
i3lock -c 000000
setxkbmap -layout us,ru -option grp:win_space_toggle
