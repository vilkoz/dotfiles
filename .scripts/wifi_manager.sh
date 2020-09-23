#!/bin/bash

WIFI_INTERFACE=wlo1
AP_FILES_FOLDER=~/.wifi_manager

containsElement () {
	match=$1
	for e in $2;
	do
		[[ "$e" == "$match" ]] && return 0
	done
	return 1
}

check_ap_files_folder() {
	if [ ! -d $AP_FILES_FOLDER ]; then
		mkdir -p $AP_FILES_FOLDER
	fi
}

write_static_ip_to_ap_file() {
	name=$1
	until echo $IP | grep -Eqo "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$"; do
		read -p "Enter your IP: " IP
	done
	until echo $NETMASK | grep -Eqo "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$"; do
		read -p "Enter your NETMASK: " NETMASK
	done
	until echo $GATEWAY | grep -Eqo "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$"; do
		read -p "Enter your GATEWAY: " GATEWAY
	done
	echo "#wifi_manager!:IP:$IP" >> "$name"
	echo "#wifi_manager!:NETMASK:$NETMASK" >> "$name"
	echo "#wifi_manager!:GATEWAY:$GATEWAY" >> "$name"
}

create_ap_file() {
	name=$1
	key_mgmt=$2
	read -p "Enter passphrase: " psk
	check_ap_files_folder
	cat <<EOF > "$AP_FILES_FOLDER/\"$name\".conf"
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel
network={
   ssid="$name"
   scan_ssid=1
   key_mgmt=$key_mngmt
   psk="$psk"
}
EOF
	read -p "Use DHCP? (Y/n)" choice
	case "$choice" in 
		y|Y ) ;;
		n|N ) write_static_ip_to_ap_file "$AP_FILES_FOLDER/\"$name\".conf";;
		* ) ;;
	esac
}

create_or_open_ap_file() {
	name=$1
	key_mgmt=$2
	check_ap_files_folder
	if [ ! -f $AP_FILES_FOLDER/\"$name\".conf ]; then
		create_ap_file $name $key_mgmt
	else
		until echo $choice | grep -Eqo "^[YyNn]$"; do
			read -p "Config file for \"$name\" exists use it? (Y/n)" choice
			case "$choice" in 
				y|Y ) ;;
				n|N ) create_ap_file $name $key_mgmt;;
				"" ) choice="Y";;
				* ) ;;
			esac
		done
	fi
	echo $AP_FILES_FOLDER/\"$name\".conf
}

config_get_static_ip() {
	config=$1
	IP=$(grep "#wifi_manager!:IP:" $config)
	IP=${IP/\#wifi_manager\!:IP:/}
	NETMASK=$(grep "#wifi_manager!:NETMASK:" $config)
	NETMASK=${NETMASK/\#wifi_manager\!:NETMASK:/}
	GATEWAY=$(grep "#wifi_manager!:GATEWAY" $config)
	GATEWAY=${GATEWAY/\#wifi_manager\!:GATEWAY:/}
	if [[ ! "$IP" = "" ]] && [[ ! $NETMASK = ""  ]] && [[ ! $GATEWAY = ""  ]]; then
		echo "$IP|$NETMASK|$GATEWAY"
	fi
}

sudo -v
AP_LIST=$(sudo iwlist $WIFI_INTERFACE scan \
	| grep -E "ESSID|(IE: .*WPA)|Authentication Suites|Quality" \
	| tr "\n" "|" \
	| tr -d " " \
	| sed "s/Quality/\nQuality/g")

declare -A _ap_list

AP_LIST_NUM=0
i=0
for ap in $AP_LIST; do
	name=$(echo $ap | grep -Eo "ESSID.*\".*\"" | grep -Eo '".*"')
	name=$(echo $name | sed "s/^\"\|\"\$//g")
	if echo $ap | grep -Eq "WPA.*PSK"; then
		key_mngmt="WPA-PSK"
	else
		key_mngmt="Unsupported see \`man wpa_supplicant\`"
	fi
	signal_num=$(echo $ap \
		| grep -Eo "Quality=[0-9]+\/[0-9]+")
	signal_num=${signal_num/Quality\=/}
	_ap_list["$i|name"]=$name
	_ap_list["$i|key_mngmt"]=$key_mngmt
	_ap_list["$i|signal_num"]=$signal_num
	i=$(( $i+1 ))
done
AP_LIST_NUM=$i

print_ap_list() {
	echo -e "NUM|NAME|SECURITY|SIGNAL"
	for i in $(seq 0 $(($AP_LIST_NUM-1))); do
		echo -e "$i:|${_ap_list["$i|name"]}|\
${_ap_list["$i|key_mngmt"]}|\
${_ap_list["$i|signal_num"]}"
	done
}

print_ap_list | column -s '|' -t

check_saved_ap_files() {
	SAVED=$(cat $AP_FILES_FOLDER/* \
		| grep 'ssid="' \
		| grep -Eo '".*"' \
		| sed "s/^\"\|\"\$//g")
	for i in $(seq 0 $(($AP_LIST_NUM-1))); do
		if containsElement ${_ap_list["$i|name"]} "${SAVED[@]}"; then
			echo $i
			break
		fi
	done
}

network_num=$(check_saved_ap_files)
read -p "Found config for ${_ap_list["$network_num|name"]}, use it (Y/n): " choice
#choice="Y"
case "$choice" in 
	y|Y ) ;;
	n|N ) network_num="wrong";;
	* ) ;;
esac

while echo $network_num | grep -vqE "^[0-9]+|h$"; do
	read -p "Select network from list or (h) to enter hidden (0): " network_num
	if [[ "$network_num" = "" ]]; then
		network_num=0
	fi
	if [[ "$network_num" = "h" ]]; then
		read -p "Enter network ESSID: " name
		read -p "Enter network SECURITY Protocol (WPA-PSK): " key_mgmt
		if [[ "$key_mgmt" = "" ]]; then
			key_mgmt="WPA-PSK"
		fi
		_ap_list["h|name"]=$name
		_ap_list["h|key_mngmt"]=$key_mngmt
	fi
	if (( $network_num >= $AP_LIST_NUM )); then
		echo "wrong number $network_num, it should be < $AP_LIST_NUM"
		network_num="wrong"
	fi
done

echo USING CONFIG FOR \'${_ap_list["$network_num|name"]}\'

CONFIG_FILE=$(create_or_open_ap_file ${_ap_list["$network_num|name"]} ${_ap_list["$network_num|key_mngmt"]})
if [[ $CONFIG_FILE = "" ]]; then
	echo "Wrong config file!"
	exit 1
fi

sudo killall wpa_supplicant > /dev/null
sudo rm -f /var/run/wpa_supplicant/$WIFI_INTERFACE > /dev/null

sudo wpa_supplicant -i wlo1 -c $CONFIG_FILE -B

IP_CONFIG=$(config_get_static_ip $CONFIG_FILE)

if [[ ! "$IP_CONFIG" = "" ]]; then
	IFS="|" read -ra ADDR <<< "$IP_CONFIG"
	sudo ifconfig $WIFI_INTERFACE ${ADDR[0]} netmask ${ADDR[1]}
	sudo route add default gw ${ADDR[2]} $WIFI_INTERFACE
else
	sudo dhcpcd --waitip 4 $WIFI_INTERFACE
fi
