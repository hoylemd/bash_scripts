INSTALLCMD=""
MYREMOTE=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

git co master
git fetch origin
if [ $? -gt 0 ]; then
  exit $?
fi

git merge origin/master
if [ $? -gt 0 ]; then
  exit $?
fi

./push-upstream.sh

git co $branch

if [ "$1" ]; then
  if [ "-r" == "$1" ]; then
    git rebase master
  fi
fi

./install.sh
