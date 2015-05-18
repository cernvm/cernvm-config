###########################################################################
# vmwaretools.sh: Install VMware tools
###########################################################################

cernvm_start () { 
  (
    local adapter
    if [ x$CERNVM_TOOLS_CONFIGURED != x`uname -r` ]; then
        if [ ! -x /sbin/lspci ]; then
            echo "Error: /sbin/lspci not found. Please install pciutils package";
            exit 1;
        fi;
        adapter=`/sbin/lspci 2>/dev/null | grep "VGA.*controller"`;
        if [ -x /usr/X11R6/bin/X -o -x /usr/bin/X ]; then
            case $adapter in 
                *VMware*)
	                [ -s /etc/X11/xorg.conf ] && rm -f /etc/X11/xorg.conf
                        if [ ! -s /etc/X11/xorg.conf ]; then
                            if [ -f /etc/X11/xorg.conf.vmware.cernvm ]; then
                                cp -f /etc/X11/xorg.conf.vmware.cernvm /etc/X11/xorg.conf;
                                /etc/cernvm/config -x
                            fi;
                            cp /etc/cernvm/vmtools.desktop /etc/xdg/autostart/
                            echo "modprobe vmhgfs" >>/etc/rc.modules;
                            chmod +x /etc/rc.modules;
                            /sbin/modprobe vmblock >/dev/null 2>&1;
                            /sbin/modprobe vmhgfs >/dev/null 2>&1;
                            /sbin/chkconfig --add vmware-guestd
                            /sbin/service vmware-guestd start
                            echo "CERNVM_TOOLS_CONFIGURED=`uname -r`" >>/etc/cernvm/tools.conf;
                        fi;
                    if [ ! -f /sbin/mount.vmhgfs ]; then
                        if [ -f /usr/sbin/mount.vmhgfs ]; then
                            ln -s /usr/sbin/mount.vmhgfs /sbin/mount.vmhgfs;
                        fi;
                    fi
                ;;
                *)
                ;;
            esac;
        fi;
    fi
    if [ `/sbin/lsmod | grep -c vmhgfs` -gt 0 ]
    then
        if [ -f /etc/cernvm/site.conf ]
        then
           . /etc/cernvm/site.conf
           if [ "x$CERNVM_USER" != "x" ]
           then
             uid=`id -u $CERNVM_USER`
             gid=`id -g $CERNVM_USER`
             mkdir -p /mnt/shared/$CERNVM_USER
             chown ${CERNVM_USER}:${CERNVM_USER} /mnt/shared/${CERNVM_USER} > /dev/null 2>&1 
             mount -t vmhgfs  -o rw,ttl=1,uid=$uid,gid=$gid .host:/ /mnt/shared/${CERNVM_USER} > /dev/null 2>&1 || true
           fi
        fi
    fi
  )
}

cernvm_stop () {
  true
}
