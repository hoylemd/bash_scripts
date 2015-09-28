#!/bin/bash

ENV=""
SUPERVISOR=""
SERVICENAME=""
RUNCMD=""
PROD_FLAGS=""
DEV_FLAGS=""
CLEANPATTERN=""

source .fgrc

flags=$DEV_FLAGS
# check for -p or --production flag
if [ "$1" == "-p" ] || [ "$1" == "--production" ]; then
  flags=$PROD_FLAGS
fi

if [ -n "$SERVICENAME" ]; then
  if [ -z "$SUPERVISOR" ] || [ "$SUPERVISOR" == "supervisorctl" ]; then
    sudo supervisorctl stop $SERVICENAME
  elif [ "$SUPERVISOR" == "init.d" ]; then
    sudo /etc/init.d/$SERVICENAME stop
  elif [ "$SUPERVISOR" == "service" ]; then
    sudo service $SERVICENAME stop
  elif [ "$SUPERVISOR" == "custom" ]; then
    $SERVICENAME
  fi
fi

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

if [ -n "$CLEANPATTERN" ]; then
  rm -rf $CLEANPATTERN
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD $flags
fi
