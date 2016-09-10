###########################################################################
# Start additional system services if required
###########################################################################

context_start () {
  echo
  for service in $(echo "$CERNVM_SERVICES" | sed 's/,/ /g')
  do
    /bin/systemctl -q enable $service
    /bin/systemctl -q start $service
  done
}

context_stop () {
  :
}
