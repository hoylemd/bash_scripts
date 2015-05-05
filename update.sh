INSTALLCMD=""
MYREMOTE=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

git co master
git fetch origin
git merge origin/master

./push-upstream.sh

git co $branch

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
