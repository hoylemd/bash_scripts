#!/bin/bash

echo 'Updating'
./update.sh

echo 'Running'
ENV=""
SUPERVISOR=""
SERVICENAME=""
RUNCMD=""

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

./tail.sh
