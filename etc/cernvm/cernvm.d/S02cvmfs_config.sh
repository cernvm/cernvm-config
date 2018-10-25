###########################################################################
# Fix cvmfs_config to deal with mount point lists on /mnt/.rw/cvmfs
###########################################################################

cernvm_start () {
  (cd /usr/bin; \
    patch --batch --no-backup-if-mismatch -p0 < /etc/cernvm/cvmfs_config.patch >/dev/null 2>&1 ||
    patch --batch --no-backup-if-mismatch -p0 < /etc/cernvm/cvmfs_config_v2.patch)

  # /etc/cvmfs/site.conf overwrites the old geolist.txt proxy but can be overwritten by
  # amiconfig contextualization
  if [ -f /mnt/.rw/context/ucontext ]; then
    grep ^_UCONTEXT_CVMFS_HTTP_PROXY= /mnt/.rw/context/ucontext | sed s/^_UCONTEXT_// >> /etc/cvmfs/site.conf
    grep ^_UCONTEXT_CVMFS_PAC_URLS= /mnt/.rw/context/ucontext | sed s/^_UCONTEXT_// >> /etc/cvmfs/site.conf
  else
    local wpad_server_list="http://wlcg-wpad.cern.ch/wpad.dat http://wlcg-wpad.fnal.gov/wpad.dat"
    local wpad_servers=$(echo $wpad_server_list | tr ' ' '\n' | shuf | tr '\n' ';' | sed 's/;$//')
    echo "CVMFS_PAC_URLS=\"http://grid-wpad/wpad.dat;http://wpad/wpad.dat;${wpad_servers}\"" >> /etc/cvmfs/site.conf
    echo "CVMFS_HTTP_PROXY=\"auto;DIRECT\"" >> /etc/cvmfs/site.conf
  fi
}

cernvm_stop () {
  true
}
