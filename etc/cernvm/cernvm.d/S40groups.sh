###########################################################################
# Install additional or update groups if needed
###########################################################################

cernvm_start () {
  /etc/cernvm/config -c site
}

cernvm_stop () {
  true
}
