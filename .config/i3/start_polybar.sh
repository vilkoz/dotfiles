#!/usr/bin/zsh
temp=$(ps aux | grep i3 | grep -v grep | tr -d "\n");
temp2=$(ps aux | grep polybar | grep -v grep | grep -v start_polybar.sh | tr -d "\n");
[[ -n $temp && ! -n $temp2 ]] && polybar example &
