#!/bin/bash
pushd ~/.config/priv1
set -- $(getopt slb "$@" )
while [ $# -gt 0 ]
do
    case "$1" in
      (-l)
        ~/bin/cpmv.py
        ;;
    (-b)
      gpg -v  ~/.config/priv2/test.kdb.sig  || echo "(WW) not same "
      ;;
    (-s)
      f1=wz9hJi6.gz.gpg

      gpg -o - $f1 |zcat  | sed -n "$(expr $(sudo /etc/sudo_bin/get_oath.sh) + 1),+1p"
       shift
      ;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

popd
