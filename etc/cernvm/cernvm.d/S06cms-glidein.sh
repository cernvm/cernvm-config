###########################################################################
# Write CMS_LOCAL_SITE from glideinWMS contextualization
###########################################################################

cernvm_start () {
  # /etc/cvmfs/site.conf overwrites the GeoAPI proxy but can be overwritten by
  # amiconfig contextualization
  if [ -f /etc/cvmfs/site.conf ]; then
    if grep -q ^CMS_LOCAL_SITE /etc/cvmfs/site.conf; then
      return 0;
    fi 
  fi

  if [ -f /tmp/glideinwms-user-data ]; then
    glidein_startup="$(cat /tmp/glideinwms-user-data | cut -d'#' -f 1 | base64 -d | grep ^args | head -n 1)"
    cernvm_cms_site="$(echo $glidein_startup | grep param_CERNVM_CMS_SITE | sed -r 's/.* -param_CERNVM_CMS_SITE ([^ ]+).*/\1/')"
    echo "CMS_LOCAL_SITE=$cernvm_cms_site" >> /etc/cvmfs/site.conf
  fi
}

cernvm_stop () {
  true
}
