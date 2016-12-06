###########################################################################
# Fix cvmfs_config to deal with mount point lists on /mnt/.rw/cvmfs
###########################################################################

cernvm_start () {
  (cd /usr/bin; \
    patch --batch --no-backup-if-mismatch -p0 < /etc/cernvm/cvmfs_config.patch >/dev/null 2>&1 ||
    patch --batch --no-backup-if-mismatch -p0 < /etc/cernvm/cvmfs/cvmfs_config_v2.patch)
}

cernvm_stop () {
  true
}
