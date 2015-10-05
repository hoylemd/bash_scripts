#!/bin/bash
if [ $? -eq 0 ]; then
  echo 'Running'
  ENV=""
  SUPERVISOR=""
  SERVICENAME=""
  RUNCMD=""

  source .fgrc

  if [ -n "$SERVICENAME" ]; then
    if [ -z "$SUPERVISOR" ] || [ "$SUPERVISOR" == "supervisorctl" ]; then
      sudo supervisorctl stop $SERVICENAME
      sudo supervisorctl start $SERVICENAME
    elif [ "$SUPERVISOR" == "init.d" ]; then
      sudo /etc/init.d/$SERVICENAME stop
      sudo /etc/init.d/$SERVICENAME start
    elif [ "$SUPERVISOR" == "service" ]; then
      sudo service $SERVICENAME stop
      sudo service $SERVICENAME start
    elif [ "$SUPERVISOR" == "custom" ]; then
      $SERVICENAME
    fi
  fi

  ./tail.sh
fi
