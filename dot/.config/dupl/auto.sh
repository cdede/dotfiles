#!/bin/dash
path2=$XDG_CONFIG_HOME/dupl
xrdb -m $path2/Xresources 
xmodmap $path2/xmodmaprc
xset -dpms
xset b off
xset s off
! pgrep xbindkeys && xbindkeys -fg $path2/xbind.scm  &
dex -a 
eval $(cat ~/.fehbg)
