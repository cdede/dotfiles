#!/bin/dash
spectrwm &
wmpid=$!
~/.config/dupl/auto.sh 
wait $wmpid
exec tail -f /dev/null
