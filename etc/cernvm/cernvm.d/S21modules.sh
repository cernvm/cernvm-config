###########################################################################
# modules.sh: load list of kernel module (if they exist)
###########################################################################

cernvm_start () {
   local modules;
   modules="fuse capability"
   for module in $modules
   do
     /sbin/modprobe $module 2> /dev/null || true
   done
}

cernvm_stop () {
  true
}


