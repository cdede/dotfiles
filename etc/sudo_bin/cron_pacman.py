#!/usr/bin/python
import sys,os
import getpass
import fileinput
import time
import json
import re

cf1  = '/etc/sudo_etc/cpacman.json'

def check_date(hour_max):
    f1 = '/var/log/pacman.log'
    t1 = 'starting full system upgrade'
    if not os.path.exists(f1) or os.path.getsize(f1) ==0:
        return True
    t2 = ''
    for i in fileinput.input(f1):
        if t1 in i:
            t2 = re.search("^\[(.*?)\]",i).group(1)
    if t2 == '':
        return True
    a2=time.time()
    a1 = time.mktime(time.strptime(t2, "%Y-%m-%d %H:%M"))
    h1 = int((a2-a1)/3600)
    if int(h1 - hour_max) == 0:
        m0 = int((a2-a1)/60)-hour_max*60
        return [ 'm', m0]
    return ['h',h1-hour_max]

class RunCmd(object):
    def __init__(self ,cmds,user = 'root'):
        self.cmds = cmds.split('\n')
        self.user = user

    def run_flag(self):
        ret1 = 0
        for f1 in self.cmds:
            if getpass.getuser() == self.user :
                ret1 += os.system(f1)
            else:
                print(f1)
        return ret1

def main():
    with open(cf1,'r') as f1:
        c1 = json.load(f1)
    hour_max = c1['hours']
    flag = ''
    t0 , tmp1  = check_date(hour_max)
    if tmp1>0:
        n_db = '/tmp/checkup-db-nobody'
        flag = '''su  -s /bin/bash -c checkupdates nobody
cp %s/sync/*.db /var/lib/pacman/sync/
su -s /bin/bash -c ' fakeroot powerpill -Suw --dbpath %s  --cachedir /var/cache/pacman/n_pkg ' nobody
mv /var/cache/pacman/n_pkg/* /var/cache/pacman/pkg
/usr/bin/pacman -Su
''' % ( n_db , n_db)
    else:
        if t0 == 'h':
            print('waiting %.2f hour' % -tmp1)
        elif t0 == 'm':
            print('waiting %d min' % -tmp1)
    if flag != '':
        r1 = RunCmd(flag,'root')
        a1 = r1.run_flag()

if __name__ == '__main__':
    main()
