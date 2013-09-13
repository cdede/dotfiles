#!/usr/bin/python
import uuid
import os
import tempfile
import subprocess
import gzip
from pwd import getpwnam
import json
cf1  = '/etc/sudo_bin/oath_gen.json'
PASS = '-'

def main():
    with open(cf1,'r') as f1:
        c1 = json.load(f1)
    USER = c1['user']
    WIDTH = c1['width']
    key1 = c1['key']
    OATH_AUTH_FILE=c1['file']
    uid1 = getpwnam(USER).pw_uid
    gid1 = getpwnam(USER).pw_gid
    key = uuid.uuid4().hex
    ret1 = "HOTP %s %s %s" % (USER,PASS, key)
    with open(OATH_AUTH_FILE, 'w') as f1:
        f1.write(ret1)
    out1 = subprocess.getoutput("oathtool -w %d %s" % (WIDTH, key))
    with tempfile.NamedTemporaryFile() as f2:
        fname = f2.name
        os.chmod(fname, 0o600)
        with gzip.GzipFile(fname, 'wb') as f:
            f.write(out1.encode("utf-8"))
        os.chown(fname, uid1,gid1)
        os.system("su  -c 'gpg --no-tty --batch -er  %s  %s' %s" %(key1, fname, USER))
    fname += '.gpg'
    os.system("echo 'keep it' | mail -s 'not rm !!!' -a %s %s" % (fname,USER))
    os.unlink(fname)

if __name__ == '__main__':
    main()
