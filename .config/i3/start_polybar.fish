#!/usr/bin/fish

set ispolybaractive (ps aux | grep "polybar example" | grep -v grep)

if test -n "$ispolybaractive"
	echo "stoping polybar";
	killall polybar;
else
	echo "starting polybar";
	polybar example &;
end
