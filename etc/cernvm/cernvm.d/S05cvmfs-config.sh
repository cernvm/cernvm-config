###########################################################################
# Patch binaries
###########################################################################

cernvm_start () {
  if [ -d /etc/cvmfs/default.d ]; then
    cat /etc/cernvm/default.conf /etc/cvmfs/site.conf /etc/cernvm/site.conf > /etc/cvmfs/default.d/75-cernvm.conf
  fi
}

cernvm_stop () {
  true
}
