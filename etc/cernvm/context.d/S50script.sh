###########################################################################
# Run contextualizatioon script if required
###########################################################################

context_start () {
  # Run it only once per boot
  local marker_file=/run/cernvm/contextualization_command.executed
  # amiconfig forces execution
  if [ "x$1" != "xforce" ]; then
    [ -f $marker_file ] && return 0 || true
  fi
  mkdir -p $(dirname $marker_file)
  touch $marker_file

  if [ "x$CERNVM_CONTEXTUALIZATION_COMMAND" != "x" ]
  then
       entry="$CERNVM_CONTEXTUALIZATION_COMMAND"
       user=`echo $entry | sed 's/\(^[a-z]*\):\(.*\)/\1/'`
       cmd=`echo $entry | sed 's/\(^[a-z]*\):\(.*\)/\2/'`
       script=`echo $cmd | awk '{print $1}'`
       uid=`id -u $user 2> /dev/null`
       if [ $uid -ge 500 ]
       then
          su - $user -c "$cmd > /dev/null 2>&1 &" 
       fi
  fi
}

context_stop () {
  true
}

