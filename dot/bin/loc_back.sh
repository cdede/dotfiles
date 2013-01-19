#!/bin/bash
cmp_or_mv(){
  cmp -s $1 $2 
  if [ $? -eq 0  ] ;then
    rm $1
  else
    mv $1 $2
  fi

}
path1=~/.config/priv1
set -- $(getopt s:lvmb "$@" )
while [ $# -gt 0 ]
do
    case "$1" in
    (-l) 
      f1=`mktemp`
      cd $path1
      pacman -Qqe | grep -vx "$(pacman -Qqm)">$f1
      cmp_or_mv $f1 pkg_`date "+%Y"`.list
      pacman -Qq >$f1
      cmp_or_mv $f1 pkg_aur_`date "+%Y"`.list
      pacman -Qqm >$f1
      cmp_or_mv $f1 aur_`date "+%Y"`.list
      ;;
    (-v) 
      f1=`mktemp`
      cd ~/Downloads/video
      find . -maxdepth  2 -print >$f1
      cmp_or_mv $f1 $path1/video
      ;;
    (-b)
      f1=`mktemp`
      sha256sum `ls -1 -t /media/boot_ro/*.img`>$f1
      cmp_or_mv $f1 $path1/init_sign
      cmp -s ~/.config/priv2/test.kdb  /media/boot_ro/.mirror/test.kdb || echo "(WW) not same "
      ;;
    (-s)
      f1=$path1/wz9hJi6.gz.gpg
      gpg -o - $f1 |zcat  | sed -n "$(expr $2 + 1),+1p"
       shift
      ;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

