###########################################################################
# Fix /dev
###########################################################################

cernvm_start () {
  umount /dev/pts 2>/dev/null
  umount /dev/shm 2>/dev/null
  mount -t devtmpfs devtmpfs /dev
  mkdir -p /dev/shm
  mount /dev/pts /dev/shm
}

cernvm_stop () {
  true
}


