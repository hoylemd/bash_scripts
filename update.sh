INSTALLCMD=""
MYREMOTE=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

git co -q master

git fetch origin
if [ $? -gt 0 ]; then
  exit 2
fi

git merge origin/master
if [ $? -gt 0 ]; then
  exit 3
fi

if [ -n "$MYREMOTE" ]; then
  ./push-upstream.sh
fi

git co $branch

if [ "$1" ]; then
  if [ "-r" == "$1" ]; then
    git rebase master
  fi
fi

./install.sh
