###########################################################################
# Patch binaries
###########################################################################

cernvm_start () {
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
