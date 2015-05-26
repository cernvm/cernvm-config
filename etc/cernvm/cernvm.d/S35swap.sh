###########################################################################
# modules.sh: load list of kernel module (if they exist)
###########################################################################

cernvm_start () {
  if [ ! -f /mnt/.rw/swapfile ]; then
    if [ "x$CERNVM_SWAP_SIZE" != "x" ]; then
      if [ "x$CERNVM_SWAP_SIZE" = "xauto" ]; then
        CERNVM_SWAP_SIZE="$(($(nproc)*2))g"
      fi
      fallocate -l "${CERNVM_SWAP_SIZE}" /mnt/.rw/swapfile
      chmod 0600 /mnt/.rw/swapfile
      mkswap /mnt/.rw/swapfile >/dev/null 2>&1
    fi
  fi  

  if [ -f /mnt/.rw/swapfile ]; then
    swapon /mnt/.rw/swapfile
  fi
}

cernvm_stop () {
  true
}


