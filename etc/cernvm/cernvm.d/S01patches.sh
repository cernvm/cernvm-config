###########################################################################
# Patch binaries
###########################################################################

cernvm_start () {
  if [ -d /etc/cernvm/patches.d ]; then
    cd /etc/cernvm/patches.d
    find . ! -name CONTENT -type f | while read FILE; do
      if [ -f "/$FILE" ]; then
        if [ "$FILE" -nt "/$FILE" ]; then
          cp -a "$FILE" "/$FILE"
        fi
      fi  
    done
  fi
}

cernvm_stop () {
  true
}
