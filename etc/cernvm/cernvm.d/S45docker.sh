cernvm_start () {
  if [ "x$CERNVM_USER" = "x" ]; then
    return 0
  fi

  if ! groups $CERNVM_USER | grep -q '\bdocker\b'; then
    usermod -aG docker $CERNVM_USER
  fi
}

cernvm_stop () {
  true
}


