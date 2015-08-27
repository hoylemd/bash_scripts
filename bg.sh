#!/bin/bash

echo 'Updating'
./update.sh

echo 'Running'
ENV=""
SUPERVISOR=""
SERVICENAME=""
RUNCMD=""
LOGPATH=""

source .fgrc

if [ -n "$SERVICENAME" ]; then
  if [ -z "$SUPERVISOR" ] || [ "$SUPERVISOR" == "supervisorctl" ]; then
    sudo supervisorctl start $SERVICENAME
  elif [ "$SUPERVISOR" == "init.d" ]; then
    sudo /etc/init.d/$SERVICENAME start
  elif [ "$SUPERVISOR" == "service" ]; then
    sudo service $SERVICENAME start
  elif [ "$SUPERVISOR" == "custom" ]; then
    $SERVICENAME
  fi
fi

if [ -e "$LOGPATH" ]; then
  tail -f $LOGPATH
else
  echo 'No log to tail :(. Please add it to LOGFILE in .fgrc.'
fi
