#!/bin/bash
back_files()
{ 
  pacman -Qqe | grep -vx "$(pacman -Qqm)">pkg.list
  pacman -Qq>pkg_aur.list
  pacman -Qqm>aur.list
  find ~/Downloads/video -maxdepth  2 -print>video
  sha256sum `ls -1 -t /media/boot_ro/*.img`>init_sign
}
pushd ~/.config/priv1
set -- $(getopt s:lb "$@" )
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
      gpg -o - $f1 |zcat  | sed -n "$(expr $2 + 1),+1p"
       shift
      ;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

popd
