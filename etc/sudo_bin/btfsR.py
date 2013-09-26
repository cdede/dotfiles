#!/usr/bin/python
from optparse import OptionParser
import sys,os
import getpass

class BtrfsRecur(object):
    def __init__(self ,flag, reverse):
        lst1 = ['__active','__snapshot'] 
        if reverse:
            self.ACTI_NAME = lst1[1]
            self.SNAP_NAME = lst1[0]
        else:
            self.ACTI_NAME = lst1[0]
            self.SNAP_NAME = lst1[1]
        self.PREFIX = 'btrfs subvolume '
        self.part = ['usr','var','etc']
        self.cmds = []
        self.flag = flag

    @property
    def cond(self):
        if self.flag == 'delete':
            return os.path.exists(self.SNAP_NAME)
        else:
            return os.path.exists(self.ACTI_NAME) and not os.path.exists(self.SNAP_NAME)
    
    def _run(self):
        print(str(self))
        if getpass.getuser() == 'root' and self.cond:
            in1 = input ('are you sure   (y/n) : ')
            if in1 == 'y':
                for str1 in self.cmds:
                    os.system(str1)
    
    def __str__(self):
        s1=''
        for str1 in self.cmds:
            s1+=str1+"\n"
        return s1

    def _do_part(self):
        for i in self.part:
            sn1 = "%s/%s" % (self.SNAP_NAME,i)
            if self.flag == 'delete':
                self.cmds.append("%s %s %s" % (self.PREFIX,self.flag, sn1))
            else:
                self.cmds.append("rmdir %s " % ( sn1))
                self.cmds.append("%s %s %s/%s %s" % (self.PREFIX,self.flag,self.ACTI_NAME,i,sn1))

    def start(self):
        if self.flag == 'delete':
            self._do_part()
            self.cmds.append("%s %s %s/" % (self.PREFIX,self.flag,self.SNAP_NAME))
        else:
            self.cmds.append("%s %s %s/ %s/" % (self.PREFIX,self.flag,self.ACTI_NAME,self.SNAP_NAME))
            self._do_part()
        self._run()

    
def main():
    parser = OptionParser()
    parser.add_option("-d", "--delete", action="store_true", 
                      help="delete", default=False)
    parser.add_option("-s", "--snapshot", action="store_true", 
                      help="snapshot", default=False)
    parser.add_option("-r", "--reverse", action="store_true", 
                      help="reverse", default=False)
    parser.add_option("-b", "--boot", action="store_true", 
                      help="cp boot", default=False)
    (options, args) = parser.parse_args()
    if options.delete:
        flag = 'delete'
    elif options.snapshot:
        flag = 'snapshot'  
    elif options.boot:
        rt1 = os.system('cmp /boot{,/old}/vmlinuz-linux')
        if rt1 != 0:
            os.system('cp -i /boot/{vmlinuz-linux,initramfs*.img} /boot/old')
        sys.exit()
    else:
        sys.exit()
    b1 = BtrfsRecur(flag, options.reverse)
    b1.start()

if __name__ == '__main__':
    main()
