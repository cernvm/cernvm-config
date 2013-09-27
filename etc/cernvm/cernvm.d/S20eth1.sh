###########################################################################
# eth1.sh: create second network interface if needed
###########################################################################

cernvm_start () {
  if [ `lspci 2>/dev/null | grep -c Ethernet` -eq 2 ]
  then 
    if [ ! -f  /etc/sysconfig/network-scripts/ifcfg-eth1 ] 
    then
      cat<<EOF >/etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
BOOTPROTO=dhcp
ONBOOT=yes
TYPE=Ethernet
NM_CONTROLLED=no
EOF
      /etc/init.d/network restart
    fi
    sed -i "s/head -n 1/tail -n 1/g" /etc/init.d/cernvm-release
    /etc/init.d/cernvm-release restart
  fi
}

cernvm_stop () {
  true
}


