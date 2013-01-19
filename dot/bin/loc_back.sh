#!/bin/bash
cmp_or_mv(){
 #  $1 filename
 #  $2 cmd
  f2=$1
  f1=$1.new
  shift
  cmd=$*
  cmd1=$cmd">$f1"
  eval $cmd1
  cmp -s $f1 $f2
  if [ $? -eq 0  ] ;then
    rm $f1
  else
    mv $f1 $f2
  fi

}
pushd ~/.config/priv1
set -- $(getopt s:lvmb "$@" )
while [ $# -gt 0 ]
do
    case "$1" in
    (-l) 
      f1=pkg_`date "+%Y"`.list
      c1='pacman -Qqe | grep -vx "$(pacman -Qqm)"'
      cmp_or_mv $f1 $c1
      c1='pacman -Qq'
      f1=pkg_aur_`date "+%Y"`.list
      cmp_or_mv $f1 $c1
      f1=aur_`date "+%Y"`.list
      c1='pacman -Qqm' 
      cmp_or_mv $f1 $c1
      ;;
    (-v) 
      f1=video
      c1='find ~/Downloads/video -maxdepth  2 -print' 
      cmp_or_mv $f1 $c1
      ;;
    (-b)
      f1=init_sign
      c1='sha256sum `ls -1 -t /media/boot_ro/*.img`'
      cmp_or_mv $f1 $c1
      cmp -s ~/.config/priv2/test.kdb  /media/boot_ro/.mirror/test.kdb || echo "(WW) not same "
      ;;
    (-s)
      f1=wz9hJi6.gz.gpg
      gpg -o - $f1 |zcat  | sed -n "$(expr $2 + 1),+1p"
       shift
      ;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

popd
