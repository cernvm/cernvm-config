###########################################################################
# CernVM specific cvmfs configuration
###########################################################################

cernvm_start () {
  # /etc/cvmfs/site.conf overwrites the GeoAPI proxy but can be overwritten by
  # amiconfig contextualization
  if [ -f /mnt/.rw/context/ucontext ]; then
    grep ^_UCONTEXT_CVMFS_HTTP_PROXY= /mnt/.rw/context/ucontext | sed s/^_UCONTEXT_// >> /etc/cvmfs/site.conf
    grep ^_UCONTEXT_CVMFS_PAC_URLS= /mnt/.rw/context/ucontext | sed s/^_UCONTEXT_// >> /etc/cvmfs/site.conf
  fi
  
  if [ -d /etc/cvmfs/default.d ]; then
    rm -f /etc/cvmfs/default.d/75-cernvm.conf
    ln -sf /etc/cernvm/default.conf /etc/cvmfs/default.d/75-cvmdefault.conf
    ln -sf /etc/cvmfs/site.conf /etc/cvmfs/default.d/76-site.conf
    ln -sf /etc/cernvm/site.conf /etc/cvmfs/default.d/77-cvmsite.conf
  fi
}

cernvm_stop () {
  true
}
