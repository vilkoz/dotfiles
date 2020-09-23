#!/usr/bin/fish

while true
	xdotool mousemove_relative 10 0
	xdotool mousemove_relative -- -10 0
	sleep 1
end
