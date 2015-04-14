ENV=""
RUNCMD=""

source .fgrc

if [ -n "$ENV" ]; then
  source $ENV/bin/activate
fi

if [ -n "$RUNCMD" ]; then
  $RUNCMD
fi
