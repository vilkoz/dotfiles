
alias ls='ls --color=auto'
alias lsd='ls -ld .*'
alias lls='ls -alFh --color=auto'
# alias grep='grep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias egrep='egrep --color=auto'
# alias grep='grep --colour=auto'
alias pac='sudo pacman -S'
alias pacs='sudo pacman -Ss'
alias pacu='sudo pacman -Syyu'
alias pacr='sudo pacman -R'
alias sevavnc='ssh eva@192.168.0.132 -L 5900:loacalhost:5900 "x11vnc -noxdamage"'
alias sevaadmvnc='ssh admin@192.168.0.132 -L 5900:loacalhost:5900 "x11vnc -noxdamage"'
alias soundwire='/home/tor/Загрузки/SoundWireServer/SoundWireServer -p 59010 -verbose '
alias minecraft='java -jar /home/tor/Загрузки/Minecraft.jar'
alias weather='curl wttr.in'
alias yt='auracle search'
alias wakeupeva='ssh eva@192.168.0.132 "DISPLAY=:0 xfce4-terminal --fullscreen --hide-menubar --hide-borders -x python3 /home/eva/tox/Wake-up-Neo/wake.py -C green"'
alias gcom='gcc -o new -Wextra -Werror -Wall'
#BITCHX CONF
export IRCNICK=vilko
export IRCUSER=vilko
export IRC_HOST=coloringless.com
export IRCNAME='bolgedor'
export IRCSERVER=irc.freenode.net
#stdheader conf
#export USER=vrybalko
#export MAIL=vrybalko@student.unit.ua
# default gui browser for mutt
export BROWSER=firefox
export EDITOR=vim

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias tre='translate-shell -s Russian -t English'
alias ter='translate-shell'
alias veramount='sudo veracrypt "/home/tor/.fun/vera1" /mnt/veracrypt1'
alias veraunmount='sudo veracrypt -d'
alias homevncstart='ssh tor@192.168.0.2'
alias wake_home='wol 40:61:86:eb:ab:58'
alias android_local='ssh 192.168.0.165 -p 8022'
alias android_not_so_local='ssh 93.72.232.240 -p 8022'
alias rr='ranger'

alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"
alias sstatus="sudo systemctl status"
alias srestart="sudo systemctl restart"

alias py-lyrics="/home/tor/git/py-lyrics/lyrics"

alias git='hub'

alias octave="octave --force-gui"
alias sbcl="sbcl --noinform"

alias getsploit="~/Downloads/getsploit/getsploit.py"
alias fpush="git add -u; git commit -m fast_push; git push"
alias copy="tmux show-buffer | xclip -selection clipboard"
function vimo
	echo vim +(tmux show-buffer | cut -d ":" -f 2) (tmux show-buffer | cut -d ":" -f 1)
	vim +(tmux show-buffer | cut -d ":" -f 2) (tmux show-buffer | cut -d ":" -f 1)
end
set -x GDK_DPI_SCALE 1.5
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
