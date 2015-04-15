ENV=""
SERVICENAME=""
RUNCMD=""

source .fgrc

if [ -n "$SERVICENAME" ]; then
  sudo supervisorctl stop $SERVICENAME
fi

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD
fi
