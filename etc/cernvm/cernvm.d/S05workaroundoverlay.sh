###########################################################################
# Move some directories out of the aufs overlay
###########################################################################

cernvm_start () {
  for dir in /srv /var/spool/cvmfs; do
    local rw_dir="/mnt/.rw/$(echo $dir | sed s,^/,, | sed s,/,-,g)"
    mkdir -p $rw_dir

    if [ ! -d $dir ]; then
      ln -s $rw_dir $dir 
    fi

    if [ ! -L $dir ]; then
      [ -f ${dir}/README ] && mv ${dir}/README ${rw_dir}/README
      rmdir $dir
      ln -s $rw_dir $dir 
    fi
  done
}

cernvm_stop () {
  true
}
