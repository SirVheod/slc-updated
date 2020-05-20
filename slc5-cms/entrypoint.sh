#!/bin/sh
set  -e

export UPDATES=/root/updates
export PATH=${UPDATES}/bin:${PATH}
export LD_LIBRARY_PATH=${UPDATES}/lib:${LD_LIBRARY_PATH}

echo "::: Setting up CMS environment\
 (works only if /cvmfs is mounted on host) ..."
if [ -f /cvmfs/cms.cern.ch/cmsset_default.sh ]; then
  source /cvmfs/cms.cern.ch/cmsset_default.sh
  echo "::: Setting up CMS environment... [done]"
else
  echo "::: Could not set up CMS environment... [ERROR]"
  echo "::: /cvmfs/cms.cern.ch/cmsset_default.sh not found/available"
fi

exec "$@"
