INSTALLCMD=""
MYREPOSITORY=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREPOSITORY" ]; then
  MYREPOSITORY=mhoyle
fi

git co master
git fetch origin
git merge origin/master
git push -u $MYREPOSITORY master

git co $branch

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
