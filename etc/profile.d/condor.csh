# The script should be sourced by /bin/csh or similar
if ( ! $?CONDOR_CONFIG ) then
  setenv CONDOR_CONFIG "//etc/condor/condor_config"
endif
