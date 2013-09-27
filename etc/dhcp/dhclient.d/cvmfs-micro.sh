#!/bin/sh

cvmfs-micro_config() {
  fqrn=$(attr -qg fqrn /mnt/.ro)  
  nameserver=$(grep ^nameserver /etc/resolv.conf | head -n1 | awk '{print $2}')
  echo -n "nameserver set $nameserver" | /mnt/.rw/aux/busybox nc local:/mnt/.rw/cache/${fqrn}/cvmfs_io.${fqrn} > /dev/null
}

cvmfs-micro_restore() {
 :
}

