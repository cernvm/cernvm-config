if [ "x$CERNVM_ORGANISATION" != "x" ]
then
  cvmfs_groups=`echo $CERNVM_ORGANISATION | awk '{printf("%s",tolower($1))}' | sed -e 's/,/ /g'`
  [ "$CERNVM_GRID_UI" == "on" ] && cvmfs_groups="$cvmfs_groups grid"
  [ "$CERNVM_SFT" == "on" ] && cvmfs_groups="$cvmfs_groups sft"
fi

CVMFS_REPOSITORIES=${CVMFS_REPOSITORIES:=$cvmfs_groups}
