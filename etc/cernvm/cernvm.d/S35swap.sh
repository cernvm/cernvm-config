###########################################################################
# Create and activate swap space
###########################################################################

cernvm_start () {
  if [ -f /mnt/.rw/swapfile ]; then
    swapon /mnt/.rw/swapfile >/dev/null 2>&1
  fi
}

cernvm_stop () {
  true
}


