#!/usr/bin/python
from filecmp import cmp
from optparse import OptionParser
import subprocess
import os
import shutil

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
    parser = OptionParser()
    parser.add_option('-c', '--cmd', dest='cmd', default='', help='cmd ')
    parser.add_option('-f', '--filename', dest='filename', default='', help='filename ')
    (options, args) = parser.parse_args()
    cp1=CopyOrMv(options.cmd,options.filename)
    cp1.start()

if __name__ == '__main__':
    main()
