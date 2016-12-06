###########################################################################
# Fix cvmfs_config to deal with mount point lists on /mnt/.rw/cvmfs
###########################################################################

cernvm_start () {
  (cd /usr/bin; patch --batch -p0 < /etc/cernvm/cvmfs_config.patch >/dev/null 2>&1)
}

cernvm_stop () {
  true
}
