################################################################################
#  Add user packages to RPM database after update
################################################################################

cernvm_start() {
  if ls /var/lib/cernvm-update/run/*.rpm >/dev/null 2>&1; then
    echo
    for PKG in /var/lib/cernvm-update/run/*.rpm; do
      echo -n "Re-registering ${PKG}... "
      rpm -i --justdb --replacefiles --oldpackage "$PKG"
      if [ $? -eq 0 ]; then
        rm -f "$PKG"
        echo "OK"
      fi
    done
  fi
}

cernvm_stop() {
  :
}
