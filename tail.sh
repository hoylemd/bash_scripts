LOGPATH=""
source .fgrc

if [ -e "$LOGPATH" ]; then
  tail -f $LOGPATH
else
  echo 'No log to tail :(. Please add it to LOGPATH in .fgrc.'
fi

