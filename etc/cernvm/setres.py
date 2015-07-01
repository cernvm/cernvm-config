#!/usr/bin/python2

# Script to set the resolution in xorg.conf
# takes one input var



import sys
import xf86config


if len(sys.argv) <= 1:
    print "Usage: setres.py 1024x768"
    sys.exit(1)

#Now check the format is 1024x768 or not
spargv=sys.argv[1].split('x')

OK=False

if len(spargv)==2:
    try:
        i1=int(spargv[0])
        i2=int(spargv[1])
    except ValueError:
        pass
    else:
        OK=True

if not OK:
    print "Usage: setres.py 1024x768"
    sys.exit(1)
    
(xconfig,xconfigpath)=xf86config.readConfigFile()

am=xf86config.getPrimaryScreen(xconfig)

am.display[0].modes[0].name=sys.argv[1]

xconfig.write(xconfigpath)
