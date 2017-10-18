for name in (cat ~/.config/i3/startup_list)
	echo "starting $name";
	fish -c "eval $name" &;
	echo "$name on background";
end
