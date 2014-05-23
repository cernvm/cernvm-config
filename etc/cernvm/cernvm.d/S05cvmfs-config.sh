###########################################################################
# Patch binaries
###########################################################################

cernvm_start () {
  if [ -d /etc/cvmfs/default.d ]; then
    cat /dev/null > /etc/cvmfs/default.d/75-cernvm.conf
    for f in /etc/cernvm/default.conf /etc/cvmfs/site.conf /etc/cernvm/site.conf; do
      if [ -f $f ]; then
       cat $f >> /etc/cvmfs/default.d/75-cernvm.conf
      fi
    done
  fi
}

cernvm_stop () {
  true
}
