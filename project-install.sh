ENV=""
INSTALLCMD=""
source .fgrc

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
