###########################################################################
# Rebuild RPM db with db4 version 8 hashes
###########################################################################

cernvm_start () {
  cd /var/lib/rpm
  local rebuild_db=0
  for dbfile in `find -type f -name "[A-Z]*"`; do
    if [ -f "dump.`basename $dbfile`" ]; then
      rm -f "$dbfile"
      cat "dump.`basename $dbfile`" | db_load $dbfile
      rm -f dump.`basename $dbfile`
      rebuild_db=1
    fi
  done
  if [ $rebuild_db -eq 1 ]; then
    rpm --rebuilddb
  fi
}

cernvm_stop () {
  true
}


