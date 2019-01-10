#!/usr/bin/fish

#set images /home/tor/Изображения/wallpaper/*;
#set imgsize (ls -1 /home/tor/Изображения/wallpaper/ | wc -l);
#echo $imgsize;
feh --bg-scale (random choice ~/Pictures/wallpaper/*);
