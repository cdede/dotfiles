
(xbindkey
   '(mod4 shift p) 
   "sleep 1 ;scrot -s ")

(xbindkey 
   '(mod4 p) 
   "scrot ")

(xbindkey 
   '(mod4 z)  
   " amixer -q set Master 4%+")

(xbindkey 
   '(mod4 s)  
   " amixer -q set Master 4%-")

(xbindkey 
   '(mod4 c)  
   " xdotool click 3")

(xbindkey 
   '(mod4 shift c)  
   " xdotool click 2")

(xbindkey 
   '(mod4 shift z) 
   "i3lock -c  000000 -u")

(xbindkey 
   '(mod4 r) 
   "dmenu_run")

(xbindkey 
   '(mod4 shift a) 
   "chromium ")

(xbindkey 
   '(mod4 shift s) 
   "xterm -class Screen -e screen -xRRS xterm")

