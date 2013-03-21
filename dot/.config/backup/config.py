
cmds = {
        'pacman -Qqe | grep -vx "$(pacman -Qqm)"' : 'pkg.list',
  'pacman -Qq':'pkg_aur.list',
  'pacman -Qqm' : 'aur.list',
  'find ~/Downloads/video -maxdepth  2 -print' : 'video',
  'ls -1 -t /media/boot_ro/*.img | xargs sha256sum' : 'init_sign',
  }
