# The script should be sourced by /bin/sh or similar
if [ x"$CONDOR_CONFIG" = x ]
then 
  CONDOR_CONFIG="/etc/condor/condor_config"
  export CONDOR_CONFIG
fi

