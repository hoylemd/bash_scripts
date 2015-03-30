ENV=""
SERVICENAME="magnum-ui"
INSTALLCMD="npm install"
RUNCMD="npm start"

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

sudo supervisorctl stop $SERVICENAME
git co master
git fetch upstream
git merge upstream/master
if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD
fi
