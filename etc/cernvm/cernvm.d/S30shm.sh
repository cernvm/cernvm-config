###########################################################################
# modules.sh: load list of kernel module (if they exist)
###########################################################################

cernvm_start () {
   if ! grep -q /dev/shm /proc/mounts; then
     umount /dev/shm 2>/dev/null
     mount /dev/shm 2>/dev/null
   fi
   chmod ugo+rwxt /dev/shm
}

cernvm_stop () {
  true
}


