ENV=""
SERVICENAME=""
INSTALLCMD=""
RUNCMD=""

source .fgrc

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

sudo supervisorctl stop $SERVICENAME
git co master
git fetch origin
git merge origin/master
if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD
fi
