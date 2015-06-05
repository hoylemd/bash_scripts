INSTALLCMD=""
MYREMOTE=""
set -x

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

rebase=false
if [ "$1" ]; then
  if [ "-r" == "$1" ]; then
    rebase=true
  fi
fi

git co master
git fetch origin
git merge origin/master

./push-upstream.sh

git co $branch

if [ $rebase ]; then
  git rebase master
fi

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
