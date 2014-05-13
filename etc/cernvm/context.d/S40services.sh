###########################################################################
# Start additional system services if required
###########################################################################

context_start () {
  echo
  for service in $(echo "$CERNVM_SERVICES" | sed 's/,/ /g')
  do
    service $service start
  done
}

context_stop () {
  echo
  for service in $CERNVM_SERVICES
  do
    service $service stop
  done
}
