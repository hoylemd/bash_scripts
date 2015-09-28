AUTOEXEC=""

source .fgrc

if [ -n "$AUTOEXEC" ]; then
  $AUTOEXEC
elif [ -e "fg.sh" ]; then
  ./fg.sh
elif [ -e "update.sh" ]; then
  ./update.sh
fi

