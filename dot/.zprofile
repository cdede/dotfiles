if [ -d "$HOME/bin" ] ; then
  echo ":$PATH:" | grep :$HOME/bin: || \
    export PATH="$HOME/bin:$PATH"
fi

export XMODIFIERS="@im=fcitx"
#export GTK_IM_MODULE="xim"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS

_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

if [ -z $GPG_AGENT_INFO ] ; then
  eval "$(gpg-agent --daemon)"
fi

eval $(keychain --eval --agents ssh -Q --quiet )

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx >~/.xlog 2>&1 
