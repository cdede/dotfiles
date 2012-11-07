#!/bin/dash

path2=$XDG_CONFIG_HOME/dupl
path1=~/.config/priv1
xset -dpms
xrdb -m $path2/Xresources 
setxkbmap -option terminate:ctrl_alt_bksp
xmodmap $path2/xmodmaprc
xset b off
xset s off
! pgrep xbindkeys && xbindkeys -fg $path2/xbind.scm  &
fcitx -d
feh --bg-scale $path1/background.png
