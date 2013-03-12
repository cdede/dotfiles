#!/bin/bash
back_files()
{ 
  cmd1=~/bin/cpmv.py
  $cmd1 -c 'pacman -Qqe | grep -vx "$(pacman -Qqm)"' -f pkg.list
  $cmd1 -c 'pacman -Qq' -f pkg_aur.list
  $cmd1 -c 'pacman -Qqm' -f aur.list
  $cmd1 -c 'find ~/Downloads/video -maxdepth  2 -print' -f video
  $cmd1 -c 'ls -1 -t /media/boot_ro/*.img | xargs sha256sum' -f init_sign
}
pushd ~/.config/priv1
set -- $(getopt slb "$@" )
while [ $# -gt 0 ]
do
    case "$1" in
      (-l)
        back_files
        ;;
    (-b)
      gpg -v  ~/.config/priv2/test.kdb.sig  || echo "(WW) not same "
      ;;
    (-s)
      f1=wz9hJi6.gz.gpg

      gpg -o - $f1 |zcat  | sed -n "$(expr $(awk '{print $5}' /var/difp_oath) + 1),+1p"
       shift
      ;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

popd
