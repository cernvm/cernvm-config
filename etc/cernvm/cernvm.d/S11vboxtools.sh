###########################################################################
# vboxtools.sh: Install VirtualBox Guest Additions
###########################################################################

cernvm_start () { 
  ( 
    local adapter
    [ -f /etc/cernvm/tools.conf ] && . /etc/cernvm/tools.conf
    if [ x$CERNVM_TOOLS_CONFIGURED != x`uname -r` ]; then
        if [ ! -x /sbin/lspci ]; then
            echo "Error: /sbin/lspci not found. Please install pciutils package";
            exit 1;
        fi;
        adapter=`/sbin/lspci 2>/dev/null | grep "VGA.*controller"`;
        case $adapter in 
                *VirtualBox*)
                    /usr/sbin/useradd -d /var/run/vboxadd -g 1 -r -s /bin/false vboxadd >/dev/null 2>&1;
                    groupadd -f vboxsf >/dev/null 2>&1
                    echo "KERNEL==\"vboxguest\", NAME=\"vboxguest\",OWNER=\"vboxadd\",MODE=\"0660\"" > /etc/udev/rules.d/60-vboxadd.rules
                    echo "KERNEL==\"vboxuser\", NAME=\"vboxuser\",OWNER=\"vboxadd\",MODE=\"0666\"" >> /etc/udev/rules.d/60-vboxadd.rules
                    if [ -c /dev/vboxguest ]; then
                      chown vboxadd /dev/vboxguest
                      chmod 0660 /dev/vboxguest
                    fi
                    if [ -c /dev/vboxuser ]; then
                      chown vboxadd /dev/vboxuser
                      chmod 0666 /dev/vboxuser
                    fi
                    /sbin/chkconfig --add vboxadd
                    /sbin/chkconfig --add vboxadd-x11
                    /sbin/chkconfig --add vboxadd-service
                    /sbin/service vboxadd start
                    /sbin/service vboxadd-service start
                    # Patch /sbin/VBoxClient for new kernels with new vboxguest kernel module
                    if [ "x$(/sbin/modinfo vboxguest | grep ^version: | awk '{print $2}')" != "x4.3.4" ]; then
                      mv /usr/bin/VBoxClient /usr/bin/VBoxClient.bak
                      ln -s /usr/bin/VBoxClient.4.3.28 /usr/bin/VBoxClient
                      mv /usr/lib64/VBoxGuestAdditions /usr/lib64/VBoxGuestAdditions.bak
                      ln -s /usr/lib64/VBoxGuestAdditions.4.3.28 /usr/lib64/VBoxGuestAdditions
                    fi
                    VBoxControl guestproperty set "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold" 60000
                    if [ $? -eq 0 ]; then
                        echo "CERNVM_TOOLS_CONFIGURED=`uname -r`" >/etc/cernvm/tools.conf;
                        echo "CERNVM_HYPERVISOR=virtualbox" >> /etc/cernvm/tools.conf;
                    fi;
                    if [ -x /usr/X11R6/bin/X -o -x /usr/bin/X ]; then
                      rm -f /etc/X11/xorg.conf
                      if [ ! -f /etc/X11/xorg.conf ]; then
                          if [ -f /etc/X11/xorg.conf.vbox.cernvm ]; then
                            cp -f /etc/X11/xorg.conf.vbox.cernvm /etc/X11/xorg.conf
	 		    /etc/cernvm/config -x
                          fi;
                      fi;
                      /sbin/service vboxadd-x11 setup
                    fi;
                ;;
                *)
                ;;
         esac;
     fi
     if [ "x$CERNVM_HYPERVISOR" = "xvirtualbox" ]; then
       VBoxControl guestproperty set "/VirtualBox/GuestAdd/CheckHostVersion" 0 >/dev/null 2>&1
     fi
     if [ -f /etc/cernvm/site.conf ] 
     then
        . /etc/cernvm/site.conf
        if [ "x$CERNVM_USER" != "x" ] && [ "x$CERNVM_HYPERVISOR" = "xvirtualbox" ]
	then
           modprobe vboxsf
           uid=`id -u $CERNVM_USER`
           gid=`id -g $CERNVM_USER`
           sflist=$(VBoxControl sharedfolder list | grep '^[0-9][0-9]* - ' | awk '{print $3}' | tr '\n' ' ')
           for folder in $sflist; do
             cat /proc/mounts | awk '{print $2}' | grep -q "^/mnt/shared/${folder}$" && continue
             mkdir -p /mnt/shared/${folder}
             chown ${CERNVM_USER}:${CERNVM_USER} /mnt/shared/${folder} > /dev/null 2>&1
             mount -t vboxsf -o uid=$uid,gid=$gid ${folder} /mnt/shared/${folder} > /dev/null 2>&1 || true
           done
        fi
        # Fix xorg.conf
        if [ -f /etc/X11/xorg.conf ]; then
          if grep -q vbox /etc/X11/xorg.conf && grep -q CERNVM_DISPLAY_MODE /etc/X11/xorg.conf
          then
            cp /etc/X11/xorg.conf /etc/X11/xorg.conf.bak
            cp /etc/X11/xorg.conf.vbox.cernvm /etc/X11/xorg.conf
          fi
        fi
     fi
  )
}

cernvm_stop () {
  true
}


cernvm_start
