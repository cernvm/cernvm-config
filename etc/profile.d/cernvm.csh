set id=`id -u`
if ( ! $?CERNVM_ENV ) then
  foreach file (/etc/cernvm/default.conf /etc/cernvm/site.conf /etc/cernvm/environment.conf)
    if ( -r $file ) then
      eval `sed 's/=\$(.*)//g' $file | sed -n -e '/^[^+]/s/\(\\\$[^ ]*\)/"\\\\\1"/' -e '/^[^+]/s/\([^=]*\)[=]\(.*\)/setenv \1 \"\2\";/gp'`
    endif
  end
  if ( $?CERNVM_ENVIRONMENT_VARS ) then
    foreach var (`echo $CERNVM_ENVIRONMENT_VARS | sed 's/+/ /g'`)
      echo setenv $var `eval echo \$$var`
    end
  fi
  if ( $id > 0 ) then
    if ( ! ($?CERNVM_DOMAIN) ) then
      setenv CERNVM_DOMAIN cern.ch
    endif
    set domain=$CERNVM_DOMAIN
    if ( $?CERNVM_ORGANISATION ) then
      set groups=`echo $CERNVM_ORGANISATION | awk '{printf("%s",tolower($1))}' | sed -e 's/,/ /g'  -e 's/^none//'`
      foreach group ( $groups )
         if ( `groups | grep -c "\b$group\b"` == 1 ) then  
             if ( -f /cvmfs/$group.$domain/etc/login.csh )  then
                source /cvmfs/$group.$domain/etc/login.csh
             endif
         endif
      end
    endif
  endif
  setenv CERNVM_ENV 1
endif
