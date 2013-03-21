#!/usr/bin/python
from filecmp import cmp
import subprocess
import os
import sys
import shutil

def getconf():
    xdg = os.getenv('XDG_CONFIG_HOME') or os.path.join(os.getenv('HOME'), '.config')
    conffile = os.path.join(xdg, 'backup', 'config.py')
    if not os.access(conffile, os.R_OK):
        print('no conf file found')
        sys.exit(1)
    exec(compile(open(conffile).read(), conffile, 'exec'))
    return (locals()['cmds'])

class CopyOrMv(object):
    """"""
    
    def __init__(self, cmd, filename):
        self.cmd=cmd
        self.filename=filename
        self.filename1=filename+'.new'

    def start(self ):
        handler = open(self.filename1, 'w')
        handler.write(subprocess.getoutput(self.cmd))
        handler.close()
        if os.path.isfile(self.filename) and cmp(self.filename1,self.filename):
            os.remove(self.filename1)
        else:
            shutil.move(self.filename1,self.filename)
        return 

def main():
    tmp1 = getconf()
    for cmd,filename in tmp1.items():
        cp1=CopyOrMv(cmd,filename)
        cp1.start()

if __name__ == '__main__':
    main()
