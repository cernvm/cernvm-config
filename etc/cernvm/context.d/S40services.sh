###########################################################################
# Start additional system services if required
###########################################################################

context_start () {
  echo
  for service in $(echo "$CERNVM_SERVICES" | sed 's/,/ /g')
  do
    systemctl start $service
  done
}

context_stop () {
  :
}
