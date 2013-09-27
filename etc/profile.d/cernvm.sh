if [ x"$CERNVM_ENV" = x ]
then 
  for file in /etc/cernvm/default.conf /etc/cernvm/site.conf
  do
    if [ -r $file ]
    then
      eval `sed 's/=\$(.*)//g' $file |  sed -n -e  '/^[^+]/s/\([^=]*\)[=]\(.*\)/\1="\2"; /gp'` 
    fi
  done
  if [ "x$CERNVM_ENVIRONMENT_VARS" != "x" ]
  then 
    for var in $(echo $CERNVM_ENVIRONMENT_VARS | sed 's/+/ /g')
    do
      export $var=${!var}
    done
  fi
  if [ `id -u` -gt 0 -a x"$PS1" != x ]  
  then
    domain=${CERNVM_DOMAIN:=cern.ch}
    if [ "x$CERNVM_ORGANISATION" != "x" ]
    then 
      groups=`echo $CERNVM_ORGANISATION | awk '{printf("%s",tolower($1))}' | sed -e 's/,/ /g' -e 's/^none//'`
      for group in $groups
      do
        if [ `groups | grep -c "\b$group\b"` -eq 1 ] 
        then
          if [ -f /cvmfs/${group}.${domain}/etc/login.sh ] 
          then 
            . /cvmfs/${group}.${domain}/etc/login.sh
          fi
        fi
      done 
    fi
  fi
  export CERNVM_ENV=1
fi
