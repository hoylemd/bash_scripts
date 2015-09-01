ENV=""
INSTALLCMD=""
source .fgrc

source $ENV/bin/activate

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
