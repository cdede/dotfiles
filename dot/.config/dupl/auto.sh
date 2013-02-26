#!/bin/dash
tmp_chrom()
{
  rsync -av --delete ~/.config/chromium.ro /tmp
}
path2=~/.config/dupl
xrdb -m $path2/Xresources 
xmodmap $path2/xmodmaprc
xset -dpms
xset b off
xset s off
! pgrep xbindkeys && xbindkeys -fg $path2/xbind.scm  &
dex -a 
tmp_chrom &
eval $(cat ~/.fehbg)
