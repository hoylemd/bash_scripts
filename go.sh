ENV=""
SUPERVISOR=""
SERVICENAME=""
RUNCMD=""

source .fgrc

if [ -n "$SERVICENAME" ]; then
  if [ -z "$SUPERVISOR" ] || [ "$SUPERVISOR" == "supervisorctl" ]; then
    sudo supervisorctl stop $SERVICENAME
  elif [ "$SUPERVISOR" == "init.d" ]; then
    sudo /etc/init.d/$SERVICENAME stop
  elif [ "$SUPERVISOR" == "service" ]; then
    sudo service $SERVICENAME stop
  elif [ "$SUPERVISOR" == "custom" ]; then
    ./$SERVICENAME
  fi
fi

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD
fi
